import 'package:code_test/core/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoanTextField extends StatefulWidget {
  final String placeholder;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final String Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String) onChanged;

  const LoanTextField(
    this.placeholder,
    this.textEditingController,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType,
    this.validator,
    this.inputFormatters,
    this.onChanged, {
    Key key,
  }) : super(key: key);

  @override
  _LoanTextFieldState createState() => _LoanTextFieldState();
}

class _LoanTextFieldState extends State<LoanTextField> {
  bool _shouldValidate = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidate: true,
      inputFormatters: widget.inputFormatters ?? [],
      validator: (text) => _shouldValidate ? widget.validator(widget.textEditingController.text) : null,
      controller: widget.textEditingController,
      keyboardType: widget.textInputType,
      focusNode: widget.focusNode,
      textInputAction: (widget.nextFocusNode != null) ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (term) {
        widget.focusNode.unfocus();
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      onChanged: (string) {
        _shouldValidate = true;
        widget.onChanged(string);
      },
      decoration: _getDecoration(),
    );
  }

  InputDecoration _getDecoration() {
    return InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius12)),
        ),
        labelText: widget.placeholder);
  }
}
