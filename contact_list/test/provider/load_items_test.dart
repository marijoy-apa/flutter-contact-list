import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/fetch_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockFetchContactService extends Mock implements FetchContactServices {
  var contactListSet = [
    ContactInfo(
        firstName: 'Hello',
        contactNumber: [
          NumberList(NumberTypes.Mobile, '123123213'),
        ],
        id: '2343423')
  ];

  @override
  Future<List<ContactInfo>> fetchContacts({http.Client? client}) async {
    return contactListSet;
  }

  void setContactList(List<ContactInfo> contact) {
    contactListSet = contact;
  }
}

@GenerateMocks([FetchContactServices])
void main() {
  test('loadItems should update state with fetched contacts', () async {
    final mockService = MockFetchContactService();
    final testProvider = ContactListNotifier();

    await testProvider.loadItems(fetchContact: mockService);
    expect(testProvider.state.length, 1);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, '');
  });

  test('loadItems should update state with empty contacts', () async {
    final mockService = MockFetchContactService();
    final testProvider = ContactListNotifier();

    mockService.setContactList([]);
    await testProvider.loadItems(fetchContact: mockService);
    expect(testProvider.state.length, 0);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, '');
  });
}
