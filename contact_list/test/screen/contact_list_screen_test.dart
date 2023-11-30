import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_list.dart';

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

    testWidgets('Verify delete icons displayed in each contact list',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      expect(find.byIcon(Icons.delete_outline),
          findsNWidgets(contactListTest.length));
    });

    testWidgets('Verify emergency icons displayed in each contact list',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);

      expect(getEmergencyIcons(tester).length, contactListTest.length);

      for (var contact in contactListTest) {
        final ind = contactListTest.indexOf(contact);
        final Icon widgetIcon = getEmergencyIcons(tester)[ind] as Icon;
        if (contact.emergencyContact == true) {
          expect(widgetIcon.icon, Icons.emergency);
        } else {
          expect(widgetIcon.icon, Icons.emergency_outlined);
        }
      }
    });

    testWidgets('Verify contact deleted upon clicking delete button',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      await ensureTap(tester, find.byIcon(Icons.delete_outline).first);
      expect(find.textContaining(contactListTest[0].firstName), findsNothing);
    });

    testWidgets('Verify emergency icon changes when updating the emergency',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      await ensureTap(tester,
          find.widgetWithIcon(IconButton, Icons.emergency_outlined).first);
      Icon widgetIcon = getEmergencyIcons(tester)[0] as Icon;

      expect(widgetIcon.icon, Icons.emergency);
      // }
    });

    testWidgets('Verify emergency icon changes when removing the emergency',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);
      await ensureTap(
          tester, find.widgetWithIcon(IconButton, Icons.emergency).first);
      Icon widgetIcon = getEmergencyIcons(tester)[4] as Icon;

      expect(widgetIcon.icon, Icons.emergency_outlined);
    });

    testWidgets('Verify correct Names are rendered',
        (WidgetTester tester) async {
      await setup(tester, contactListTest);

      for (var contact in contactListTest) {
        expect(find.textContaining(contact.firstName), findsAtLeastNWidgets(1));
        expect(find.textContaining(contact.firstName), findsAtLeastNWidgets(1));
      }
      // }
    });
  });
}
