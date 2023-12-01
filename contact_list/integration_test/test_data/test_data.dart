import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';

class TestData {
  final fullDetailsContactInfo = ContactInfo(
    firstName: 'John',
    lastName: 'Napoleon',
    emergencyContact: true,
    notes: 'This is a test note. Please ignore.',
    contactNumber: [
      NumberList(NumberTypes.Fax, '0909090909'),
      NumberList(NumberTypes.Phone, '1912345678')
    ],
  );
}
