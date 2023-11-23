// import 'package:contact_list/providers/contact_list_provider.dart'; // Import your provider file
// import 'package:contact_list/services/fetch_contact.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';

// void main() {
//   test('loadItems updates state correctly', () async {
//     // Replace this with a mock implementation of FetchContactServices
//     final mockFetchContactServices = MockFetchContactServices();
    
//     // Replace this with a mock response for your fetchContacts method
//     when(mockFetchContactServices.fetchContacts())
//         .thenAnswer((_) async => /* Mock response here */);

//     // Create a test container
//     final container = ProviderContainer(
//       overrides: ContactListNotifier(contactList: mockFetchContactServices)
//     );

//     // Provide a mocked FetchContactServices to the provider
//     // container.readProviderOverride(
//     //   contactListProvider.notifier,
//     //   ContactListNotifier(fetchContactServices: mockFetchContactServices),
//     // );

//     // Trigger the loadItems function
//     await container.read(contactListProvider.notifier).loadItems();

//     // Verify that state is updated correctly
//     expect(container.read(contactListProvider), /* Expected state here */);
//   });
// }

// class MockFetchContactServices extends Mock implements FetchContactServices {}

// // You'll need to include the necessary imports for the Mock class
// // You can use a package like `mockito` for this purpose
