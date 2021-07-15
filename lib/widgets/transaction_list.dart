import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/empty_transactions.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionCallback;

  TransactionList(this.transactions, this.deleteTransactionCallback);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? EmptyTransactions()
        : ListView.builder(
            itemBuilder: (ctx, idx) {
              return TransactionItem(
                key: ValueKey(transactions[idx].id),
                transaction: transactions[idx],
                deleteTransactionCallback: deleteTransactionCallback,
              );
            },
            itemCount: transactions.length,
          );
  }
}
