import 'package:flutter/material.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/widgets/create_contact/input_text_field.dart';

Widget inputContactNumber({
  required int index,
  required BuildContext context,
  required String numTypeSelected,
  required List<TextEditingController> phoneController,
  required Function(int i, NumberTypes types) onSelectNumType,
  required Function(String value) validateForm,
  required NumberTypes numTypeSelectedGV,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Theme.of(context).iconTheme.color!, width: 0.3),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          key: Key('numType-dropdown-button$index'),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            height: 48,
            padding: const EdgeInsets.only(left: 20, right: 0, top: 3),
            width: 100,
            child: Row(
              children: [
                SizedBox(
                  width: 51,
                  child: Text(
                    key: Key('numType-$index'),
                    numTypeSelected,
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 12,
                    ),
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Theme.of(context).iconTheme.color,
                  size: 28,
                )
              ],
            ),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Theme.of(context).primaryColor,
              child: SizedBox(
                height: 400,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: NumberTypes.values
                      .map(
                        (type) => RadioListTile(
                          dense: true,
                          value: type,
                          groupValue: numTypeSelectedGV,
                          onChanged: (val) {
                            validateForm('value');
                            onSelectNumType(index, val!);
                            Navigator.of(context).pop();
                          },
                          title: Text(type.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 48,
          width: 0.3,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            color: Theme.of(context).iconTheme.color,
            width: 0.3,
          ),
        ),
        Expanded(
          child: inputTextField(
            inputKey: Key('numType-textField$index'),
            context: context,
            validateForm: validateForm,
            controller: phoneController[index],
            fieldName: numTypeSelected,
            textInputype: TextInputType.number,
            validator: (value) {
              if (value != null && value.length > 12) {
                return 'Please enter a valid phone number.\n';
              } else if (value != null && value.contains(RegExp(r'[a-zA-Z]'))) {
                return 'Phone numbers should contain digits only\n';
              }
              return null;
            },
          ),
        ),
      ],
    ),
  );
}
