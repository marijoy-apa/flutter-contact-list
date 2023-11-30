import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/services/add_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  final addedContact = ContactInfo(
    firstName: 'New Name',
    contactNumber: [NumberList(NumberTypes.Custom, '23423432')],
  );
  test('Add contact should return a response', () async {
    final client = MockClient((request) async {
      return http.Response('{"name":"-NjkVYyLr0qSvXEsYG8J"}', 200,
          headers: {'content-type': 'application/json'});
    });
    final response = await AddContactServices().addContacts(client: client, contact: addedContact);
    expect(response, isA<http.Response>());
    expect(response.statusCode, 200);
  });
}
