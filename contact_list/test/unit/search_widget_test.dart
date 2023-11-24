import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:contact_list/widgets/contact_list/no_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_list.dart';

void main() {
  Future<void> setup(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contactListProvider.overrideWith(
              (ref) => ContactListNotifier(contactList: contactListTest)),
          searchKeywordProvider.overrideWith(
              (ref) => SearchUserController(searchString: 'Found')),
        ],
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
      await tester.enterText(searchField, '');
      await tester.pump();

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
      expect(find.textContaining('Check the spelling or try a new search.'),
          findsOneWidget);
    });
  });
}
