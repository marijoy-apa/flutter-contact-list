import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserController extends StateNotifier<String> {
  SearchUserController({this.searchString}) : super(searchString ?? '');

  final String? searchString;
  void onSearchUser(String query) {
    state = query;
  }
}

final searchKeywordProvider =
    StateNotifierProvider<SearchUserController, String>((ref) {
  return SearchUserController();
});

final filteredListProvider = Provider<List<ContactInfo>>((ref) {
  final contact = ref.watch(contactListProvider);
  final query = ref.watch(searchKeywordProvider);

  if (query.isNotEmpty) {
    final filteredList = contact
        .where((contactItem) =>
            '${contactItem.firstName} ${contactItem.lastName}'
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    return filteredList;
  } else {
    return contact;
  }
});
