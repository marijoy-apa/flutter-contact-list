import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/providers/search_list_provider.dart';
import 'package:contact_list/screen/contact_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactItem extends ConsumerWidget {
  const ContactItem({
    super.key,
    required this.contactItem,
    required this.index,
    required this.screen,
  });

  final ContactInfo contactItem;
  final int index;
  final String screen;

  void navigateToContactDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactDetailsScreen(contactItem: contactItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String fullName = contactItem.firstName;
    if (contactItem.lastName != null) {
      fullName = "${contactItem.firstName} ${contactItem.lastName!}";
    }
    final contactList = screen == 'contacts'
        ? ref.watch(filteredListProvider)
        : ref.watch(emergencyListProvider);
    bool isEmergencyContact = contactList[index].emergencyContact;

    return Container(
      alignment: Alignment.topLeft,
      height: 50,
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 0),
        onTap: () => navigateToContactDetails(context),
        shape: Border(
          bottom:
              BorderSide(color: Theme.of(context).iconTheme.color!, width: 0.3),
        ),
        title: Text(
          fullName.length<20 ? fullName : fullName.substring(0, 22),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.9)),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  ref
                      .read(contactListProvider.notifier)
                      .onToggleEmergencyContact(contactItem);
                },
                icon: Icon(
                  isEmergencyContact
                      ? Icons.emergency
                      : Icons.emergency_outlined,
                  color: isEmergencyContact ? Colors.red : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(contactListProvider.notifier)
                      .onToggleDeleteContact(contactItem, index);
                },
                icon: const Icon(Icons.delete_outline),
              )
            ],
          ),
        ),
      ),
    );
  }
}
