// import 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:contact_list/model/number.dart';
import 'package:contact_list/services/add_contact.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list/model/contacts.dart';

class FetchContactServices {
  const FetchContactServices();


  Future<List<ContactInfo>> fetchContacts({http.Client? client}) async {
    final uri = Uri.https(projectUrl, 'contact-list.json');

    final response = await (client ?? http.Client()).get(uri);

    if (response.statusCode == 200) {
      return convertToList(response);
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  List<ContactInfo> convertToList(response) {
    if (response.body == 'null') {
      return [];
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<ContactInfo> _loadedItems = [];

    for (var data in listData.entries) {
      //fetching numberList object from db
      final List<dynamic> contactNumberData = data.value['number'];
      final List<NumberList> contactNumbers = contactNumberData.map(
        (numberData) {
          final numType = NumberTypes.values.firstWhere(
              (enumValue) => enumValue.name == numberData['numType']);
          return NumberList(
            numType,
            numberData['contactNum'],
          );
        },
      ).toList();

      //to check if imageFile is empty
      File? imageFile;
      if (data.value['imageFile'] != null) {
        imageFile = File(data.value['imageFile']);
      }

      _loadedItems.add(
        ContactInfo(
          id: data.key,
          firstName: data.value['firstName'],
          lastName: data.value['lastName'],
          contactNumber: contactNumbers,
          imageFile: imageFile,
          emergencyContact: data.value['emergencyContact'],
          notes: data.value['notes'],
        ),
      );
    }
    return _loadedItems;
  }
}
