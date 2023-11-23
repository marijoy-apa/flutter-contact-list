// import 'package:contact_list/providers/contact_list_provider.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';

// // incorrect: calling this will get the actual values of the contact info from database


// ProviderContainer createContainer({
//   ProviderContainer? parent,
//   List<Override> overrides = const [],
//   List<ProviderObserver>? observers,
// }) {
//   final container = ProviderContainer(
//     parent: parent,
//     overrides: overrides,
//     observers: observers,
//   );

//   addTearDown(container.dispose);

//   return container;
// }
// @GenerateMocks([http.Client])

// void main() {
//   test('Some description', () async {
//     final container = createContainer();

//     final contactList = container.read(contactListProvider.notifier);

//     await contactList.loadItems();
//     // this is incorrect calling of fetchContacts, should get the instance of mock class
//     // when(fetchContacts(client: http.Client())).thenAnswer((_) async => [
//     //       ContactInfo(
//     //           firstName: 'My Name',
//     //           contactNumber: [NumberList(NumberTypes.Custom, '12323123')])
//     //     ]);

//     expect(contactList.state, isNot(equals([])));
//     //commented as this assert the actual value of the contact items
//     // expect(contactList.state[0].firstName, 'new2');
//     // expect(
//     //   contactList.state[0].contactNumber[0].typeName,
//     //   NumberTypes.Phone,
//     // );
//     // expect(
//     //   contactList.state[0].contactNumber[0].digit,
//     //   '111111',
//     // );
//     // expect(contactList.state[0].lastName, '');
//     expect(contactList.isLoading, isFalse);
//     expect(contactList.error, equals(''));
//   });
// }
