import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/screen/edit_contact.dart';
import 'package:contact_list/widgets/contact_details/action_icon.dart';
import 'package:contact_list/widgets/contact_details/notes_details.dart';
import 'package:contact_list/widgets/contact_details/phone_details.dart';
import 'package:contact_list/widgets/contact_details/profile_avatar.dart';
import 'package:contact_list/widgets/create_contact/set_emergency_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactDetailsScreen extends ConsumerWidget {
  const ContactDetailsScreen({super.key, required this.contactItem});

  final ContactInfo contactItem;

  onClickEdit(BuildContext context, ContactInfo contact) {
    print(contactItem.imageFile);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditContactScreen(contactItem: contact),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ContactInfo contact = contactItem;
    final String error = ref.watch(contactListProvider.notifier).error;
    try {
      contact = ref
          .watch(contactListProvider)
          .where((list) => list.id == contactItem.id)
          .toList()[0];
    } catch (e) {
      
    }

    String fullName = contactItem.firstName;
    if (contactItem.lastName != null) {
      fullName = "${contactItem.firstName} ${contactItem.lastName!}";
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 120,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          label: const Text(
            'Contacts',
            style: TextStyle(color: Colors.blue),
          ),
          style: TextButton.styleFrom(padding: const EdgeInsets.only(left: 0)),
        ),
        actions: [
          TextButton(
              onPressed: () {
                onClickEdit(context, contact);
              },
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              profileAvatar(context, contactItem),
              const SizedBox(height: 16),
              Text(
                fullName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.7)),
              ),
              const SizedBox(height: 20),
              ActionIcons(
                numberList: contactItem.contactNumber,
              ),
              const SizedBox(height: 50),
              phoneDetailsContainer(context, contactItem.contactNumber),
              const SizedBox(height: 12),
              notesDetailsContainer(
                context,
                contactItem.notes ?? '',
              ),
              const SizedBox(height: 12),
              setEmergencyContactButton(
                  onTap: () {
                    if (error.isNotEmpty) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                        ),
                      );
                      return;
                    }
                    ref
                        .read(contactListProvider.notifier)
                        .onToggleEmergencyContact(contact);
                  },
                  context: context,
                  isEmergencyContact: contact.emergencyContact),
            ],
          ),
        ),
      ),
    );
  }
}
