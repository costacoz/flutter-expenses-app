import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class AdaptiveChart extends StatelessWidget {
  final double screenHeight;
  final double appBarHeight;
  final double statusBarHeight;
  final double chartHeight;
  final List<Transaction> recentTransactions;

  AdaptiveChart({
    required this.screenHeight,
    required this.appBarHeight,
    required this.statusBarHeight,
    required this.chartHeight,
    required this.recentTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (screenHeight - appBarHeight - statusBarHeight) * chartHeight,
      child: Chart(recentTransactions),
    );
  }
}
