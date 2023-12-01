import 'package:contact_list/model/contacts.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
