import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/fetch_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockFetchContactService extends Mock implements FetchContactServices {
  Future<List<ContactInfo>> fetchContacts({http.Client? client}) async {
    return [
      ContactInfo(firstName: 'Hello', contactNumber: [
        NumberList(NumberTypes.Mobile, '123123213'),
      ])
    ];
  }
}

@GenerateMocks([FetchContactServices])
void main() {
  test('loadItems should update state with fetched contacts', () async {
    final mockService = MockFetchContactService();
    final testProvider = ContactListNotifier();

    
    // when(mockService.fetchContacts())
    //     .thenAnswer((realInvocation) async => Future.value(
    //           [
    //             ContactInfo(firstName: 'John', contactNumber: [
    //               NumberList(NumberTypes.Mobile, '123123213')
    //             ]),
    //           ],
    //         ));

    await testProvider.loadItems();
    expect(testProvider.state.length, 1);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, '');

    verify(mockService.fetchContacts()).called(1);
  });
}
