import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:robspace_mobile/features/events/domain/event.dart';
import 'package:robspace_mobile/features/events/presentation/widgets/event_state_view.dart';

void main() {
  Widget createTestWidget({
    required bool isLoading,
    required List<Event>? events,
    required Object? error,
    VoidCallback? onRetry,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: EventStateView(
          isLoading: isLoading,
          events: events,
          error: error,
          onRetry: onRetry,
          itemBuilder: (event) {
            return Text(event.name);
          },
        ),
      ),
    );
  }

  testWidgets('menampilkan initial loading state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        isLoading: true,
        events: null,
        error: null,
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('menampilkan data berhasil dimuat', (tester) async {
    const events = [
      Event(
        id: '1',
        name: 'ROBBER',
        location: 'PATS BSD',
        date: '05 October 2026',
        description: 'Nightlife event ROBSPACE.',
      ),
    ];

    await tester.pumpWidget(
      createTestWidget(
        isLoading: false,
        events: events,
        error: null,
      ),
    );

    expect(find.text('ROBBER'), findsOneWidget);
  });

  testWidgets('menampilkan empty state', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        isLoading: false,
        events: const [],
        error: null,
      ),
    );

    expect(find.text('Belum ada event.'), findsOneWidget);
  });

  testWidgets('menampilkan error state dan tombol retry', (tester) async {
    var retryPressed = false;

    await tester.pumpWidget(
      createTestWidget(
        isLoading: false,
        events: null,
        error: Exception('Gagal memuat data'),
        onRetry: () {
          retryPressed = true;
        },
      ),
    );

    expect(find.text('Gagal memuat event.'), findsOneWidget);
    expect(find.text('Silakan coba lagi.'), findsOneWidget);
    expect(find.text('Coba Lagi'), findsOneWidget);

    await tester.tap(find.text('Coba Lagi'));

    expect(retryPressed, isTrue);
  });
}