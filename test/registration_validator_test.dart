
import 'package:flutter_test/flutter_test.dart';
import 'package:robspace_mobile/features/events/domain/registration_validator.dart';

void main() {
  group('RegistrationValidator - Nama', () {
    test('menolak nama kosong', () {
      expect(
        RegistrationValidator.validateName(''),
        'Nama wajib diisi.',
      );
    });

    test('menolak nama yang hanya berisi spasi', () {
      expect(
        RegistrationValidator.validateName('   '),
        'Nama wajib diisi.',
      );
    });

    test('menerima nama valid', () {
      expect(
        RegistrationValidator.validateName('Defis'),
        isNull,
      );
    });
  });

  group('RegistrationValidator - Email', () {
    test('menolak email kosong', () {
      expect(
        RegistrationValidator.validateEmail(''),
        'Email wajib diisi.',
      );
    });

    test('menolak email tanpa tanda @', () {
      expect(
        RegistrationValidator.validateEmail('defis.example.com'),
        'Format email tidak valid.',
      );
    });

    test('menolak email tanpa domain lengkap', () {
      expect(
        RegistrationValidator.validateEmail('defis@'),
        'Format email tidak valid.',
      );
    });

    test('menerima email valid', () {
      expect(
        RegistrationValidator.validateEmail('defis@example.com'),
        isNull,
      );
    });
  });
}
