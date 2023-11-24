// import 'package:contact_list/model/number.dart';
// import 'package:contact_list/screen/contact_details.dart';
// import 'package:contact_list/widgets/contact_details/action_icon.dart';
// import 'package:contact_list/widgets/contact_details/icon_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// import '../test_data/contact_details.dart';

// class MockFlutterPhoneDirectCaller extends Mock
//     implements FlutterPhoneDirectCaller {
//   // Future<void> callNumber(String number) async {
//   //   // Define the behavior you want during testing
//   //   // For example, you can print a message or return a specific value
//   //   print('Mock FlutterPhoneDirectCaller.callNumber: $number');
//   //   // Alternatively, you can return a Future<void> if the real method is asynchronous
//   //   return Future.value();
//   // }

//   // Future<void> onCall(String number) async {
//   //   // Define the behavior you want during testing
//   //   // For example, you can print a message or return a specific value
//   //   // print('Mock FlutterPhoneDirectCaller.callNumber: $number');
//   //   // Alternatively, you can return a Future<void> if the real method is asynchronous
//   //   return Future.value();
//   // }
// }
// @GenerateMocks([MockFlutterPhoneDirectCaller])

// void main() {
//   testWidgets('onCall calls FlutterPhoneDirectCaller.callNumber',
//       (WidgetTester tester) async {
//     MockFlutterPhoneDirectCaller mockCaller = MockFlutterPhoneDirectCaller();
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

//     //failing, dunno why
//     verifyNever(FlutterPhoneDirectCaller.callNumber(contactDetails.contactNumber[0].digit))
//         .called(1);
//   });
// }
