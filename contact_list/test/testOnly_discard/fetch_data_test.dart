// import 'package:contact_list/model/contacts.dart';
// import 'package:contact_list/services/fetch_contact.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/testing.dart';
// import 'package:mockito/annotations.dart';

// @GenerateMocks([http.Client])
// void main() {
//   test('Returns response', () async {
//     final client = MockClient((request) async {
//       return http.Response(
//           '{"-NjfInGDS-nF9jBCYNFw":{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"2342342323","numType":"Phone"}]}}',
//           200,
//           headers: {'content-type': 'application/json'});
//     });
//     expect(FetchContactServices().fetchContacts(client: client), isA<Future<List<ContactInfo>>>());
//   });
// }
