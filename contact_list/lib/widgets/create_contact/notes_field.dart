import 'package:flutter/material.dart';

Widget notesInputField(
    {required BuildContext context,
    required TextEditingController enteredNotes,
    required Function(String) validateForm}) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
    color: Theme.of(context).colorScheme.primaryContainer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
              color: Theme.of(context).iconTheme.color!.withOpacity(.5),
              fontSize: 16),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          style: TextStyle(
              color: Theme.of(context).iconTheme.color!.withOpacity(1),
              fontSize: 15),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 20, left: 0, right: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(top: Radius.zero),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.text,
          maxLines: null,
          controller: enteredNotes,
          onChanged: validateForm,
        )
      ],
    ),
  );
}
