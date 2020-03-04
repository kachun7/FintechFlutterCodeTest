import 'package:code_test/core/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        color: Theme.of(context).indicatorColor,
        size: kLoadingHeight,
      ),
    );
  }
}
