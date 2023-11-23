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
  }

  group('Common UI in contact List page', () {
    testWidgets('Contacts text displayed', (WidgetTester tester) async {
      await setup(tester);
      await tester.pump();
      expect(find.text('Contacts'), findsNWidgets(2));
    });

    testWidgets('Emergency List text displayed', (WidgetTester tester) async {
      await setup(tester);
      await tester.pump();
      expect(find.text('Emergency List'), findsOneWidget);
    });
  });

  group('Search functionality', () {
    final searchField = find.widgetWithText(TextField, 'Search');
    final clearButton = find.byIcon(Icons.cancel);

    testWidgets('Search field is displayed and clear icon is not displayed',
        (WidgetTester tester) async {
      await setup(tester);
      expect(searchField, findsOneWidget);
      expect(clearButton, findsNothing);
    });

    testWidgets('Enter keyword and x icon will display',
        (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(searchField, 'Hello Nothing here');
      expect(find.text('Hello Nothing here'), findsOneWidget);
      await tester.pump();
      expect(clearButton, findsOneWidget);
    });

    testWidgets('Tapping x icon will clear search field',
        (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(searchField, 'Hello Nothing here');
      await tester.pump();
      await tester.tap(clearButton);
      await tester.pump();
      expect(clearButton, findsNothing);
      expect(find.text('Hello Nothing here'), findsNothing);
    });

    testWidgets('Searching invalid keyword displays message',
        (WidgetTester tester) async {
      await setup(tester);
      await tester.enterText(searchField, 'Hello Nothing here');
      await tester.pump();

    });
  });
}
