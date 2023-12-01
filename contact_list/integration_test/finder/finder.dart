import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CreateNewContactFinder {
  final doneButton = find.widgetWithText(TextButton, 'Done');
  final addPhoneButton = find.byIcon(Icons.add_circle);
  final phoneTextField = find.widgetWithText(TextField, 'Phone');
  final addEmergencyContact = find.text('Add to emergency contacts');
  final removeEmergencyContact = find.text('Remove from emergency contacts');
  final cancelButton = find.widgetWithText(TextButton, 'Cancel');
  final firstNameTextField = find.widgetWithText(TextField, 'First Name');
  final lastNameTextField = find.widgetWithText(TextField, 'Last Name');

  final notesTextField = find.descendant(
      of: find
          .ancestor(
            of: find.text('Notes'),
            matching: find.byType(Column),
          )
          .first,
      matching: find.byType(TextFormField));
}
