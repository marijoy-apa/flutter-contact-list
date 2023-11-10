import 'package:contact_list/model/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ActionIcons extends StatelessWidget {
  const ActionIcons({super.key, required this.numberList});

  final List<NumberList> numberList;

  Widget iconContainer({
    required IconData icon,
    required String label,
    required Function() onCall,
    required bool state,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onCall,
      child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 70,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: state
                  ? Colors.blue
                  : Theme.of(context).iconTheme.color!.withOpacity(0.3),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                color: state
                    ? Colors.blue
                    : Theme.of(context).iconTheme.color!.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCall(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
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
        iconContainer(
            icon: Icons.chat,
            label: 'Message',
            onCall: () {},
            state: false,
            context: context),
        iconContainer(
            icon: Icons.call_sharp,
            label: 'Call',
            onCall: () {
              onTapCall(context);
            },
            state: true,
            context: context),
        iconContainer(
            icon: Icons.videocam,
            label: 'Video',
            onCall: () {},
            state: false,
            context: context),
        iconContainer(
            icon: Icons.mail_rounded,
            label: 'Mail',
            onCall: () {},
            state: false,
            context: context),
      ],
    );
  }
}
