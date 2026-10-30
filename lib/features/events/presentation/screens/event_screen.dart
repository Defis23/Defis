
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/registration_repository.dart';
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
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => _RegistrationFormSheet(
                          eventId: event.id,
                          eventName: event.name,
                          parentContext: context,
                        ),
                      );
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
}

class _RegistrationFormSheet extends StatefulWidget {
  final String eventId;
  final String eventName;
  final BuildContext parentContext;

  const _RegistrationFormSheet({
    required this.eventId,
    required this.eventName,
    required this.parentContext,
  });

  @override
  State<_RegistrationFormSheet> createState() =>
      _RegistrationFormSheetState();
}

class _RegistrationFormSheetState
    extends State<_RegistrationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _repository = RegistrationRepository();

  bool _isSubmitting = false;
  String? _submitError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting ||
        !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submitError = null;
    });

    try {
      await _repository.register(
        eventId: widget.eventId,
        eventName: widget.eventName,
        name: _nameController.text,
        email: _emailController.text,
      );

      if (!mounted) return;

      Navigator.of(context).pop();

      if (widget.parentContext.mounted) {
        ScaffoldMessenger.of(widget.parentContext)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Pendaftaran berhasil disimpan.',
              ),
            ),
          );
      }
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _submitError =
            'Pendaftaran gagal disimpan. '
            'Periksa koneksi atau izin Firebase, '
            'lalu coba lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar ${widget.eventName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                enabled: !_isSubmitting,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: RegistrationValidator.validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                enabled: !_isSubmitting,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: RegistrationValidator.validateEmail,
              ),
              if (_submitError != null) ...[
                const SizedBox(height: 12),
                Text(
                  _submitError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
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
  }
}
