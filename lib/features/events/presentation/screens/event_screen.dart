
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/registration_validator.dart';
import '../providers/event_provider.dart';
import '../widgets/event_state_view.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event ROBSPACE'),
      ),
      body: EventStateView(
        isLoading: eventState.isLoading,
        events: eventState.value,
        error: eventState.error,
        onRetry: () {
          ref.read(eventProvider.notifier).retry();
        },
        itemBuilder: (event) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Lokasi: ${event.location}'),
                  Text('Tanggal: ${event.date}'),
                  const SizedBox(height: 8),
                  Text(event.description),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showRegistrationForm(context, event.name);
                    },
                    child: const Text('Daftar Event'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRegistrationForm(
    BuildContext context,
    String eventName,
  ) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        bool isSubmitting = false;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar $eventName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        enabled: !isSubmitting,
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                        validator: RegistrationValidator.validateName,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: emailController,
                        enabled: !isSubmitting,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: RegistrationValidator.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isSubmitting
                              ? null
                              : () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  setModalState(() {
                                    isSubmitting = true;
                                  });

                                  try {
                                    // Simulasi proses pendaftaran.
                                    await Future<void>.delayed(
                                      const Duration(seconds: 2),
                                    );

                                    if (!sheetContext.mounted) {
                                      return;
                                    }

                                    Navigator.pop(sheetContext);

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Pendaftaran berhasil.',
                                          ),
                                        ),
                                      );
                                  } finally {
                                    nameController.dispose();
                                    emailController.dispose();
                                  }
                                },
                          child: isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Submit Pendaftaran'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      emailController.dispose();
    });
  }
}
