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

  final List<ContactInfo> emergencyContact = [
    ContactInfo(
      firstName: 'Eme',
      lastName: 'Rgency',
      emergencyContact: true,
      notes: 'This is a test note for Emergency Contact 1. Please ignore.',
      contactNumber: [
        NumberList(NumberTypes.Phone, '0909090909'),
        NumberList(NumberTypes.Mobile, '23423432'),
        NumberList(NumberTypes.Main, '1912345678'),
      ],
    ),
    ContactInfo(
      firstName: 'Dear',
      lastName: 'Santa',
      emergencyContact: true,
      notes: 'This is a test note for Emergency Contact 2. Please ignore.',
      contactNumber: [
        NumberList(NumberTypes.Phone, '23423423'),
      ],
    ),
    ContactInfo(
      firstName: 'Triad',
      lastName: 'Error',
      emergencyContact: false,
      notes: 'This is a test note for Emergency Contact 3. Please ignore.',
      contactNumber: [
        NumberList(NumberTypes.Main, '3123123'),
      ],
    ),
    ContactInfo(
      firstName: 'Four',
      lastName: 'Reynold',
      emergencyContact: true,
      notes: 'This is a test note for Emergency Contact 4. Please ignore.',
      contactNumber: [
        NumberList(NumberTypes.Phone, '234234'),
        NumberList(NumberTypes.Mobile, '23423432'),
        NumberList(NumberTypes.Main, '1912345678'),
      ],
    ),
  ];
}
