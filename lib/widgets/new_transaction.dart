import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransactionCallback;

  NewTransaction(this.addNewTransactionCallback);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  static const int dummyUnsetDate = 1970;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime(dummyUnsetDate);

  void _addTransaction() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate.year == dummyUnsetDate) {
      return;
    }

    widget.addNewTransactionCallback(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _addTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate.year == dummyUnsetDate
                        ? 'No date chosen...'
                        : "Picked date: ${DateFormat.yMd().format(_selectedDate)}"),
                  ),
                  AdaptiveTextButton(
                      text: 'Choose Date',
                      onPressedCallback: _showDatePicker,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
            ElevatedButton(
              child: Text("Add Transaction"),
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor, onPrimary: Theme.of(context).textTheme.button!.color),
            )
          ],
        ),
      ),
    );
  }
}
