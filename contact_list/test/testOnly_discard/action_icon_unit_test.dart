// import 'package:contact_list/screen/contact_details.dart';
// import 'package:contact_list/widgets/contact_details/action_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// import '../test_data/contact_details.dart';

// class MockFlutterPhoneDirectCaller extends Mock
//     implements FlutterPhoneDirectCaller {
//   Future<void> callNumber(String number) async {
//     print('Mock FlutterPhoneDirectCaller.callNumber: $number');
//     return Future.value();
//   }

//   Future<void> onCall(String number) async {
//     return Future.value();
//   }
// }
// @GenerateMocks([MockFlutterPhoneDirectCaller])

// void main() {
//   testWidgets('onCall calls FlutterPhoneDirectCaller.callNumber',
//       (WidgetTester tester) async {
//     final mockCaller = MockFlutterPhoneDirectCaller();
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: ContactDetailsScreen(
//             contactItem: contactDetails,
//           ),
//         ),
//       ),
//     );


//     ActionIcons actionIconsWidget = tester.widget(find.byType(ActionIcons));

//     actionIconsWidget.onCall(contactDetails.contactNumber[0].digit,
//         phoneDirectCaller: mockCaller);

//     //failed, used on non mockito object
//     verify(mockCaller.callNumber(contactDetails.contactNumber[0].digit))
//         .called(1);
//   });
// }

// //https://stackoverflow.com/questions/73240744/how-to-verify-a-method-inside-a-method-is-called-in-mockito