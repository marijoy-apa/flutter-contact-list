import 'dart:convert';

import 'package:contact_list/services/add_contact.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list/model/contacts.dart';

Future<http.Response> updateContact(
    {http.Client? client, required ContactInfo contact}) async {
  final contactNumberList = convertNumberList(contact.contactNumber);
  final uri = Uri.https(projectUrl, 'contact-list/${contact.id}.json');

  try {
    final response = await (client ?? http.Client()).put(
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
