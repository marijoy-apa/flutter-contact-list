import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/contact_list.dart';

void main() {
  test('Verify correct return data type for contact list provider', () {
    final container = ProviderContainer(overrides: [
      contactListProvider.overrideWith(
          (ref) => ContactListNotifier(contactList: contactListTest))
    ]);
    expect(container.read(contactListProvider), isA<List<ContactInfo>>());
  });

  test('Verify correct return data type for emergency list provider', () {
    final container = ProviderContainer(overrides: [
      contactListProvider.overrideWith(
          (ref) => ContactListNotifier(contactList: contactListTest))
    ]);
    expect(container.read(emergencyListProvider), isA<List<ContactInfo>>());
  });

  test('Verify correct return data type for filtered list provider', () {
    final container = ProviderContainer(overrides: [
      contactListProvider.overrideWith(
          (ref) => ContactListNotifier(contactList: contactListTest))
    ]);
    expect(container.read(filteredListProvider), isA<List<ContactInfo>>());
  });

  test('Verify correct return data type for search keyword provider', () {
    final container = ProviderContainer(overrides: [
      contactListProvider.overrideWith(
          (ref) => ContactListNotifier(contactList: contactListTest)),
      searchKeywordProvider
          .overrideWith((ref) => SearchUserController(searchString: 'Bernard'))
    ]);
    expect(container.read(searchKeywordProvider), isA<String>());
  });

  test('Verify correct return data type when searching user', () {
    final container = ProviderContainer(overrides: [
      contactListProvider.overrideWith(
          (ref) => ContactListNotifier(contactList: contactListTest)),
      searchKeywordProvider
          .overrideWith((ref) => SearchUserController(searchString: 'Bernard'))
    ]);
    expect(container.read(filteredListProvider).length, 1);
  });
}
