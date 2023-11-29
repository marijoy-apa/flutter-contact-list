import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/delete_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockDeleteContactService extends Mock implements DeleteContactServices {
  @override
  Future<http.Response> deleteContact(
      {http.Client? client, required ContactInfo contact}) async {
    throw Exception();
  }
}

void main() {
  test('Error response will update the state for error upon deleting contact', () async {
    final mockService = MockDeleteContactService();
    final testProvider = ContactListNotifier();
    await testProvider.onToggleDeleteContact(
        ContactInfo(
          firstName: 'First',
          contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
        ),
        0,
        deleteContactMock: mockService);
    expect(testProvider.state, []);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, 'Something went wrong. Please try again later.');
  });

  // test(
  //     'Error response will update the state for error when toggling to emergency contacts',
  //     () async {
  //   final mockService = MockUpdateContactService();
  //   final testProvider = ContactListNotifier();
  //   await testProvider.onToggleEmergencyContact(
  //       ContactInfo(
  //         firstName: 'First',
  //         contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
  //       ),
  //       updateContactMock: mockService);
  //   expect(testProvider.state, []);
  //   expect(testProvider.isLoading, false);
  //   expect(testProvider.error, 'Unable to update data. Please try again later');
  // });
}
