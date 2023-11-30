import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_details.dart';
import '../test_data/contact_list.dart';
import '../test_data/emergency_list.dart';

void main() {
  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Widget TestWidget(ContactListNotifier mockProvider) {
    return ProviderScope(
      child: MaterialApp(home: ContactsScreen()),
      overrides: [
        contactListProvider.overrideWith((ref) => mockProvider),
      ],
    );
  }

  group('Contact Details Page Unit Test', () {
    Future<void> setup(WidgetTester tester, List<ContactInfo> testData) async {
      final mockContactListNotifier =
          ContactListNotifier(contactList: testData);
      await tester.pumpWidget(TestWidget(mockContactListNotifier));
      await ensureTap(tester, find.text('Emergency List'));
    }

    List<Widget> getEmergencyIcons(WidgetTester tester) {
      final icons = tester.widgetList(find.byType(Icon));
      final emergencyIcons = icons.where((widget) {
        if (widget is Icon) {
          final Icon widgetIcon = widget;
          return widgetIcon.icon == Icons.emergency ||
              widgetIcon.icon == Icons.emergency_outlined;
        }
        return false;
      }).toList();
      return emergencyIcons;
    }

    testWidgets('Verify Emergency List Page', (WidgetTester tester) async {
      await setup(tester, contactListTest);
      expect(find.text('Emergency List'), findsNWidgets(2));
    });

    testWidgets(
      'Verify only emergency icons displayed in each contact list',
      (WidgetTester tester) async {
        await setup(tester, contactListTest);
        expect(getEmergencyIcons(tester).length, emergencyListTest.length);
        for (var contact in emergencyListTest) {
          var ind = emergencyListTest.indexOf(contact);
          Icon widgetIcon = getEmergencyIcons(tester)[ind] as Icon;
          expect(widgetIcon.icon, Icons.emergency);
        }
      },
    );

    testWidgets('Verify contact deleted upon clicking delete button',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      await ensureTap(tester, find.byIcon(Icons.delete_outline).first);
      expect(find.textContaining(emergencyListTest[0].firstName), findsNothing);
    });

    testWidgets('Verify contacts removed upon toggle of emergency button',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      await ensureTap(
          tester, find.widgetWithIcon(IconButton, Icons.emergency).first);

      expect(find.textContaining(emergencyListTest[0].firstName), findsNothing);
    });

    testWidgets('Verify correct Names are rendered',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);

      for (var contact in emergencyListTest) {
        expect(find.textContaining(contact.firstName), findsAtLeastNWidgets(1));
        expect(find.textContaining(contact.firstName), findsAtLeastNWidgets(1));
      }
    });

    testWidgets(
        'Verify Error message when there are error upon loading the items',
        (WidgetTester tester) async {
      final mockContactListNotifier =
          ContactListNotifier(contactList: [contactDetails])
            ..error = 'Something went wrong. Please try again later.';
      await tester.pumpWidget(TestWidget(mockContactListNotifier));
      await ensureTap(tester, find.text('Emergency List'));

      expect(find.text('Something went wrong. Please try again later.'),
          findsOneWidget);
    });

    testWidgets('Verify loading modal when items are still loading',
        (WidgetTester tester) async {
      final mockContactListNotifier =
          ContactListNotifier(contactList: [contactDetails])
            ..error = ''
            ..isLoading = true;
      await tester.pumpWidget(TestWidget(mockContactListNotifier));
      await tester.tap(find.text('Emergency List'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
