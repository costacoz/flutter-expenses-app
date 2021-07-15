import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressedCallback;
  final TextStyle style;

  AdaptiveTextButton({required this.text, required this.onPressedCallback, required this.style});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: style,
            ),
            onPressed: onPressedCallback,
          )
        : TextButton(
            onPressed: onPressedCallback,
            child: Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
