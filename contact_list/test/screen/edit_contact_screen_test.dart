import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/screen/edit_contact.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_details.dart';

void main() {
  Future<void> setup(WidgetTester tester, ContactInfo contact) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contactListProvider.overrideWith(
              (ref) => ContactListNotifier(contactList: [contactDetails])),
        ],
        child: MaterialApp(
          home: EditContactScreen(contactItem: contact),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  final addPhoneButton = find.byIcon(Icons.add_circle);
  final phoneTextField = find.widgetWithText(TextField, 'Phone');
  final addEmergencyContact = find.text('Add to emergency contacts');
  final removeEmergencyContact = find.text('Remove from emergency contacts');
  final cancelButton = find.widgetWithText(TextButton, 'Cancel');
  final firstNameTextField = find.widgetWithText(TextField, 'First Name');
  final lastNameTextField = find.widgetWithText(TextField, 'Last Name');

  final notesTextField = find.descendant(
      of: find
          .ancestor(
            of: find.text('Notes'),
            matching: find.byType(Column),
          )
          .first,
      matching: find.byType(TextFormField));

  group('Edit Contact page fields validation', () {
    testWidgets('Edit Contact fields properly displayed',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);

      //text & text button
      expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Save'), findsOneWidget);
      expect(find.text('Add photo'), findsOneWidget);
      expect(addEmergencyContact, findsOneWidget);
      expect(addPhoneButton, findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);

      //textFields
      expect(find.widgetWithText(TextField, 'First Name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Last Name'), findsOneWidget);
    });

    testWidgets('Clicking Add Phone will add phone fields',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await ensureTap(tester, addPhoneButton);
      expect(phoneTextField, findsNWidgets(2));
    });

    testWidgets('Toggle Add/Remove to emergency contacts ',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await ensureTap(tester, addEmergencyContact);

      expect(removeEmergencyContact, findsOneWidget);
      expect(addEmergencyContact, findsNothing);

      await tester.tap(removeEmergencyContact);
      await tester.pump();
      expect(removeEmergencyContact, findsNothing);
      expect(addEmergencyContact, findsOneWidget);
    });

    testWidgets('Clicking Cancel button will remove the Edit Contacts page',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await ensureTap(tester, cancelButton);
      expect(
          find.byWidget(EditContactScreen(
            contactItem: contactDetails,
          )),
          findsNothing);
    });
  });

  group('Validate Edit Page Text fields enabled', () {
    testWidgets('Validate First Name textfield editable',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(firstNameTextField, 'John');
      expect(find.text('John'), findsOneWidget);
    });

    testWidgets('Validate Last Name textfield editable',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(lastNameTextField, 'Doe');
      expect(find.text('Doe'), findsOneWidget);
    });

    testWidgets('Validate Phone textfield editable',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(phoneTextField, '09123456789');
      expect(find.text('09123456789'), findsOneWidget);
    });

    testWidgets('Validate Notes textfield editable',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(notesTextField, 'Hello world!');
      expect(find.text('Hello world!'), findsOneWidget);
    });
  });

  group('Enabling/Disabling of Save button', () {
    testWidgets(
        'Save button enabled when First Name and contact number are populated',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '0909090909');
      await tester.pump();
      Text buttonWidget = tester.widget(find.text('Save'));
      expect(buttonWidget.style!.color, Colors.blue);
    });

    testWidgets(
        'Save button disabled when First Name / contact number not populated',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '');
      await tester.pump();
      Text buttonWidget = tester.widget(find.text('Save'));
      expect(buttonWidget.style!.color, isNot(Colors.blue));
    });

    testWidgets('Able to save modified contact details',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contactListProvider.overrideWith(
                (ref) => ContactListNotifier(contactList: [contactDetails])),
          ],
          child: MaterialApp(
            home: ContactsScreen(),
          ),
        ),
      );
      await tester.pump();
      await ensureTap(tester, find.text('Mary Doe'));
      await ensureTap(tester, find.text('Edit'));
      expect(find.text('Save'), findsOneWidget);
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '0909090909');
      await tester.pumpAndSettle();
      await ensureTap(tester, find.text('Save'));
      expect(find.text('Save'), findsNothing);
    });

    testWidgets(
        'Error message display when there are error on saving updated contact details',
        (WidgetTester tester) async {

      //provide mock data for contactList and error Message
      final mockContactListNotifier =
          ContactListNotifier(contactList: [contactDetails])
            ..error = 'Unable to update data. Please try again later';

      //pump widget given the overriden values for the provider
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: EditContactScreen(
              contactItem: contactDetails,
            ),
          ),
          overrides: [
            contactListProvider.overrideWith((ref) => mockContactListNotifier),
          ],
        ),
      );
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '0909090909');
      await tester.pumpAndSettle();
      await ensureTap(tester, find.text('Save'));

      expect(
          find.widgetWithText(
              SnackBar, 'Unable to update data. Please try again later'),
          findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

  });

  group('Correct rendering of data in the fields', () {
    testWidgets('Correct data loaded for First Name',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      expect(find.textContaining(contactDetails.firstName), findsOneWidget);
    });

    testWidgets('Correct data loaded for Last Name',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      expect(find.textContaining(contactDetails.lastName!), findsOneWidget);
    });

    testWidgets('Correct data loaded for Phone number',
        (WidgetTester tester) async {
      await setup(tester, emergencyContact);
      expect(
          find.text(emergencyContact.contactNumber[0].digit), findsOneWidget);
      expect(find.text(emergencyContact.contactNumber[0].typeName.name),
          findsNWidgets(2));
    });

    testWidgets('Correct data loaded for multiple phone numbers',
        (WidgetTester tester) async {
      await setup(tester, multipleNum);
      expect(find.text(multipleNum.contactNumber[0].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[0].typeName.name),
          findsNWidgets(2));
      expect(find.text(multipleNum.contactNumber[1].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[1].typeName.name),
          findsNWidgets(2));
      expect(find.text(multipleNum.contactNumber[2].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[2].typeName.name),
          findsNWidgets(2));
    });

    testWidgets('Correct data loaded for notes details',
        (WidgetTester tester) async {
      await setup(tester, multipleNum);
      expect(find.text(multipleNum.notes!), findsOneWidget);
    });

    testWidgets('Correct data loaded for Emergency Contacts: false',
        (WidgetTester tester) async {
      await setup(tester, contactDetails);
      expect(find.text('Add to emergency contacts'), findsOneWidget);
    });

    testWidgets('Correct data loaded for Emergency Contacts: true',
        (WidgetTester tester) async {
      await setup(tester, emergencyContact);
      expect(find.text('Remove from emergency contacts'), findsOneWidget);
    });
  });
}
