import 'package:flutter/material.dart';

Widget setEmergencyContactButton({
  required onTap,
  required BuildContext context,
  required bool isEmergencyContact,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          isEmergencyContact
              ? 'Remove from emergency contacts'
              : 'Add to emergency contacts',
          style: TextStyle(
              color: isEmergencyContact ? Colors.red : Colors.blue,
              fontSize: 16),
        ),
      ),
    );
