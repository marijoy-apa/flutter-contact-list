import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:contact_list/main.dart' as app;
import 'common/common.dart';
import 'finder/finder.dart';
import 'test_data/test_data.dart';

final createContactFinder = CreateNewContactFinder();
final testData = TestData();
final common = Common();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> setup(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await ensureTap(
        tester, find.textContaining('John Napoleon'));
    await ensureTap(tester, find.text('Edit'));
  }

  group('Create New Contact page validation', () {
    testWidgets('Update UI Contact UI display', (WidgetTester tester) async {
      await setup(tester);

      //text & text button
      // expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
      // expect(find.widgetWithText(TextButton, 'Save'), findsOneWidget);
      // expect(find.text('Add photo'), findsOneWidget);
      // expect(createContactFinder.removeEmergencyContact, findsOneWidget);
      // expect(createContactFinder.addPhoneButton, findsOneWidget);
      // expect(find.text('Notes'), findsOneWidget);

      // //textFields
      // expect(find.widgetWithText(TextField, 'First Name'), findsOneWidget);
      // expect(find.widgetWithText(TextField, 'Last Name'), findsOneWidget);
      // expect(createContactFinder.phoneTextField, findsOneWidget);
    });

    testWidgets('Clicking Add Phone will add phone fields',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, createContactFinder.addPhoneButton);
      expect(createContactFinder.phoneTextField, findsNWidgets(2));
    });

    testWidgets('Toggle Add/Remove to emergency contacts ',
        (WidgetTester tester) async {
      await setup(tester);
      // await ensureTap(tester, createContactFinder.addEmergencyContact);
      await ensureTap(tester, createContactFinder.removeEmergencyContact);

      expect(createContactFinder.addEmergencyContact, findsOneWidget);
      expect(createContactFinder.removeEmergencyContact, findsNothing);

      await tester.tap(createContactFinder.addEmergencyContact);
      await tester.pump();
      expect(createContactFinder.addEmergencyContact, findsNothing);
      expect(createContactFinder.removeEmergencyContact, findsOneWidget);
    });

    testWidgets('Clicking Cancel button will remove the Create Contacts page',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, createContactFinder.cancelButton);
      expect(find.byWidget(ContactsScreen()), findsNothing);
    });

    testWidgets(
        'Select Number Type dialog pops up when clicking the Number dropdown',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, find.byKey(Key('numType-dropdown-button0')));
      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('Should be able to change the num type',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, find.byKey(Key('numType-dropdown-button0')));
      await ensureTap(tester, find.text('Custom'));

      expect(find.text('Custom'), findsNWidgets(2));
    });
  });

  group('Create New Contact Feature', () {
    testWidgets('Able to save modified contact details',
        (WidgetTester tester) async {
      // await tester.pump();

      expect(find.text('Save'), findsOneWidget);
      await tester.enterText(createContactFinder.firstNameTextField, 'John');
      await tester.enterText(createContactFinder.phoneTextField, '0909090909');
      await tester.pumpAndSettle();
      await ensureTap(tester, find.text('Save'));
      expect(find.text('Save'), findsNothing);
    });

    // testWidgets('Should be able to create new contact with complete details',
    //     (tester) async {
    //   await setup(tester);
    //   await ensureTap(tester, createContactFinder.addEmergencyContact);

    //   await tester.enterText(createContactFinder.firstNameTextField, 'John');
    //   await tester.enterText(createContactFinder.lastNameTextField, 'Napoleon');

    //   //num type dropdown
    //   await ensureTap(tester, find.byKey(Key('numType-dropdown-button0')));
    //   await ensureTap(tester, find.text('Fax'));
    //   expect(find.text('Fax'), findsNWidgets(2));
    //   await tester.enterText(
    //       find.widgetWithText(TextField, 'Fax'), '0909090909');

    //   //to input two numbers
    //   await ensureTap(tester, createContactFinder.addPhoneButton);
    //   await tester.enterText(
    //       find.widgetWithText(TextField, 'Phone'), '1912345678');

    //   await tester.enterText(createContactFinder.notesTextField,
    //       'This is a test note. Please ignore.');

    //   await tester.pump();
    //   Text buttonWidget = tester.widget(find.text('Done'));
    //   expect(buttonWidget.style!.color, Colors.blue);

    //   await ensureTap(tester, createContactFinder.doneButton);
    //   await ensureTap(tester, find.text('John Napoleon').first);
    //   common.validateCorrectContactDetails(testData.fullDetailsContactInfo);
    // });
  });
}
