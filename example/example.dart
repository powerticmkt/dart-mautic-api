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
