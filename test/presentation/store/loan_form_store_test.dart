import 'package:code_test/domain/models/application.dart';
import 'package:code_test/presentation/store/loan_forrm_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  group('Form', () {
    final LoanFormStore store = LoanFormStore();

    test('Get should return null', () {
      // Prepare
      store.loadItem((_) {});

      // Test
      final resp = store.getApplicationFromForm();

      // Assert
      expect(resp, null);
    });

    test('Get should return a valid application', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.getApplicationFromForm();

      // Assert
      expect(resp, const TypeMatcher<Application>());
    });
  });

  group('Validation', () {
    final LoanFormStore store = LoanFormStore();

    test('Empty values should return false', () {
      // Prepare
      store.loadItem((_) {});

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('A valid application should return true', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, true);
    });
  });
  group('First Name Validation', () {
    final LoanFormStore store = LoanFormStore();
    test('Empty First Name should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = '';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('First Name with 50 characters should return true', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'KalleKalleKalleKalleKalleKalleKalleKalleKalleKalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, true);
    });

    test('First Name with 51 characters should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'KalleKalleKalleKalleKalleKalleKalleKalleKalleKalleK';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });
  });
  group('Last Name Validation', () {
    final LoanFormStore store = LoanFormStore();
    test('Empty Last Name should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = '';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('Last Name with 50 characters should return true', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'SvenssonSvenssonSvenssonSvenssonSvenssonSvenssonSv';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, true);
    });

    test('Last Name with 51 characters should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'SvenssonSvenssonSvenssonSvenssonSvenssonSvenssonSve';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });
  });
  group('Email Validation', () {
    final LoanFormStore store = LoanFormStore();
    test('Empty email should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = '';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('Email with invalid format should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle.se';
      store.loanItems[3].editingController.text = '10000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });
  });
  group('Loan Amount Validation', () {
    final LoanFormStore store = LoanFormStore();
    test('Empty Loan Amount should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('Too low Loan Amount should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '9999';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });

    test('Too high Loan Amount should return false', () {
      // Prepare
      store.loadItem((_) {});

      store.loanItems[0].editingController.text = 'Kalle';
      store.loanItems[1].editingController.text = 'Svensson';
      store.loanItems[2].editingController.text = 'kalle@svensson.se';
      store.loanItems[3].editingController.text = '510000';

      // Test
      final resp = store.isFormValidated();

      // Assert
      expect(resp, false);
    });
  });
}
