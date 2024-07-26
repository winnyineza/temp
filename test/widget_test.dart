import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp_converter/main.dart';

void main() {
  testWidgets('Temperature conversion test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const TempConverterApp());

    // Verify that the app title is displayed.
    expect(find.text('Temperature Converter'), findsOneWidget);

    // Enter a temperature value.
    await tester.enterText(find.byType(TextField), '100');

    // Select Fahrenheit to Celsius conversion.
    await tester.tap(find.text('Fahrenheit to Celsius'));
    await tester.pump(); // Rebuild the widget after the state has changed.

    // Tap the "CONVERT" button.
    await tester.tap(find.text('CONVERT'));
    await tester.pump(); // Trigger a frame to display the result.

    // Verify the output.
    expect(find.text('100.0'), findsOneWidget); // Input value
    expect(find.text('37.78'), findsOneWidget); // Converted value

    // Check the conversion history.
    expect(find.textContaining('F to C: 100.0 => 37.78'), findsOneWidget);
  });
}
