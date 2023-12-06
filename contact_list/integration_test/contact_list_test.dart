import 'package:contact_list/widgets/contact_list/contact_item.dart';
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

  Future<void> setup(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
  }

  group('Contact list page', () {
    testWidgets('Verify delete icons displayed in each contact list',
        (WidgetTester tester) async {
      await setup(tester);
      await common.createNewContact(testData.emergencyContact[0], tester);
      await common.createNewContact(testData.emergencyContact[1], tester);
      await common.createNewContact(testData.emergencyContact[2], tester);
      expect(find.byIcon(Icons.delete_outline),
          findsNWidgets(find.byType(ContactItem).evaluate().length));
    });

    testWidgets('Verify emergency icons displayed in each contact list',
        (WidgetTester tester) async {
      await setup(tester);
      expect(common.getEmergencyIcons(tester).length,
          equals(find.byType(ContactItem).evaluate().length));
    });

    testWidgets('Verify contact item is deleted upon clicking delete button',
        (WidgetTester tester) async {
      await setup(tester);

      ListTile titleText = tester.widget(find.byType(ListTile).first);
      final text = titleText.title as Text;
      String name = text.data!;

      int origLength = find.text(name).evaluate().length;

      await common.ensureTap(tester, find.byIcon(Icons.delete_outline).first);
      expect(find.text(name), findsNWidgets(origLength - 1));
    });

    testWidgets('Verify emergency icon changes when updating the emergency',
        (WidgetTester tester) async {
      await setup(tester);

      //modify the emergency contact for the first contact in the list
      final Icon widgetIcon = common.getEmergencyIcons(tester)[0] as Icon;

      if (widgetIcon.icon == Icons.emergency) {
        //remove from emergency list
        await common.ensureTap(
            tester, find.widgetWithIcon(IconButton, Icons.emergency).first);
        final Icon newWidgetIcon = common.getEmergencyIcons(tester)[0] as Icon;
        expect(newWidgetIcon.icon, Icons.emergency_outlined);

        //add to emergency list and verify
        await common.ensureTap(tester,
            find.widgetWithIcon(IconButton, Icons.emergency_outlined).first);
        final Icon newwerWidgetIcon =
            common.getEmergencyIcons(tester)[0] as Icon;
        expect(newwerWidgetIcon.icon, Icons.emergency);
      } else {
        //add to emergency list and verify the icon
        await common.ensureTap(tester,
            find.widgetWithIcon(IconButton, Icons.emergency_outlined).first);
        final Icon newWidgetIcon = common.getEmergencyIcons(tester)[0] as Icon;
        expect(newWidgetIcon.icon, Icons.emergency);

        //remove to emergency list and verify that icon have changed
        await common.ensureTap(
            tester, find.widgetWithIcon(IconButton, Icons.emergency).first);
        final Icon newwerWidgetIcon =
            common.getEmergencyIcons(tester)[0] as Icon;
        expect(newwerWidgetIcon.icon, Icons.emergency_outlined);
      }
    });
  });
  group('Search functionality in Contact List page', () {
    final searchField = find.widgetWithText(TextField, 'Search');
    final clearButton = find.byIcon(Icons.cancel);

    testWidgets('Searching invalid keyword should display a message',
        (WidgetTester tester) async {
      await setup(tester);
      expect(searchField, findsOneWidget);
      expect(clearButton, findsNothing);

      await tester.enterText(searchField, 'Hello Nothing here');
      expect(find.text('Hello Nothing here'), findsOneWidget);
      await tester.pump();
      expect(clearButton, findsOneWidget);
      expect(find.text('No results for "Hello Nothing here"'), findsOneWidget);
      expect(find.textContaining('Check the spelling or try a new search.'),
          findsOneWidget);

      //validate clear button when there are search filter
      await tester.tap(clearButton);
      await tester.pump();
      expect(clearButton, findsNothing);
      expect(find.text('Hello Nothing here'), findsNothing);
    });

    testWidgets(
        'Searching a valid keyword should filter search results accordingly',
        (WidgetTester tester) async {
      await setup(tester);
      ListTile titleText = tester.widget(find.byType(ListTile).first);
      final text = titleText.title as Text;
      String name = text.data!;

      int origLength = find.text(name).evaluate().length;

      await tester.enterText(searchField, name);
      await tester.pump();

      expect(find.text(name), findsNWidgets(origLength + 1));
      expect(find.byType(ListTile).evaluate().length, origLength);
    });
  });
}
