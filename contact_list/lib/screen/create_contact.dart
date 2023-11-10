import 'dart:io';

import 'package:contact_list/model/contacts.dart';
import 'package:contact_list/model/number.dart';
import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/widgets/create_contact/add_button.dart';
import 'package:contact_list/widgets/create_contact/app_bar.dart';
import 'package:contact_list/widgets/create_contact/notes_field.dart';
import 'package:contact_list/widgets/create_contact/set_emergency_button.dart';
import 'package:contact_list/widgets/create_contact/image_picker.dart';
import 'package:contact_list/widgets/create_contact/input_text_field.dart';
import 'package:contact_list/widgets/create_contact/contact_number_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNewContactScreen extends ConsumerStatefulWidget {
  const CreateNewContactScreen({super.key});

  @override
  ConsumerState<CreateNewContactScreen> createState() =>
      _CreateNewContactScreenState();
}

class _CreateNewContactScreenState
    extends ConsumerState<CreateNewContactScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController enteredFirstName = TextEditingController();
  TextEditingController enteredLastName = TextEditingController();
  TextEditingController enteredNotes = TextEditingController();

  File? _selectedImage;
  bool isEmergencyContact = false;
  ContactInfo? newContact;
  bool isFormValid = false;
  List<NumberTypes> numTypeSelected = [NumberTypes.Phone];
  List<TextEditingController> phoneController = [TextEditingController()];
  List<NumberList> numberList = [];

  @override
  void dispose() {
    enteredFirstName.dispose();
    enteredLastName.dispose();
    enteredNotes.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final numList = getValidNumberList();

    newContact = ContactInfo(
        firstName: enteredFirstName.text,
        lastName: enteredLastName.text,
        contactNumber: numList,
        imageFile: _selectedImage,
        emergencyContact: isEmergencyContact,
        notes: enteredNotes.text);

    Navigator.of(context).pop();
  }

  void validateForm(String value) {
    if (enteredFirstName.text.trim().isNotEmpty &&
        getValidNumberList().isNotEmpty) {
      setState(() {
        isFormValid = true;
      });
    } else {
      setState(() {
        isFormValid = false;
      });
    }
  }

  void addPhoneNumberField() {
    setState(() {
      phoneController.add(TextEditingController());
      numTypeSelected.add(NumberTypes.Phone);
    });
  }

  void setNumTypeSelected(int i, NumberTypes val) {
    setState(() {
      numTypeSelected[i] = val;
    });
  }

  void setEmergencyContact() {
    setState(() {
      isEmergencyContact = !isEmergencyContact;
    });
  }

  void onAddContact() {
    if (isFormValid) {
      _onSubmit();
      ref.read(contactListProvider.notifier).onAddNewContact(newContact!);
    } else {
      null;
    }
  }

  List<NumberList> getValidNumberList() {
    numberList = [];
    for (int i = 0; i < phoneController.length; i++) {
      numberList.add(NumberList(numTypeSelected[i], phoneController[i].text));
    }

    final validNumList = numberList
        .where((number) =>
            number.digit.trim().isNotEmpty &&
            !number.digit.contains(RegExp(r'[a-zA-Z]')) &&
            number.digit.trim().length < 13)
        .toList();
    return validNumList;
  }

  Widget phoneFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < phoneController.length; i++) {
      textFields.add(inputContactNumber(
        index: i,
        context: context,
        numTypeSelected: numTypeSelected[i].name,
        onSelectNumType: setNumTypeSelected,
        phoneController: phoneController,
        validateForm: validateForm,
        numTypeSelectedGV: numTypeSelected[i],
      ));
    }
    return Column(
      children: textFields,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Scaffold(
        appBar: CreateContactAppBar(
          onSubmit: onAddContact,
          isFormValid: isFormValid,
          page: 'Done',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserImagePicker(
                    pickedImage: _selectedImage,
                    onPickImage: (pickedImage) => _selectedImage = pickedImage,
                    onValidateForm: (value) => validateForm(value),
                  ),
                  const SizedBox(height: 16),
                  inputTextField(
                      context: context,
                      validateForm: validateForm,
                      controller: enteredFirstName,
                      fieldName: 'First Name',
                      textInputype: TextInputType.text,
                      border: true),
                  inputTextField(
                      context: context,
                      validateForm: validateForm,
                      controller: enteredLastName,
                      fieldName: 'Last Name',
                      textInputype: TextInputType.text),
                  const SizedBox(height: 32),
                  phoneFields(),
                  const SizedBox(height: 12),
                  addButton(onChange: addPhoneNumberField),
                  const SizedBox(height: 12),
                  notesInputField(
                      context: context,
                      enteredNotes: enteredNotes,
                      validateForm: validateForm),
                  const SizedBox(height: 12),
                  setEmergencyContactButton(
                    onTap: setEmergencyContact,
                    context: context,
                    isEmergencyContact: isEmergencyContact,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
