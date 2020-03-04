import 'package:code_test/core/number_input_formatter.dart';
import 'package:code_test/core/validator_utility.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

enum LoanFields {
  FirstName,
  LastName,
  Email,
  LoanAmount,
}

class LoanItem {
  final String placeholder;
  final TextEditingController editingController;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final String Function(String) validator;
  final void Function(String) onChanged;

  LoanItem(
    this.placeholder,
    this.editingController,
    this.focusNode,
    this.textInputType,
    this.validator, {
    this.nextFocusNode,
    this.inputFormatters,
    this.onChanged,
  });
}

@injectable
class LoanFormStore {
  static const double kLoanMinAmount = 10000;
  static const double kLoanMaxAmount = 500000;
  static const int kNameMaxLength = 50;

  List<LoanItem> _loanItems;

  List<LoanItem> get loanItems => _loanItems;

  void loadItem(void Function(String) onChanged) {
    final ValidatorUtility validator = ValidatorUtility();

    final loanAmountItem = LoanItem(
      'Loan Amount',
      TextEditingController(),
      FocusNode(),
      TextInputType.number,
      (value) => validator.validateNumber(value, 'Loan Amount', kLoanMinAmount, kLoanMaxAmount),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        NumberInputFormatter(6),
      ],
      onChanged: onChanged,
    );

    final emailItem = LoanItem(
      'Email',
      TextEditingController(),
      FocusNode(),
      TextInputType.emailAddress,
      (value) => validator.validateEmail(value, 'Email'),
      nextFocusNode: loanAmountItem.focusNode,
      onChanged: onChanged,
    );

    final lastNameItem = LoanItem(
      'Last Name',
      TextEditingController(),
      FocusNode(),
      TextInputType.text,
      (value) => validator.validateString(value, 'Last Name', kNameMaxLength),
      nextFocusNode: emailItem.focusNode,
      onChanged: onChanged,
    );

    final firstNameItem = LoanItem(
      'First Name',
      TextEditingController(),
      FocusNode(),
      TextInputType.text,
      (value) => validator.validateString(value, 'First Name', kNameMaxLength),
      nextFocusNode: lastNameItem.focusNode,
      onChanged: onChanged,
    );

    _loanItems = [firstNameItem, lastNameItem, emailItem, loanAmountItem];
  }

  void reset() {
    for (final loanItem in _loanItems) {
      loanItem.editingController.text = '';
    }
  }

  Application getApplicationFromForm() {
    final String firstName = _loanItems[LoanFields.FirstName.index].editingController.text;
    final String lastName = _loanItems[LoanFields.LastName.index].editingController.text;
    final String email = _loanItems[LoanFields.Email.index].editingController.text;
    final String loanAmount = _loanItems[LoanFields.LoanAmount.index]
        .editingController
        .text
        .replaceAll(ValidatorUtility.kNumberRegValue, '')
        .replaceAll(' ', '')
        .replaceAll(',', '');
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || loanAmount.isEmpty) {
      return null;
    }
    final double loanAmountValue = double.parse(loanAmount);
    return Application(firstName: firstName, lastName: lastName, email: email, loanAmount: loanAmountValue);
  }

  bool isFormValidated() {
    final Application application = getApplicationFromForm();
    if (application == null) {
      return false;
    }

    return application.firstName.isNotEmpty &&
        application.firstName.length <= kNameMaxLength &&
        application.lastName.isNotEmpty &&
        application.lastName.length <= kNameMaxLength &&
        ValidatorUtility.kEmailRegExp.hasMatch(application.email) &&
        application.loanAmount >= kLoanMinAmount &&
        application.loanAmount <= kLoanMaxAmount;
  }
}
