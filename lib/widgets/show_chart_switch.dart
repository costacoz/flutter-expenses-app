import 'package:flutter/material.dart';

class ShowChartSwitch extends StatelessWidget {
  final bool switchValue;
  final Function onChangeCallback;

  ShowChartSwitch({
    required this.switchValue,
    required this.onChangeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart", style: TextStyle(fontSize: Theme.of(context).textTheme.headline6!.fontSize)),
        Switch.adaptive(
            value: switchValue,
            onChanged: (val) => onChangeCallback(val)
        )
      ],
    );
  }
}
