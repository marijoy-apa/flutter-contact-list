import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/update_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockUpdateContactService extends Mock implements UpdateContactServices {
  @override
  Future<http.Response> updateContact(
      {http.Client? client, required ContactInfo contact}) async {
    throw Exception();
  }
}

void main() {
  test('Error response will update the state for error upon updating list', () async {
    final mockService = MockUpdateContactService();
    final testProvider = ContactListNotifier();
    await testProvider.onEditContact(
        ContactInfo(
          firstName: 'First',
          contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
        ),
        onEditContactMock: mockService);
    expect(testProvider.state, []);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, 'Something went wrong please try again later. ');
  });

  test(
      'Error response will update the state for error when toggling to emergency contacts',
      () async {
    final mockService = MockUpdateContactService();
    final testProvider = ContactListNotifier();
    await testProvider.onToggleEmergencyContact(
        ContactInfo(
          firstName: 'First',
          contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
        ),
        updateContactMock: mockService);
    expect(testProvider.state, []);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, 'Unable to update data. Please try again later');
  });
}
