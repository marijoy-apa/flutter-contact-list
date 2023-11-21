// import 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:contact_list/model/number.dart';
import 'package:http/http.dart' as http;

// final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

// class Database {
//   Future<http.Response> loadDatabase({http.Client? client}) async {
//     final uri = Uri.https(projectUrl, 'contact-list.json');
//     return await (client ?? http.Client()).get(uri);
//   }
// }

import 'package:contact_list/model/contacts.dart';

final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

Future<List<ContactInfo>> fetchContacts(http.Client client) async {
  final uri = Uri.https(projectUrl, 'contact-list.json');

  final response = await client.get(uri);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return convertToList(response);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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
        final numType = NumberTypes.values
            .firstWhere((enumValue) => enumValue.name == numberData['numType']);
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
