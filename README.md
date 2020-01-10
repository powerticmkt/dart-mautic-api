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

## Avaiable Endpoints

### MauticAPI

The class [`MauticAPI`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_api.dart) provide a constructor with 3 arguments:

- `base_url`: Your mautic URL (eg: https://yourmauticaddress.com)
- `username`: Your Mautic Username
- `password`: Your Mautic Password

Sample usage:

```dart
var api = MauticAPI('https://yourmauticaddress.com', 'username', 'password');
```

There are also two optional arguments to handle cache:

- `localPath`: The Path for cache directory (default: `./tmp`)
- `localExpiresMinutes`: Time to Expire cache in minutes (default: 5)

On Flutter you can use the [`path_provider`](https://pub.dev/packages/path_provider) package to get default app cache directory using `getApplicationDocumentsDirectory().path`.

The class [`MauticAPI`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_api.dart) has following attributes:

```dart
  /// Request Has Success?
  bool hasSuccess = false;

  /// Current Mautic Version
  String mauticVersion;
```

The class [`MauticAPI`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_api.dart) has following methods:

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
Future<List<MauticContact>> getContacts({int page = 0, String s = 'email:'});
```

### MauticUser

Class [`MauticUser`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_user.dart)  has folowing attributes:

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

Class [`MauticContact`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_contact.dart)  has folowing attributes:

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

Class [`MauticContact`](https://github.com/luizeof/dart-mautic-api/blob/master/lib/src/mautic_contact.dart)  has folowing methods:

```dart
  /// Return Gravatar URL
  String gravatarUrl({int size = 96});
```
