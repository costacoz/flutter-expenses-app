import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: [
          Text(
            "No transactions added yet!",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          Container(
            height: constrains.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          )
        ],
      );
    });
  }
}