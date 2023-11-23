import 'dart:convert';

import 'package:contact_list/model/number.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list/model/contacts.dart';

final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

Future<http.Response> addContacts(
    {http.Client? client, required ContactInfo contact}) async {
  final contactNumberList = convertNumberList(contact.contactNumber);

  final uri = Uri.https(projectUrl, 'contact-list.json');
  try {
    final response = await (client ?? http.Client()).post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'firstName': contact.firstName,
          'lastName': contact.lastName,
          'number': contactNumberList,
          'imageFile': contact.imageFile?.path,
          'emergencyContact': contact.emergencyContact,
          'notes': contact.notes,
        },
      ),
    );
    return response;
  } catch (e) {
    throw Exception(e);
  }
}

List<Map<String, String>> convertNumberList(List<NumberList> contactNum) {
  return contactNum.map((contact) {
    return {
      'contactNum': contact.digit,
      'numType': contact.typeName.name,
    };
  }).toList();
}
