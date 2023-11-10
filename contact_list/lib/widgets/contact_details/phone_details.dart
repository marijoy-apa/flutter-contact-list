import 'package:contact_list/model/number.dart';
import 'package:flutter/material.dart';

Widget phoneDetailsContainer(BuildContext context, List<NumberList> phoneNum) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Column(
          children: phoneInfos(lists: phoneNum, context: context),
        ),
        );


Widget phoneInfo({required BuildContext context, required NumberList number}) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number.typeName.name,
          style:
              TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 13),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          number.digit,
          style: const TextStyle(fontSize: 20, color: Colors.blue),
        )
      ],
    ),
  );
}

List<Widget> phoneInfos(
    {required List<NumberList> lists, required BuildContext context}) {
  List<Widget> widgets = [];

  for (var list in lists) {
    widgets.add(phoneInfo(context: context, number: list));
    if (list != lists.last) {
      widgets.add(const Divider(thickness: 0.4,));
    }
  }

  return widgets;
}
