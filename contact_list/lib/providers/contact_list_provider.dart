import 'dart:convert';
import 'dart:io';

import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contact_list/data/dummy_data.dart';

import 'package:http/http.dart' as http;

final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

class ContactListNotifier extends StateNotifier<List<ContactInfo>> {
  ContactListNotifier() : super([]);

  void onToggleEmergencyContact(ContactInfo contact) async {
    state = state.map((list) {
      if (list.id == contact.id) {
        return list.copyWith(
          emergencyContact: !list.emergencyContact,
          id: contact.id,
        );
      }
      return list;
    }).toList();

    List<Map<String, dynamic>> contactNumberList =
        contact.contactNumber.map((contact) {
      return {
        'contactNum': contact.digit,
        'numType': contact.typeName.name,
      };
    }).toList();

    final uri = Uri.https(projectUrl, 'contact-list/${contact.id}.json');

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'firstName': contact.firstName,
          'lastName': contact.lastName,
          'number': contactNumberList,
          'imageFile': contact.imageFile?.path,
          'emergencyContact': !contact.emergencyContact,
          'notes': contact.notes,
        },
      ),
    );
  }

  Future<void> loadItems() async {
    final uri = Uri.https(projectUrl, 'contact-list.json');
    final response = await http.get(uri);

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<ContactInfo> _loadedItems = [];

    for (var data in listData.entries) {
      //fetching numberList object from db
      final List<dynamic> contactNumberData = data.value['number'];
      final List<NumberList> contactNumbers = contactNumberData.map(
        (numberData) {
          final numType = NumberTypes.values.firstWhere(
              (enumValue) => enumValue.name == numberData['numType']);
          return NumberList(
            numType,
            numberData['contactNum'],
          );
        },
      ).toList();

      //to check if imageFile is empty
      File? imageFile;
      if (data.value['imageFile'] != null) {
        imageFile = File(data.value['imageFile']);
      }

      _loadedItems.add(
        ContactInfo(
          id: data.key,
          firstName: data.value['firstName'],
          lastName: data.value['lastName'],
          contactNumber: contactNumbers,
          imageFile: imageFile,
          emergencyContact: data.value['emergencyContact'],
          notes: data.value['notes'],
        ),
      );
    }

    state = _sortContacts(_loadedItems);
  }

  void onToggleDeleteContact(ContactInfo contact, int index) async {
    final index = state.indexOf(contact);
    final updatedContacts = [...state];
    updatedContacts.remove(contact);
    state = updatedContacts;

    final url = Uri.https(projectUrl, 'contact-list/${contact.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      final updatedContacts = [...state];
      updatedContacts.insert(index, contact);
      state = updatedContacts;
    }
  }

  void onAddNewContact(ContactInfo contact) async {
    final updated = [...state, contact];
    state = _sortContacts(updated);

    List<Map<String, dynamic>> contactNumberList =
        contact.contactNumber.map((contact) {
      return {
        'contactNum': contact.digit,
        'numType': contact.typeName.name,
      };
    }).toList();

    final uri = Uri.https(projectUrl, 'contact-list.json');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'firstName': contact.firstName,
          'lastName': contact.lastName,
          'number': contactNumberList,
          'imageFile': contact.imageFile?.path,
          'emergencyContact': contact.emergencyContact,
          'notes': contact.notes,
        },
      ),
    );
  }

  void onEditContact(ContactInfo contact) async {
    state = state.map((list) {
      if (list.id == contact.id) {
        return contact.copyWith(id: list.id);
      }
      return list;
    }).toList();

    List<Map<String, dynamic>> contactNumberList =
        contact.contactNumber.map((contact) {
      return {
        'contactNum': contact.digit,
        'numType': contact.typeName.name,
      };
    }).toList();

    final uri = Uri.https(projectUrl, 'contact-list/${contact.id}.json');

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'firstName': contact.firstName,
          'lastName': contact.lastName,
          'number': contactNumberList,
          'imageFile': contact.imageFile?.path,
          'emergencyContact': contact.emergencyContact,
          'notes': contact.notes,
        },
      ),
    );
  }

  static List<ContactInfo> _sortContacts(List<ContactInfo> contacts) {
    return List.from(contacts)
      ..sort((a, b) =>
          a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
  }
}

final contactListProvider =
    StateNotifierProvider<ContactListNotifier, List<ContactInfo>>(
  (ref) => ContactListNotifier(),
);

final emergencyListProvider = Provider<List<ContactInfo>>((ref) {
  final contact = ref.watch(filteredListProvider);

  return contact
      .where((contactItem) => contactItem.emergencyContact == true)
      .toList();
});
