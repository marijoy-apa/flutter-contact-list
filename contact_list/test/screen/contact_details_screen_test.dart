import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_details.dart';

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
      await tester.pump();
      await ensureTap(tester, find.textContaining(contactDetails.firstName));
    }

    testWidgets('Verify buttons in contact details page',
        (WidgetTester tester) async {
      await setup(tester, [contactDetails]);

      expect(find.text('Message'), findsOneWidget);
      expect(find.text('Call'), findsOneWidget);
      expect(find.text('Video'), findsOneWidget);
      expect(find.text('Mail'), findsOneWidget);
    });

    testWidgets('Verify correct contact details info',
        (WidgetTester tester) async {
      await setup(tester, [contactDetails]);
      expect(find.textContaining(contactDetails.firstName), findsOneWidget);
      expect(find.textContaining(contactDetails.lastName!), findsOneWidget);
      expect(find.text(contactDetails.notes!), findsOneWidget);
      expect(find.text(contactDetails.contactNumber[0].digit), findsOneWidget);
      expect(find.text(contactDetails.contactNumber[0].typeName.name),
          findsOneWidget);
      expect(find.text('Add to emergency contacts'), findsOneWidget);
    });

    testWidgets('Verify multiple contact numbers', (WidgetTester tester) async {
      await setup(tester, [multipleNum]);
      expect(find.text(multipleNum.contactNumber[0].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[0].typeName.name),
          findsOneWidget);
      expect(find.text(multipleNum.contactNumber[1].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[1].typeName.name),
          findsOneWidget);
      expect(find.text(multipleNum.contactNumber[2].digit), findsOneWidget);
      expect(find.text(multipleNum.contactNumber[2].typeName.name),
          findsOneWidget);
    });

    testWidgets('Verify button for contacts set as emergency',
        (WidgetTester tester) async {
      await setup(tester, [emergencyContact]);
      expect(find.text('Remove from emergency contacts'), findsOneWidget);
    });

    testWidgets('Verify contacts and edit button', (WidgetTester tester) async {
      await setup(tester, [emergencyContact]);
      expect(find.text('Contacts'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
    });
  });
}