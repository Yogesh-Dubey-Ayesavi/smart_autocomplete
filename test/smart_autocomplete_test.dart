import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_autocomplete/smart_autocomplete.dart';

void main() {

  group('FutureWidget tests', () {
    testWidgets('FutureWidget renders correctly', (WidgetTester tester) async {
      final FutureWidget<String> futureWidget = FutureWidget<String>(
        future: Future.value('data'),
        loading: (context, snapshot) => const CircularProgressIndicator(),
        error: (context, error) => Text('Error: $error'),
        data: (context, data) => Text(data),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: futureWidget)));

      // Verify that FutureWidget renders correctly
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Error:'), findsNothing);
      expect(find.text('data'), findsNothing);

      await tester.pump(); // Rebuild widget after future completes

      // Verify that FutureWidget shows data after future completes
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Error:'), findsNothing);
      expect(find.text('data'), findsOneWidget);
    });
  });

  group('FutureWidget tests', () {
    testWidgets('FutureWidget renders error state correctly',
        (WidgetTester tester) async {
      final FutureWidget<String> futureWidget = FutureWidget<String>(
        future: Future.delayed(
            const Duration(seconds: 1), () => throw 'Error loading data'),
        loading: (context, snapshot) => const CircularProgressIndicator(),
        error: (context, error) => Text('Error: $error'),
        data: (context, data) => Text(data),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: futureWidget)));

      // Verify that FutureWidget renders loading state correctly
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Error:'), findsNothing);
      expect(find.text('data'), findsNothing);

      await tester
          .pump(const Duration(seconds: 1)); // Wait for future to complete

      // Verify that FutureWidget renders error state correctly
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Error: Error loading data'), findsOneWidget);
      expect(find.text('data'), findsNothing);
    });
  });
}
