// import 'package:contact_list/model/contacts.dart';
// import 'package:contact_list/model/number.dart';
// import 'package:contact_list/screen/tabs.dart';
// import 'package:contact_list/services/fetch_contact.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:contact_list/providers/contact_list_provider.dart';
// import 'package:http/http.dart' as http;

// import 'package:mockito/mockito.dart'; 



// void main() {
//   testWidgets('Test loadItems function', (WidgetTester tester) async {
//     // Wrap the test in a ProviderScope to provide the necessary providers
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: TestWidget()
//         ),
//       ),
//     );

//     // Access the ContactListNotifier provider
//     final contactList = tester.read(contactListProvider.notifier);

//     // Mock the fetchContacts function
//     when(fetchContacts()).thenAnswer((_) async => [ContactInfo(firstName: 'My Name', contactNumber: [NumberList(NumberTypes.Custom, '12323123')])]);

//     // Trigger the loadItems function
//     await contactList.loadItems();

//     // Verify that the state has been updated as expected
//     expect(contactList.state, isNot(equals([])));
//     expect(contactList.isLoading, isFalse);
//     expect(contactList.error, equals(''));
//   });
// }

// class TestWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Access the ContactListNotifier provider in the build method
//     final contactList = ref.read(contactListProvider.notifier);

//     // Use contactList and other providers as needed in your widget tree
//     return Container();
//   }
// }
