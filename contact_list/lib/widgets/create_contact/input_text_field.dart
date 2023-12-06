import 'package:flutter/material.dart';

Widget inputTextField(
    {required TextEditingController controller,
    required String fieldName,
    required TextInputType textInputype,
    required BuildContext context,
    required Function(String value) validateForm,
    String? Function(String? value)? validator,
    bool border = false,
    Key? inputKey}) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
            bottom: border
                ? BorderSide(
                    width: 0.3, color: Theme.of(context).iconTheme.color!)
                : BorderSide.none)),
    child: TextFormField(
        key: inputKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: validateForm,
        controller: controller,
        keyboardType: textInputype,
        style: TextStyle(
            color: Theme.of(context).iconTheme.color!.withOpacity(1),
            fontSize: 16),
        textAlign: TextAlign.left,
        scrollPadding: const EdgeInsets.only(left: 0),
        decoration: textFieldInputDecoration(fieldName, context, border)),
  );
}

InputDecoration textFieldInputDecoration(
        String text, BuildContext context, bool border) =>
    InputDecoration(
      errorStyle: const TextStyle(
        fontSize: 9,
        height: 0,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.zero),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.primaryContainer,
      hintText: text,
      hintStyle: TextStyle(
        color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
        fontWeight: FontWeight.w200,
        fontSize: 16,
      ),
      contentPadding: const EdgeInsets.only(left: 20, bottom: 0),
    );
