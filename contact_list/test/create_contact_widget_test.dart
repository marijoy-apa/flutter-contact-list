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

  final addPhoneButton = find.byIcon(Icons.add_circle);
  final phoneTextField = find.widgetWithText(TextField, 'Phone');
  final addEmergencyContact = find.text('Add to emergency contacts');
  final removeEmergencyContact = find.text('Remove from emergency contacts');
  final cancelButton = find.widgetWithText(TextButton, 'Cancel');

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
      tester.ensureVisible(addPhoneButton);
      await tester.pumpAndSettle();
      await tester.tap(addPhoneButton);
      await tester.pumpAndSettle();

      expect(phoneTextField, findsNWidgets(2));
    });

    testWidgets('Toggle Add/Remove to emergency contacts ',
        (WidgetTester tester) async {
      await setup(tester);
      tester.ensureVisible(addEmergencyContact);
      await tester.pumpAndSettle();
      await tester.tap(addEmergencyContact);
      await tester.pump();

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

      tester.ensureVisible(cancelButton);
      await tester.pumpAndSettle();
      await tester.tap(cancelButton);
      await tester.pump();

      expect(find.byWidget(ContactsScreen()), findsNothing);
    });
  });
}
