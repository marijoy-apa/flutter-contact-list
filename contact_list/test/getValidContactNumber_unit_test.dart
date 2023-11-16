import 'package:contact_list/screen/create_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contact_list/model/number.dart';

void main() {
  group('Test getValidNumberList', () {
    final createNewContactScreen = CreateNewContactScreenState();

    test('Test with valid input', () {
      createNewContactScreen.phoneController = [
        TextEditingController(text: '1234567890'),
        TextEditingController(text: '9876543210'),
      ];
      createNewContactScreen.numTypeSelected = [
        NumberTypes.Phone,
        NumberTypes.Main
      ];
      List<NumberList> validNumberList =
          createNewContactScreen.getValidNumberList();
      expect(validNumberList.length, 2);
      expect(validNumberList[0].digit, '1234567890');
      expect(validNumberList[1].digit, '9876543210');
      expect(validNumberList[0].typeName, NumberTypes.Phone);
      expect(validNumberList[1].typeName, NumberTypes.Main);
    });

    test('Test with invalid input', () {
      createNewContactScreen.phoneController = [
        TextEditingController(text: 'abc123'),
        TextEditingController(text: '12312312323131312312313'),
        TextEditingController()
      ];
      createNewContactScreen.numTypeSelected = [
        NumberTypes.Phone,
        NumberTypes.Pager, 
        NumberTypes.Other
      ];
      List<NumberList> invalidNumberList =
          createNewContactScreen.getValidNumberList();
      expect(invalidNumberList.length, 0);
    });

        test('Test with valid & invalid input', () {
      createNewContactScreen.phoneController = [
        TextEditingController(text: 'abc123'),
        TextEditingController(text: '1231232'),
        TextEditingController()
      ];
      createNewContactScreen.numTypeSelected = [
        NumberTypes.Phone,
        NumberTypes.Pager, 
        NumberTypes.Other
      ];
      List<NumberList> invalidNumberList =
          createNewContactScreen.getValidNumberList();
      expect(invalidNumberList.length, 1);
    });

    test('Test with empty input', () {
      createNewContactScreen.phoneController = [
        TextEditingController(),
      ];
      createNewContactScreen.numTypeSelected = [NumberTypes.Custom];
      List<NumberList> emptyNumberList =
          createNewContactScreen.getValidNumberList();
      expect(emptyNumberList.length, 0);
    });
  });
}
