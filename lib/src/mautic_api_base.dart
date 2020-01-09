import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart';

/// Base Mautic REST API
class MauticAPIBase {
  /// Mautic Base URL
  final String _baseurl;

  /// Mautic User Name
  final String _username;

  /// Mautic Password
  final String _password;

  /// Request Response
  Response _response;

  /// Request Has Success?
  bool hasSuccess = false;

  /// Request Response body
  String responseBody;

  /// Request Responde Headers
  Map<String, String> responseHeaders;

  /// Current Mautic Version
  String mauticVersion;

  /// Mautic Users Endpoint
  @protected
  final users_api_endpoint = '/api/users';

  /// Mautic Contacts Endpoint
  @protected
  final contacts_api_endpoint = '/api/contacts';

  /// Constructor
  MauticAPIBase(
    this._baseurl,
    this._username,
    this._password,
  );

  void _handleSuccess(Response response) {
    hasSuccess = true;
    _response = response;
    responseBody = response.body;
    responseHeaders = response.headers;
    mauticVersion = responseHeaders['mautic-version'];
  }

  void _handleFailure(error) {
    hasSuccess = false;
    mauticVersion = null;
    responseBody = error.osError.message;
  }

  /// Return Last Response Status Code
  int get lastStatus => hasSuccess ? _response.statusCode : 0;

  /// Return last Response object
  Response get getResponse => hasSuccess ? _response : null;

  /// Make a HTTP GET Request
  @protected
  void httpGet(_url) async {
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
  }

  /// Return Parsed Json from Response
  @protected
  Map<String, dynamic> getJson() {
    return jsonDecode(responseBody);
  }

  ///
}
