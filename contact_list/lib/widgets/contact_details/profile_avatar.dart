import 'package:contact_list/model/contacts.dart';
import 'package:flutter/material.dart';

Widget profileAvatar(BuildContext context, ContactInfo contactItem) => CircleAvatar(
                radius: 64,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundImage: contactItem.imageFile != null
                    ? FileImage(contactItem.imageFile!)
                    : null,
                child: Text(
                  contactItem.imageFile == null
                      ? contactItem.firstName[0].toUpperCase()
                      : '',
                  style: TextStyle(
                      fontSize: 60, color: Theme.of(context).iconTheme.color),
                ),
              );
