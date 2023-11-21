import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/services/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Create a mock HTTP client
// class MockClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  test('loadItems should handle response correctly', () async {
    // Arrange
    // final mockClient = MockClient();
    var mockClient = MockClient((request) async {
      return http.Response(
          '{"-NjfInGDS-nF9jBCYNFw":{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"2342342323","numType":"Phone"}]}}',
          200,
          headers: {'content-type': 'application/json'});
    });
    final contactListNotifier = ContactListNotifier();

    final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

    final uri = Uri.https(projectUrl, 'contact-list.json');

    // Set up the expected response
    final expectedResponse = http.Response(
        '{"-NjfInGDS-nF9jBCYNFw":{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"2342342323","numType":"Phone"}]}}',
        200);

    // Mock the HTTP client to return the expected response
    // when(mockClient.get(uri)).thenAnswer((_) async => expectedResponse);

    // Mock the Database class to return the mock client
    when(Database().loadDatabase(client: mockClient))
        .thenAnswer((_) async => expectedResponse);

    // Act
    await contactListNotifier.loadItems(client: mockClient);

    // Assert that the state is updated correctly based on the response
    expect(contactListNotifier.isLoading, false);
    expect(contactListNotifier.error, '');
    expect(contactListNotifier.state.length,
        1); // Adjust the expected length based on your mock data
  });
}
