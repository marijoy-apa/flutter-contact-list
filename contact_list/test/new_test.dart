import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
// import 'package:mocking/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


@GenerateMocks([http.Client])
void main() {
  test('Returns response', () async {
    final projectUrl = 'flutter-contact-list-e240c-default-rtdb.firebaseio.com';

    final uri = Uri.https(projectUrl, 'contact-list.json');
    final client = MockClient((request) async {
      return http.Response(
          '{"-NjfInGDS-nF9jBCYNFw":{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"2342342323","numType":"Phone"}]}}',
          200,
          headers: {'content-type': 'application/json'});
    });

    final expectedResponse = http.Response(
        '{"-NjfInGDS-nF9jBCYNFw":{"emergencyContact":false,"firstName":"Name","lastName":"","notes":"","number":[{"contactNum":"2342342323","numType":"Phone"}]}}',
        200);

    // Mock the HTTP client to return the expected response
    when(client.get(uri)).thenAnswer((_) async => expectedResponse);
  });
}
