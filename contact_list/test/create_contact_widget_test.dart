import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> setup(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ContactsScreen(),
        ),
      ),
    );
    await tester.pump();

    final addButton = find.byType(FloatingActionButton);
    await tester.tap(addButton);
    await tester.pump();
  }

  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  final doneButton = find.widgetWithText(TextButton, 'Done');
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

  group('Create New Contact page validation', () {
    testWidgets('Create New Contact UI displayed', (WidgetTester tester) async {
      await setup(tester);

      //text & text button
      expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Done'), findsOneWidget);
      expect(find.text('Add photo'), findsOneWidget);
      expect(addEmergencyContact, findsOneWidget);
      expect(addPhoneButton, findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);

      //textFields
      expect(find.widgetWithText(TextField, 'First Name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Last Name'), findsOneWidget);
      expect(phoneTextField, findsOneWidget);
    });

    testWidgets('Clicking Add Phone will add phone fields',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, addPhoneButton);
      expect(phoneTextField, findsNWidgets(2));
    });

    testWidgets('Toggle Add/Remove to emergency contacts ',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, addEmergencyContact);

      expect(removeEmergencyContact, findsOneWidget);
      expect(addEmergencyContact, findsNothing);

      await tester.tap(removeEmergencyContact);
      await tester.pump();
      expect(removeEmergencyContact, findsNothing);
      expect(addEmergencyContact, findsOneWidget);
    });

    testWidgets('Clicking Cancel button will remove the Create Contacts page',
        (WidgetTester tester) async {
      await setup(tester);
      await ensureTap(tester, cancelButton);
      expect(find.byWidget(ContactsScreen()), findsNothing);
    });
  });

  group('Validate Text fields', () {
    testWidgets('Validate First Name textfield', (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(firstNameTextField, 'John');
      expect(find.text('John'), findsOneWidget);
    });

    testWidgets('Validate Last Name textfield', (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(lastNameTextField, 'Doe');
      expect(find.text('Doe'), findsOneWidget);
    });

    testWidgets('Validate Phone textfield', (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(phoneTextField, '09123456789');
      expect(find.text('09123456789'), findsOneWidget);
    });

    testWidgets('Validate Notes textfield', (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(notesTextField, 'Hello world!');
      expect(find.text('Hello world!'), findsOneWidget);
    });
  });

  group('Enabling/Disabling of Done button', () {
    testWidgets(
        'Done button enabled when First Name and contact number are populated',
        (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '0909090909');
      await tester.pump();
      Text buttonWidget = tester.widget(find.text('Done'));
      expect(buttonWidget.style!.color, Colors.blue);
    });

    testWidgets(
        'Done button disabled when First Name / contact number not populated',
        (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(firstNameTextField, 'John');
      await tester.pump();
      Text buttonWidget = tester.widget(find.text('Done'));
      expect(buttonWidget.style!.color, isNot(Colors.blue));
    });
  });
}
