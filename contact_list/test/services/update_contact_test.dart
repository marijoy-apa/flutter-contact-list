import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/services/update_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  final addedContact = ContactInfo(
      firstName: 'Name',
      contactNumber: [
        NumberList(NumberTypes.Phone, '234342423'),
        NumberList(NumberTypes.Phone, '43451212')
      ],
      emergencyContact: false);
  test('Update contact should return a response', () async {
    final client = MockClient((request) async {
      return http.Response(
          '{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"234342423","numType":"Phone"},{"contactNum":"4345","numType":"Phone"}]}',
          200,
          headers: {'content-type': 'application/json'});
    });
    final response = await updateContact(client: client, contact: addedContact);
    expect(response, isA<http.Response>());
    expect(response.statusCode, 200);
  });
}
