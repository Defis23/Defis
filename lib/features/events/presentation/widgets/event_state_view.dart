import 'package:flutter/material.dart';

import '../../domain/event.dart';

class EventStateView extends StatelessWidget {
  final bool isLoading;
  final List<Event>? events;
  final Object? error;
  final VoidCallback? onRetry;
  final Widget Function(Event event) itemBuilder;

  const EventStateView({
    super.key,
    required this.isLoading,
    required this.events,
    required this.error,
    required this.onRetry,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),
            const SizedBox(height: 12),
            const Text(
              'Gagal memuat event.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan coba lagi.',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (events == null || events!.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 48,
            ),
            SizedBox(height: 12),
            Text(
              'Belum ada event.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events!.length,
      itemBuilder: (context, index) {
        return itemBuilder(events![index]);
      },
    );
  }
}