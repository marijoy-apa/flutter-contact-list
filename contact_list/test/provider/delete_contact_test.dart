import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/delete_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockDeleteContactService extends Mock implements DeleteContactServices {
  var response = http.Response(
    'Error fetching data',
    400,
  );
  @override
  Future<http.Response> deleteContact(
      {http.Client? client, required ContactInfo contact}) async {
    print('mock delete contact');
    return response;
  }

  setErrorResponse() {
    response = throw Error();
  }
}

void main() {
  test('Error response will update the state for error upon deleting contact',
      () async {
    final mockService = MockDeleteContactService();
    final testProvider = ContactListNotifier();

    await testProvider.onToggleDeleteContact(
        ContactInfo(
          firstName: 'First',
          contactNumber: [NumberList(NumberTypes.Custom, '12122132')],
        ),
        deleteContactMock: mockService);
    expect(testProvider.state, []);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, 'Something went wrong. Please try again later.');
  });
}
