import 'dart:convert';

import 'package:contact_list/services/add_contact.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list/model/contacts.dart';

class UpdateContactServices {
  const UpdateContactServices();

  Future<http.Response> updateContact(
      {http.Client? client, required ContactInfo contact}) async {
    final contactNumberList =
        AddContactServices().convertNumberList(contact.contactNumber);
    final uri = Uri.https(projectUrl, 'contact-list/${contact.id}.json');

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
  }
}
