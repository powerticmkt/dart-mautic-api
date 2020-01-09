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
  final api =
      MauticAPI('https://yourmauticaddress.com', 'username', 'password');
```

To test your credentials you can call `getCurrentUser()` to 
get your `MauticUser`. If the credentials fail the method return `null`.

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

The class `MauticAPI`provide a constructor with 3 arguments:

- `base_url`: Your mautic URL (eg: https://m.luizeof.com.br)
- `username`: Your Mautic Username
- `password`: Your Mautic Password

Sample usage:

```dart
var api = MauticAPI('https://yourmauticaddress.com', 'username', 'password');
```

### MauticUser

### MauticContact
