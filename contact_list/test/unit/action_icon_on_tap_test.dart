import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/screen/contact_details.dart';
import 'package:contact_list/widgets/contact_details/icon_container.dart';
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

  Future<void> setup(WidgetTester tester, ContactInfo contactItem) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ContactDetailsScreen(
            contactItem: contactItem,
          ),
        ),
      ),
    );
  }

  testWidgets(
      'Verify Select phone number dialog is displayed when user has multiple numbers',
      (WidgetTester tester) async {
    await setup(tester, multipleNum);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Call'));
    expect(find.byType(Dialog), findsOneWidget);
    for (var number in multipleNum.contactNumber) {
      expect(find.text("${number.digit} (${number.typeName.name})"),
          findsOneWidget);
    }
  });

  testWidgets('Verify Phone numbers are displayed in radio button',
      (WidgetTester tester) async {
    await setup(tester, multipleNum);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Call'));
    for (var number in multipleNum.contactNumber) {
      expect(find.text("${number.digit} (${number.typeName.name})"),
          findsOneWidget);
    }
  });
  testWidgets('Verify Dialog is being removed when selecting a number',
      (WidgetTester tester) async {
    await setup(tester, multipleNum);

    await ensureTap(tester, find.widgetWithText(IconContainer, 'Call'));
    await ensureTap(
        tester,
        find.text(
          "${multipleNum.contactNumber[0].digit} (${multipleNum.contactNumber[0].typeName.name})",
        ));

    expect(find.byType(Dialog), findsNothing);
  });

  testWidgets('Verify Dialog not displayed when phone number is only 1',
      (WidgetTester tester) async {
    await setup(tester, contactDetails);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Call'));
    expect(find.byType(Dialog), findsNothing);
  });

  testWidgets('Verify Message, Video and Mail icons are disabled',
      (WidgetTester tester) async {
    await setup(tester, multipleNum);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Message'));
    expect(find.byType(Dialog), findsNothing);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Video'));
    expect(find.byType(Dialog), findsNothing);
    await ensureTap(tester, find.widgetWithText(IconContainer, 'Mail'));
    expect(find.byType(Dialog), findsNothing);
  });
}
