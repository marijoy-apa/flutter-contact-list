
import 'package:contact_list/services/add_contact.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list/model/contacts.dart';

Future<http.Response> deleteContact(
    {http.Client? client, required ContactInfo contact}) async {
  final url = Uri.https(projectUrl, 'contact-list/${contact.id}.json');
  try {
    final response = await (client ?? http.Client()).delete(url);

    print(response.body);
    print(response.statusCode);
    return response;
  } catch (e) {
    throw Exception(e);
  }
}