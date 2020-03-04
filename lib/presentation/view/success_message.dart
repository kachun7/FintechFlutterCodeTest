import 'package:code_test/core/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuccessMessage extends StatelessWidget {
  final dynamic error;
  final void Function() action;

  const SuccessMessage(this.error, this.action, {Key key}) : super(key: key);

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
            color: Theme.of(context).accentColor,
            onPressed: action,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
