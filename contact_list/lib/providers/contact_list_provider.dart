import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:contact_list/services/add_contact.dart';
import 'package:contact_list/services/delete_contact.dart';
import 'package:contact_list/services/fetch_contact.dart';
import 'package:contact_list/services/update_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListNotifier extends StateNotifier<List<ContactInfo>> {
  ContactListNotifier({this.contactList})
      : super(contactList != null ? _sortContacts(contactList) : []);

  final List<ContactInfo>? contactList;

  bool isLoading = true;
  String error = '';

  void onToggleEmergencyContact(ContactInfo contact) async {
    error = '';
    state = state.map((list) {
      if (list.id == contact.id) {
        return list.copyWith(
          emergencyContact: !list.emergencyContact,
          id: contact.id,
        );
      }
      return list;
    }).toList();
    final updatedContact = contact.copyWith(
      emergencyContact: !contact.emergencyContact,
      id: contact.id,
    );
    if (contactList == null) {
      try {
        await updateContact(contact: updatedContact);
      } catch (e) {
        error = 'Unable to update data. Please try again later';
        state = [];
      }
    }
  }

  Future<void> loadItems() async {
    if (contactList == null) {
      try {
        final _loadedItems = await FetchContactServices().fetchContacts();
        state = _sortContacts(_loadedItems);
        if (_loadedItems.isEmpty) {
          state = [];
          isLoading = false;
          error = '';
          return;
        }
        isLoading = false;
        error = '';
      } catch (e) {
        error = 'Something went wrong. Please try again later.';
        isLoading = false;
        state = [];
      }
    }
  }

  void onToggleDeleteContact(ContactInfo contact, int index) async {
    final index = state.indexOf(contact);
    final updatedContacts = [...state];
    updatedContacts.remove(contact);
    state = updatedContacts;
    error = '';

    if (contactList == null) {
      try {
        final response = await deleteContact(contact: contact);

        if (response.statusCode >= 400) {
          final updatedContacts = [...state];
          updatedContacts.insert(index, contact);
          state = updatedContacts;
        }
      } catch (e) {
        error = 'Something went wrong. Please try again later.';
        isLoading = false;
        state = [];
      }
    }
  }

  void onAddNewContact(ContactInfo contact) async {
    final updated = [...state, contact];
    state = _sortContacts(updated);
    error = '';

    try {
      final response = await addContacts(contact: contact);
      if (response.statusCode != 200) {
        state = [];
        isLoading = false;
        error = 'Something went wrong please try again later. ';
      }
      loadItems();
    } catch (e) {
      print('oooops');
      state = [];
      isLoading = false;
      error = 'Something went wrong please try again later. ';
    }
  }

  void onEditContact(ContactInfo contact) async {
    state = state.map((list) {
      if (list.id == contact.id) {
        return contact.copyWith(id: list.id);
      }
      return list;
    }).toList();

    if (contactList == null) {
      try {
        await updateContact(contact: contact);
      } catch (e) {
        state = [];
        isLoading = false;
        error = 'Something went wrong please try again later. ';
      }
    }
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
