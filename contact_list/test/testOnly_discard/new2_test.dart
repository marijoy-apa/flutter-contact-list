// class ContactListNotifier extends StateNotifier<List<ContactInfo>> {
//   // Existing code...

//   // Add a method to obtain FetchContactServices instance
//   FetchContactServices getFetchContactServices() {
//     return FetchContactServices();
//   }

//   // Existing code...
// }


// import 'package:contact_list/providers/contact_list_provider.dart'; // Import your provider file
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';

// void main() {
//   test('loadItems updates state correctly', () async {
//     // Create a mocked FetchContactServices
//     final mockFetchContactServices = MockFetchContactServices();

//     // Replace this with a mock response for your fetchContacts method
//     when(mockFetchContactServices.fetchContacts())
//         .thenAnswer((_) async => /* Mock response here */);

//     // Create a test container
//     final container = ProviderContainer();

//     // Provide the mocked FetchContactServices to the provider
//     container.readProviderOverride(
//       contactListProvider.notifier,
//       ContactListNotifier(),
//     );

//     // Replace the FetchContactServices instance in the notifier with the mock
//     final contactListNotifier = container.read(contactListProvider.notifier);
//     contactListNotifier.fetchContactServices = mockFetchContactServices;

//     // Trigger the loadItems function
//     await contactListNotifier.loadItems();

//     // Verify that state is updated correctly
//     expect(container.read(contactListProvider), /* Expected state here */);
//   });
// }

// class MockFetchContactServices extends Mock implements FetchContactServices {}
