import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yron_ui/yron_ui.dart';

void main() {
  testWidgets('renders its icon and triggers the callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: YronActionButton(
            icon: Icons.add,
            tooltip: 'Increment',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
