import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';

var contactList = [
  ContactInfo(
    firstName: 'Tony',
    lastName: 'Stark',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Thor',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Steven',
    lastName: 'Rogers',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Clinton',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Jessie',
    lastName: 'Mendez',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Taylor',
    contactNumber: const [
      NumberList(NumberTypes.Phone, '0909090'),
      NumberList(NumberTypes.Mobile, '09090232'),
      NumberList(NumberTypes.Fax, '09090232'),
      NumberList(NumberTypes.Mobile, '23423432'),
    ],
  ),
  ContactInfo(
    firstName: 'Steven',
    lastName: 'Hawking',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Mary',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    emergencyContact: false,
  ),
  ContactInfo(
    firstName: 'Joseph',
    lastName: 'Dela Cruz',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    emergencyContact: true,
  ),
  ContactInfo(
    firstName: 'Tina',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    emergencyContact: false,
  ),
  ContactInfo(
    firstName: 'Jahel',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    emergencyContact: true,
  ),
  ContactInfo(
    firstName: 'Clinton',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    emergencyContact: true,
  ),
  ContactInfo(
    firstName: 'Jessie',
    lastName: 'Mendez',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
  ContactInfo(
    firstName: 'Adam',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
    notes: "Ah, Adam! He's not just a friend; he's a chapter in my life's adventure novel. College brought us together, and our shared love for the great outdoors led us on epic hikes with tales of laughter, challenges, and breathtaking views. But it doesn't end there - he's a culinary wizard! Those dinner parties at his place? Unforgettable. Keep John in the loop for our next Yosemite escapade. I can't wait for the next thrilling chapter of our friendship story!"
  ),
  ContactInfo(
    firstName: 'Steven',
    lastName: 'Hawking',
    contactNumber: const [NumberList(NumberTypes.Phone, '0909090')],
  ),
];
