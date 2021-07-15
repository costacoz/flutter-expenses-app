import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

class AdaptiveTransactionList extends StatelessWidget {
  final double screenHeight;
  final double appBarHeight;
  final double statusBarHeight;
  final double transactionListHeight;

  final userTransactions;
  final deleteTransactionCallback;

  AdaptiveTransactionList({
    required this.screenHeight,
    required this.appBarHeight,
    required this.statusBarHeight,
    required this.transactionListHeight,
    required this.userTransactions,
    required this.deleteTransactionCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (screenHeight - appBarHeight - statusBarHeight) * transactionListHeight,
      child: TransactionList(userTransactions, deleteTransactionCallback),
    );
  }
}
