import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';

final contactDetails = ContactInfo(
    firstName: 'Mary',
    lastName: 'Doe',
    emergencyContact: false,
    notes: 'This is a friend',
    contactNumber: [
      NumberList(NumberTypes.Phone, '1212121'),
    ]);

final multipleNum = ContactInfo(
  firstName: 'Mary',
  lastName: 'Doe',
  emergencyContact: false,
  notes: 'This is a friend',
  contactNumber: [
    NumberList(NumberTypes.Custom, '1212121'),
    NumberList(NumberTypes.Phone, '34234343'),
    NumberList(NumberTypes.Mobile, '123123'),
  ],
);

final emergencyContact = ContactInfo(
  firstName: 'Mary',
  lastName: 'Doe',
  emergencyContact: true,
  notes: 'This is a friend',
  contactNumber: [
    NumberList(NumberTypes.Custom, '1212121'),
  ],
);
