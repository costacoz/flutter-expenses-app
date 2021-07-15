import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransactionCallback,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionCallback;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  late Color _bgColor;

  @override
  void initState() {
    const List<Color> availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];

    _bgColor = availableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text("\$${widget.transaction.amount.toStringAsFixed(2)}"),
            ),
          ),
        ),
        title: Text(widget.transaction.title, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat.yMMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width >= 420
            ? TextButton.icon(
                onPressed: () => widget.deleteTransactionCallback(widget.transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.deleteTransactionCallback(widget.transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
