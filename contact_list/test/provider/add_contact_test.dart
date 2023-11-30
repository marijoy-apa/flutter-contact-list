import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/add_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockAddContactService extends Mock implements AddContactServices {
  @override
  Future<http.Response> addContacts(
      {http.Client? client, required ContactInfo contact}) async {
    throw Exception();
  }
}

void main() {
  test(
      'Error response will update the state for error upon Adding contacts contact throw Exception',
      () async {
    final mockService = MockAddContactService();
    final testProvider = ContactListNotifier();
    await testProvider.onAddNewContact(
        ContactInfo(
          firstName: 'First',
          contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
        ),
        mockAddNewContact: mockService);
    expect(testProvider.state, []);
    expect(testProvider.error, 'Something went wrong please try again later.');
  });
}
