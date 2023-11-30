import 'package:contact_list/model/number.dart';
import 'package:contact_list/widgets/contact_details/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ActionIcons extends StatelessWidget {
  const ActionIcons({
    super.key,
    required this.numberList,
  });

  final List<NumberList> numberList;

  void onCall(String number, {phoneDirectCaller}) async {
    phoneDirectCaller == null
        ? await FlutterPhoneDirectCaller.callNumber(number)
        : await phoneDirectCaller.callNumber(number);
  }

  void onTapCall(BuildContext context) {
    if (numberList.length == 1) {
      String num = numberList[0].digit;
      onCall(num);
    } else if (numberList.length > 1) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: Theme.of(context).primaryColor,
          child: SizedBox(
            width: 300,
            height: numberList.length * 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: numberList
                  .map(
                    (number) => RadioListTile(
                      dense: true,
                      value: number,
                      groupValue: null,
                      onChanged: (val) {
                        NumberList newNum = val!;
                        Navigator.of(context).pop();
                        onCall(newNum.digit);
                      },
                      title: Text("${number.digit} (${number.typeName.name})"),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconContainer(
          icon: Icons.chat,
          label: 'Message',
          onCall: () {},
          state: false,
        ),
        IconContainer(
          icon: Icons.call_sharp,
          label: 'Call',
          onCall: () {
            onTapCall(context);
          },
          state: true,
        ),
        IconContainer(
          icon: Icons.videocam,
          label: 'Video',
          onCall: () {},
          state: false,
        ),
        IconContainer(
          icon: Icons.mail_rounded,
          label: 'Mail',
          onCall: () {},
          state: false,
        ),
      ],
    );
  }
}
