import 'package:flutter/material.dart';

Widget notesDetailsContainer(BuildContext context, String notes) => Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: TextStyle(
                color: Theme.of(context).iconTheme.color, fontSize: 13),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              notes,
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(.7), fontSize: 13),
            ),
          ),
        ],
      ),
    );
