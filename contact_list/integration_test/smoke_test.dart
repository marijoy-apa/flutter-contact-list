import 'package:contact_list/screen/splash_screen.dart';
import 'package:contact_list/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:contact_list/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<void> ensureTap(WidgetTester tester, Finder finder) async {
    tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  group('end-to-end-testing', () {
    final doneButton = find.widgetWithText(TextButton, 'Done');
    final addPhoneButton = find.byIcon(Icons.add_circle);
    final phoneTextField = find.widgetWithText(TextField, 'Phone');
    final addEmergencyContact = find.text('Add to emergency contacts');
    final removeEmergencyContact = find.text('Remove from emergency contacts');
    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    final firstNameTextField = find.widgetWithText(TextField, 'First Name');
    final lastNameTextField = find.widgetWithText(TextField, 'Last Name');
    testWidgets('Able to create new contact', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final addButton = find.byType(FloatingActionButton);
      await tester.tap(addButton);
      await tester.pump();
      await tester.enterText(firstNameTextField, 'John');
      await tester.enterText(phoneTextField, '0909090909');
      await tester.pump();
      Text buttonWidget = tester.widget(find.text('Done'));
      expect(buttonWidget.style!.color, Colors.blue);

      await ensureTap(tester, doneButton);
      expect(find.byWidget(ContactsScreen()), findsNothing);
    });
  });
}
