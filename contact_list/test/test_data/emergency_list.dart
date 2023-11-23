import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';

final emergencyListTest = [
  ContactInfo(
    firstName: 'Joseph',
    lastName: 'Dela Cruz',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
    ],
    emergencyContact: true,
  ),
  ContactInfo(
    firstName: 'Tina',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
    ],
    emergencyContact: true,
  ),
];
