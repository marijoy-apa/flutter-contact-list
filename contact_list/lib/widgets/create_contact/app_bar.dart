import 'package:flutter/material.dart';

class CreateContactAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateContactAppBar(
      {super.key, required this.onSubmit, required this.isFormValid, required this.page});

  final Function() onSubmit;
  final bool isFormValid;
  final String page;
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      centerTitle: true,
      leadingWidth: 80,
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onSubmit,
          child: Text(
            page,
            style: TextStyle(
                color: isFormValid
                    ? Colors.blue
                    : Theme.of(context).iconTheme.color!.withOpacity(0.3),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
