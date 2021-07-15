import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double daySpendings = 0.0;
      recentTransactions.forEach((transaction) {
        if (DateFormat.yMMMMEEEEd().format(weekDay) == DateFormat.yMMMMEEEEd().format(transaction.date)) {
          daySpendings += transaction.amount;
        }
      });
      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': daySpendings};
    }).reversed.toList();
  }

  double get totalSpending => groupedTransactionValues.fold(0.0, (sum, element) => sum + element['amount']);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending > 0 ? data['amount'] / totalSpending : 0.0,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
