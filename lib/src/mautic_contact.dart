import 'package:convert/convert.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

/// Mautic Contact
class MauticContact {
  /// Constructor
  MauticContact(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.points,
    this.dateAdded,
    this.dateLastActive,
    this.dateIdentified,
  );

  /// Contact ID
  final int id;

  /// Contact First Name
  final String firstName;

  /// Contact Last Name
  final String lastName;

  /// Contact Email
  final String email;

  /// Contact Points
  final int points;

  /// Contact Date Added
  final DateTime dateAdded;

  /// Contact Date Last Active
  final DateTime dateLastActive;

  /// Contact Date Identified
  final DateTime dateIdentified;

  /// Return if Contact is Identified
  bool get isIdentified => email.isNotEmpty;

  /// Get Gravatar Url
  String gravatarUrl({int size = 96}) {
    var em;
    if (isIdentified) {
      em = emailHash();
    } else {
      em = '00000000000000000000000000000000';
    }
    return 'https://www.gravatar.com/avatar/' + em + '?s=' + size.toString();
  }

  ///Generate MD5 hash from Email
  String emailHash() {
    var content = Utf8Encoder().convert(email);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  ///
}
