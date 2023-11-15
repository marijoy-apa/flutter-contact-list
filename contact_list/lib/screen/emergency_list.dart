import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:contact_list/widgets/contact_list/contact_item.dart';
import 'package:contact_list/widgets/contact_list/error_fetching.dart';
import 'package:contact_list/widgets/contact_list/loading.dart';
import 'package:contact_list/widgets/contact_list/no_list_added.dart';
import 'package:contact_list/widgets/contact_list/no_search_result.dart';
import 'package:contact_list/widgets/contact_list/search_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyList extends ConsumerWidget {
  EmergencyList({super.key});
  final TextEditingController searchKeyword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emergencyList = ref.watch(emergencyListProvider);
    final searchItem = ref.watch(searchKeywordProvider);
    final isLoading = ref.watch(contactListProvider.notifier).isLoading;
    final error = ref.watch(contactListProvider.notifier).error;

    searchKeyword.text = searchItem;

    Widget content = noListAdded('Emergency Contacts', context);

    if (error.isNotEmpty) {
      content = errorMessage(error, context);
    } else if (isLoading) {
      content = loadingWidget(searchItem, context);
    } else if (emergencyList.isEmpty && searchItem.trim().isNotEmpty) {
      content = noSearchResult(searchItem, context);
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Center(child: Text('Emergency List')),
      ),
      body: Column(children: [
        searchContainer(
            context: context,
            searchController: searchKeyword,
            onChangedSearchText: (value) {
              ref.read(searchKeywordProvider.notifier).onSearchUser(value);
            },
            onClickClose: () {
              FocusScope.of(context).unfocus();
              ref.read(searchKeywordProvider.notifier).onSearchUser('');
            }),
        emergencyList.isEmpty
            ? content
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 25, right: 15),
                  itemCount: emergencyList.length,
                  itemBuilder: (context, index) => ContactItem(
                      contactItem: emergencyList[index],
                      index: index,
                      screen: 'emergency'),
                ),
              ),
      ]),
    );
  }
}
