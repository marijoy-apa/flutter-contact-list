import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/fetch_contact.dart';
import 'package:contact_list/services/update_contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockUpdateContactService extends Mock implements UpdateContactServices {
  var response = http.Response(
      '{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"234342423","numType":"Phone"},{"contactNum":"4345","numType":"Phone"}]}',
      200,
      headers: {'content-type': 'application/json'});
  

  @override
  Future<http.Response> updateContact(
      {http.Client? client, required ContactInfo contact}) async {
    return response;
  }

  void setResponse(newResponse) {
    response = newResponse;
  }
}

void main() {
  test('loadItems should update state with fetched contacts', () async {
    final mockService = MockUpdateContactService();
    final testProvider = ContactListNotifier();

    await testProvider.loadItems(fetchContact: mockService);
    expect(testProvider.state.length, 1);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, '');
  });

  test('loadItems should update state with empty contacts', () async {
    final mockService = MockUpdateContactService();
    final testProvider = ContactListNotifier();

    mockService.setResponse([]);
    await testProvider.loadItems(fetchContact: mockService);
    expect(testProvider.state.length, 0);
    expect(testProvider.isLoading, false);
    expect(testProvider.error, '');
  });
}
