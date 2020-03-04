import 'package:code_test/core/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMessage extends StatelessWidget {
  final dynamic error;
  final void Function() action;

  const ErrorMessage(this.error, this.action, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMargin20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(error.toString()),
          const SizedBox(height: kMargin8),
          RaisedButton(
            color: Theme.of(context).errorColor,
            onPressed: action,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
