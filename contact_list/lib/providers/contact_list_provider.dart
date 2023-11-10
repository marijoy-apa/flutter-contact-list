import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contact_list/data/dummy_data.dart';

class ContactListNotifier extends StateNotifier<List<ContactInfo>> {
  ContactListNotifier() : super(_sortContacts(contactList));

  void onToggleEmergencyContact(ContactInfo contact) {
    state = state.map((list) {
      if (list.id == contact.id) {
        return list.copyWith(
          emergencyContact: !list.emergencyContact,
          id: contact.id,
        );
      }
      return list;
    }).toList();
  }

  void onToggleDeleteContact(ContactInfo contact, int index) {
    final updatedContacts = [...state];
    updatedContacts.remove(contact);
    state = updatedContacts;
  }

  void onAddNewContact(ContactInfo contact) {
    final updated = [...state, contact];
    state = _sortContacts(updated);
  }

  void onEditContact(ContactInfo contact) {
    state = state.map((list) {
      if (list.id == contact.id) {
        print(list.id);
        print(contact.id);
        return contact.copyWith(id: list.id);
      }
      return list;
    }).toList();
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
