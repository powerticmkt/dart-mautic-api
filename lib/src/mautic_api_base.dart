import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';

/// Base Mautic REST API
class MauticAPIBase {
  /// Mautic Base URL
  @protected
  final String _baseurl;

  /// Mautic User Name
  @protected
  final String _username;

  /// Mautic Password
  @protected
  final String _password;

  /// Local Cache Path
  @protected
  String _localPath;

  /// The time to expire local cache in minutes
  @protected
  int _localExpiresMinutes;

  /// Request Response
  @protected
  Response _response;

  /// Request Has Success?
  bool hasSuccess = false;

  /// Data Read from Cache
  bool isCachedData = false;

  /// Request Response body
  @protected
  String responseBody;

  /// Request Responde Headers
  @protected
  Map<String, String> responseHeaders;

  /// Current Mautic Version
  String mauticVersion;

  /// Mautic Users Endpoint
  @protected
  final users_api_endpoint = '/api/users';

  /// Mautic Contacts Endpoint
  @protected
  final contacts_api_endpoint = '/api/contacts';

  @protected
  String current_endpoint;

  /// Constructor
  MauticAPIBase(
    this._baseurl,
    this._username,
    this._password,
    this._localPath,
    this._localExpiresMinutes,
  );

  /// Handle Request Success
  void _handleSuccess(Response response) {
    _writeCache(current_endpoint, response.body);
    hasSuccess = true;
    _response = response;
    responseBody = response.body;
    responseHeaders = response.headers;
    mauticVersion = responseHeaders['mautic-version'];
  }

  /// Handle Request Error
  void _handleFailure(error) {
    hasSuccess = false;
    mauticVersion = null;
    responseBody = error.osError.message;
  }

  /// Return Local File Cache
  Future<File> _localFile(String fname) async {
    var newfname = fname;
    newfname = fname.replaceAllMapped(RegExp(r'[/?:&=*^!#]'), (match) {
      return '_';
    });
    return File('$_localPath/$newfname.json');
  }

  /// Return false if request need to be cached
  Future<bool> _bypassCache(String fname) async {
    try {
      final file = await _localFile(fname);
      final fileTime = file.lastModifiedSync();
      final difference = DateTime.now().difference(fileTime);
      return difference.inMinutes >= _localExpiresMinutes;
    } catch (e) {
      return true;
    }
  }

  /// Write cache file
  Future<File> _writeCache(String filename, String contents) async {
    final file = await _localFile(filename);
    return file.writeAsString(contents);
  }

  /// Read cache file
  Future<String> _readCache(String filename) async {
    try {
      final file = await _localFile(filename);
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  /// Return Last Response Status Code
  int get lastStatus => hasSuccess ? _response.statusCode : 0;

  /// Return last Response object
  Response get getResponse =>
      hasSuccess ? (isCachedData ? 304 : _response) : null;

  /// Make a HTTP GET Request
  @protected
  void httpGet(_url) async {
    current_endpoint = _url;
    if (await _bypassCache(_url)) {
      isCachedData = false;
      final basicAuth = 'Basic ' +
          base64Encode(
            utf8.encode('$_username:$_password'),
          );
      await get(
        _baseurl + _url,
        headers: {
          'authorization': basicAuth,
        },
      ).then(_handleSuccess).catchError(_handleFailure);
    } else {
      isCachedData = true;
      responseBody = await _readCache(_url);
      hasSuccess = true;
    }
  }

  /// Return Parsed Json from Response
  @protected
  Map<String, dynamic> getJson() {
    return jsonDecode(responseBody);
  }

  ///
}
