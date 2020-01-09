import 'mautic_api_base.dart';
import 'mautic_contact.dart';
import 'mautic_user.dart';

// Mautic API
class MauticAPI extends MauticAPIBase {
  /// Constructor
  MauticAPI(String _baseurl, String _username, String _password)
      : super(_baseurl, _username, _password);

  /// Return Current User
  Future<MauticUser> getCurrentUser() async {
    await httpGet(users_api_endpoint + '/self');
    if (hasSuccess) {
      final data = getJson();
      return MauticUser(
        data['id'],
        data['firstName'],
        data['lastName'],
        data['email'],
        data['onlineStatus'],
      );
    } else {
      return null;
    }
  }

  /// Return User by ID
  Future<MauticUser> getUserByID(int _id) async {
    await httpGet(users_api_endpoint + '/' + _id.toString());
    if (hasSuccess) {
      final data = getJson();
      return MauticUser(
        data['user']['id'],
        data['user']['firstName'],
        data['user']['lastName'],
        data['user']['email'],
        data['user']['onlineStatus'],
      );
    } else {
      return null;
    }
  }

  /// Return All Users
  Future<List<MauticUser>> getUsers() async {
    await httpGet(users_api_endpoint);
    if (hasSuccess) {
      var users = <MauticUser>[];
      final data = getJson()['users'];
      for (var i = 0; i < data.length; i++) {
        final _user = (data[i]);
        users.add(
          MauticUser(
            _user['id'],
            _user['firstName'],
            _user['lastName'],
            _user['email'],
            _user['onlineStatus'],
          ),
        );
      }
      return users;
    } else {
      return null;
    }
  }

  /// Parse DateTime Values
  DateTime _dateParse(dynamic d) {
    return DateTime.tryParse((d == null) ? '' : d.toString());
  }

  /// Parse int Values
  int _intParse(dynamic d) {
    var i = int.tryParse((d == null) ? '0' : d.toString());
    return (i == null) ? 0 : i;
  }

  /// Return Contact by ID
  Future<MauticContact> getContactByID(int _id) async {
    await httpGet(contacts_api_endpoint + '/' + _id.toString() + '?minimal');
    if (hasSuccess) {
      final data = getJson();
      return MauticContact(
        data['contact']['id'],
        data['contact']['fields']['all']['firstname'],
        data['contact']['fields']['all']['lastname'],
        data['contact']['fields']['all']['email'],
        _intParse(data['contact']['points']),
        _dateParse(data['contact']['dateAdded']),
        _dateParse(data['contact']['lastActive']),
        _dateParse(data['contact']['dateIdentified']),
      );
    } else {
      return null;
    }
  }

  /// Return All Contacts
  Future<List<MauticContact>> getContacts(
      {int page = 0, String s = 'email:'}) async {
    await httpGet(contacts_api_endpoint + '?' + s + '&page=' + page.toString());
    if (hasSuccess) {
      var contacts = <MauticContact>[];
      final data = [];

      getJson()['contacts'].forEach((k, v) => data.add(v));

      for (var i = 0; i < data.length; i++) {
        final _contact = data[i];
        contacts.add(
          MauticContact(
            _contact['id'],
            _contact['fields']['all']['firstname'],
            _contact['fields']['all']['lastname'],
            _contact['fields']['all']['email'],
            _intParse(_contact['points']),
            _dateParse(_contact['dateAdded']),
            _dateParse(_contact['lastActive']),
            _dateParse(_contact['dateIdentified']),
          ),
        );
      }
      return contacts;
    } else {
      return null;
    }
  }

  ///
}
