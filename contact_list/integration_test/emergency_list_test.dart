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
    await common.ensureTap(tester, find.text('Emergency List'));
    expect(find.text('Emergency List'), findsNWidgets(2));
  }

  group('Emergency list page', () {
    testWidgets('Verify delete icons displayed in each emergency list',
        (WidgetTester tester) async {
      await setup(tester);
      await common.ensureTap(tester, find.text('Contacts'));
      await common.createNewContact(testData.emergencyContact[0], tester);
      await common.createNewContact(testData.emergencyContact[1], tester);
      await common.createNewContact(testData.emergencyContact[2], tester);
      await common.createNewContact(testData.emergencyContact[3], tester);

      expect(find.byIcon(Icons.delete_outline),
          findsNWidgets(find.byType(ContactItem).evaluate().length));
    });

    testWidgets('Verify only emergency contacts are displayed',
        (WidgetTester tester) async {
      await setup(tester);
      List contactItems = find.byType(ContactItem).evaluate().toList();
      expect(
          common.getEmergencyIcons(tester).length, equals(contactItems.length));

      for (var widget in contactItems) {
        final ind = contactItems.indexOf(widget);
        final Icon widgetIcon = common.getEmergencyIcons(tester)[ind] as Icon;
        expect(widgetIcon.icon, Icons.emergency);
      }
    });

    testWidgets('Verify contact deleted upon clicking delete button',
        (WidgetTester tester) async {
      await setup(tester);

      String name = common.getFirstNameInList(tester);

      //get the original length of names in Contacts and Emergency List tab
      int origLengthEL = find.text(name).evaluate().length;
      await common.ensureTap(tester, find.text('Contacts'));
      int origLengthCL = find.text(name).evaluate().length;

      //navigate back to Emergency List to toggle Delete Icon
      await common.ensureTap(tester, find.text('Emergency List'));
      await common.ensureTap(tester, find.byIcon(Icons.delete_outline).first);

      //Validate the name has been removed in Emergency List tab and in Contact List tab
      expect(find.text(name), findsNWidgets(origLengthEL - 1));
      await common.ensureTap(tester, find.text('Contacts'));
      expect(find.text(name), findsNWidgets(origLengthCL - 1));
    });

    testWidgets(
        'Verify a contact is removed in the list when emergency icon is toggled',
        (WidgetTester tester) async {
      await setup(tester);

      //get the first contact in the list and find the no. of contacts with that name
      String name = common.getFirstNameInList(tester);
      int origLength = find.text(name).evaluate().length;

      //click on emergency icon in Emergency list tab and verify that the contact has been removed
      await common.ensureTap(
          tester, find.widgetWithIcon(IconButton, Icons.emergency).first);
      expect(find.text(name), findsNWidgets(origLength - 1));

      //navigate to contacts page to validate the removed emergency contact has updated its emergency icon
      await common.ensureTap(tester, find.text('Contacts'));
      common.validateItemIsEmergency(name, false, tester);
    });
  });
  group('Search functionality in Emergency List page', () {
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

  group('Empty contact list and emergency list', () {
    testWidgets(
        'Verify "No Emergency Contacts" message is displayed when all emergency contacts are removed',
        (WidgetTester tester) async {
      await setup(tester);

      await common.removeAllEmergencyContact(tester);
      expect(find.text('No Emergency Contacts'), findsOneWidget);
      expect(find.text("Emergency Contacts you've added will appear here"),
          findsOneWidget);
    });

    testWidgets(
        'Verify "No Contacts" message is displayed when contact list is empty',
        (WidgetTester tester) async {
      await setup(tester);

      await common.ensureTap(tester, find.text('Contacts'));
      await common.removeAllContactList(tester);
      expect(find.text('No Contacts'), findsOneWidget);
      expect(
          find.text("Contacts you've added will appear here"), findsOneWidget);
    });
  });
}
