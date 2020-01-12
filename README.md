# Dart Mautic API

Mautic API Wrapper for Dart and Flutter

## Installing

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  mautic_api: any
```

Run `flutter pub get` on terminal to download and install packages and import on your files:

```dart
import 'package:mautic_api/mautic_api.dart';
```

## Basic Usage

You can create a new instance of class `MauticAPI` with 3 arguments: `base_url`, `username` and `password`:

```dart
  final api = MauticAPI('https://yourmauticaddress.com', 'username', 'password');
```

To test your credentials you can call `getCurrentUser()` to get your `MauticUser`. If the credentials fail the method return `null`.

```dart
  var user = await api.getCurrentUser();
```

Here a complete example to get current user info:

```dart
import 'package:mautic_api/mautic_api.dart';

void main() async {
  ///
  final api =
      MauticAPI('https://yourmauticaddress.com', 'username', 'password');

  var user = await api.getCurrentUser();

  print(user.id);
  print(user.firstName);
  print(user.lastName);
  print(user.email);
  print(user.onlineStatus);
}
```

## Available Endpoints

### MauticAPI

The class [`MauticAPI`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_api.dart) provides a constructor with 3 arguments:

- `base_url`: Your Mautic URL (eg: https://yourmauticaddress.com)
- `username`: Your Mautic Username
- `password`: Your Mautic Password

Sample usage:

```dart
var api = MauticAPI('https://yourmauticaddress.com', 'username', 'password');
```

There are also two optional arguments to handle cache:

- `localPath`: The Path for cache directory (default: `./tmp`)
- `localExpiresMinutes`: Time to Expire cache in minutes (default: 5)

On Flutter you can use the [`path_provider`](https://pub.dev/packages/path_provider) package to get default app cache directory.

The class [`MauticAPI`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_api.dart) has following attributes:

```dart
  /// Request Has Success?
  bool hasSuccess = false;

  /// Current Mautic Version?
  String mauticVersion;

  /// Is Data Read from Cache?
  bool isCachedData = false;
```

The class [`MauticAPI`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_api.dart) has following methods:

```dart
/// Return Current User
Future<MauticUser> getCurrentUser();

/// Return User by ID
Future<MauticUser> getUserByID(int _id);

/// Return All Users
Future<List<MauticUser>> getUsers();

/// Return Contact by ID
Future<MauticContact> getContactByID(int _id);

/// Return All Contacts
Future<List<MauticContact>> getContacts({ int page = 0, String s = 'email:%@%', String ob = 'last_active', String od = 'desc', int limit = 5});

/// Return the number of identified contacts
Future<int> getTotalContacts();

/// Return the number of pagination of contacts
Future<int> getContactsPagination({int limit = 30});

/// Return All Emails
Future<List<MauticEmail>> getEmails({ int page = 0, String s = '', String ob = 'id', String od = 'desc', int limit = 30});

/// Return Contact by ID
Future<MauticEmail> getEmailByID(int _id);

/// Return the number of emails
Future<int> getTotalEmails();

/// Return the number of pagination of emails
Future<int> getEmailsPagination({int limit = 30});
```

### MauticUser

Class [`MauticUser`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_user.dart)  has the following attributes:

```dart
  /// User ID
  final int id;

  /// User First Name
  final String firstName;

  /// User Last Name
  final String lastName;

  /// User Email
  final String email;

  /// User Online Status
  final String onlineStatus;
```

### MauticContact

Class [`MauticContact`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_contact.dart)  has the following attributes:

```dart
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
  bool get isIdentified;
```

Class [`MauticContact`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_contact.dart)  has the following methods:

```dart
  /// Return Gravatar URL
  String gravatarUrl({int size = 96});
```

### MauticEmail

Class [`MauticEmail`](https://github.com/powerticmkt/dart-mautic-api/blob/master/lib/src/mautic_email.dart)  has the following attributes:

```dart
  final int id;

  final bool isPublished;

  final String name;

  final String subject;

  final String fromAddress;

  final String fromName;

  final String replyToAddress;

  final String customHtml;

  final String plainText;

  final String template;

  final String emailType;

  final String language;

  final DateTime publishUp;

  final DateTime publishDown;

  final int readCount;

  final int sentCount;

  double readRate;

  bool hasTextPlain;
```
