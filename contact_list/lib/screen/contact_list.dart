import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:contact_list/screen/create_contact.dart';
import 'package:contact_list/widgets/contact_list/contact_item.dart';
import 'package:contact_list/widgets/contact_list/error_fetching.dart';
import 'package:contact_list/widgets/contact_list/loading.dart';
import 'package:contact_list/widgets/contact_list/no_list_added.dart';
import 'package:contact_list/widgets/contact_list/no_search_result.dart';
import 'package:contact_list/widgets/contact_list/search_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactList extends ConsumerStatefulWidget {
  ContactList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ContactListState();
  }
}

class _ContactListState extends ConsumerState<ContactList> {
  late Future<void> contactList;
  bool isLoading = false;

  final TextEditingController searchKeyword = TextEditingController();

  void _navigateToCreateContact(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      context: context,
      builder: (context) => const CreateNewContactScreen(),
    );
  }

  @override
  void initState() {
    ref.read(contactListProvider.notifier).loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactLists = ref.watch(filteredListProvider);
    final searchItem = ref.watch(searchKeywordProvider);
    final isLoading = ref.watch(contactListProvider.notifier).isLoading;
    final error = ref.watch(contactListProvider.notifier).error;
    
    searchKeyword.text = searchItem;

    Widget content = noListAdded('Contacts', context);

    if (error.isNotEmpty) {
      content = errorMessage(error, context);
    } else if (isLoading) {
      content = loadingWidget(searchItem, context);
    } else if (contactLists.isEmpty && searchItem.trim().isNotEmpty) {
      content = NoSearchResult(searchItem: searchItem,);
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Center(child: Text('Contacts')),

      ),
      body: Column(
        children: [
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
          contactLists.isEmpty
              ? content
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => ref.read(contactListProvider.notifier).loadItems(),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 25, right: 15),
                      itemCount: contactLists.length,
                      itemBuilder: (context, index) => ContactItem(
                        contactItem: contactLists[index],
                        index: index,
                        screen: 'contacts',
                      ),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: 
      error.isEmpty ? 
      FloatingActionButton(
        onPressed: () {
          _navigateToCreateContact(context);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ) 
      : null,
    );
  }
}
