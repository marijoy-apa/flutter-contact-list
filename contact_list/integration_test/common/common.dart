import 'package:contact_list/model/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../finder/finder.dart';

final createContactFinder = CreateNewContactFinder();

class Common {
  void validateCorrectContactDetails(ContactInfo contact) async {
    final String emergencyText = contact.emergencyContact
        ? 'Remove from emergency contacts'
        : 'Add to emergency contacts';

    final String fullName = contact.lastName != null
        ? '${contact.firstName} ${contact.lastName}'
        : contact.firstName;

    expect(find.textContaining(fullName), findsOneWidget);
    for (var number in contact.contactNumber) {
      expect(find.text(number.digit), findsOneWidget);
      expect(find.text(number.typeName.name), findsOneWidget);
    }
    expect(find.text(contact.notes ?? ''), findsOneWidget);
    expect(find.text(emergencyText), findsOneWidget);
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

  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  String getFirstNameInList(WidgetTester tester) {
    ListTile titleText = tester.widget(find.byType(ListTile).first);
    final text = titleText.title as Text;
    String name = text.data!;
    return name;
  }

  bool validateItemIsEmergency(
      String passedName, bool isEmergency, WidgetTester tester) {
    List<String> names = getListNames(tester);
    for (var name in names) {
      final ind = names.indexOf(name);
      if (name == passedName) {
        Icon ic = getEmergencyIcons(tester)[ind] as Icon;
        if (isEmergency == true) {
          expect(ic.icon, Icons.emergency);
        } else {
          expect(ic.icon, Icons.emergency_outlined);
        }
      }
    }
    return false;
  }

  List<String> getListNames(WidgetTester tester) {
    List contactItems = find.byType(ListTile).evaluate().toList();

    List<String> names = [];
    for (var i = 0; i < contactItems.length; i++) {
      ListTile titleText = tester.widget(find.byType(ListTile).at(i));
      final text = titleText.title as Text;
      String name = text.data!;
      names.add(name);
    }
    return names;
  }

  Future<void> removeAllEmergencyContact(WidgetTester tester) async {
    List contactItems = find.byType(ListTile).evaluate().toList();

    if (contactItems.length != 0) {
      for (var i = 0; i < contactItems.length; i++) {
        await ensureTap(tester, find.byIcon(Icons.emergency).first);
      }
    }
  }

  Future<void> removeAllContactList(WidgetTester tester) async {
    List contactItems = find.byType(ListTile).evaluate().toList();

    if (contactItems.length != 0) {
      for (var i = 0; i < contactItems.length; i++) {
        await tester.pump(Duration(seconds: 1));
        await ensureTap(tester, find.byIcon(Icons.delete_outline).first);
      }
    }
  }

  Future<void> createNewContact(
      ContactInfo contact, WidgetTester tester) async {
    final addButton = find.byType(FloatingActionButton);
    await tester.tap(addButton);
    await tester.pump();

    //set Emergency Contacts if set to true
    if (contact.emergencyContact == true) {
      await ensureTap(tester, createContactFinder.addEmergencyContact);
    }

    //set first Name, last Name and Notes
    await tester.enterText(
        createContactFinder.firstNameTextField, contact.firstName);
    await tester.enterText(
        createContactFinder.lastNameTextField, contact.lastName ?? '');
    await tester.enterText(
        createContactFinder.notesTextField, contact.notes ?? '');

    //click on Add phone depending on the number of num
    int phoneNumLength = contact.contactNumber.length;
    while (phoneNumLength != 1) {
      await ensureTap(tester, createContactFinder.addPhoneButton);
      phoneNumLength--;
    }

    for (var num in contact.contactNumber) {
      int numInd = contact.contactNumber.indexOf(num);
      final Text textWidget =
          tester.widget(find.byKey(Key('numType-$numInd'))) as Text;
      final String numType = textWidget.data!;

      if (numType != num.typeName.name) {
        await ensureTap(
            tester, find.byKey(Key('numType-dropdown-button$numInd')));
        await ensureTap(tester, find.text(num.typeName.name));
      }
      await tester.enterText(
          find.byKey(Key('numType-textField$numInd')), num.digit);
    }

    await tester.pump();
    Text buttonWidget = tester.widget(find.text('Done'));
    expect(buttonWidget.style!.color, Colors.blue);

    await ensureTap(tester, createContactFinder.doneButton);
  }
}
