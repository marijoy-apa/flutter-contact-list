import 'package:flutter/material.dart';

Widget searchContainer({
  required BuildContext context,
  required TextEditingController searchController,
  required Function(String value) onChangedSearchText,
  required Function() onClickClose,
}) =>
    Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 13),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.left,
              controller: searchController,
              onChanged: onChangedSearchText,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
                contentPadding: const EdgeInsets.all(0),
                alignLabelWithHint: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: onClickClose,
                  icon: Icon(
                    Icons.cancel,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                    semanticLabel: 'clearBtn',
                  ),
                  padding: const EdgeInsets.only(right: 20),
                )
              : const SizedBox(),
        ],
      ),
    );
