import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';

final contactListTest = [
  ContactInfo(
    firstName: 'Andrea',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
    ],
    emergencyContact: false,
  ),
  ContactInfo(
    firstName: 'Bernard',
    lastName: 'Doe',
    emergencyContact: false,
    notes: 'This is a friend',
    contactNumber: [
      NumberList(NumberTypes.Phone, '1212121'),
    ],
  ),
  ContactInfo(
    firstName: 'Collar',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
      NumberList(NumberTypes.Mobile, '09090232'),
      NumberList(NumberTypes.Fax, '09090232'),
      NumberList(NumberTypes.Mobile, '23423432'),
    ],
  ),
  ContactInfo(
    firstName: 'Defe',
    lastName: 'Hawking',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
    ],
  ),
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
