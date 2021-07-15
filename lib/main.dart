import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/adaptive_chart.dart';
import 'package:personal_expenses_app/widgets/adaptive_transaction_list.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/show_chart_switch.dart';

import 'helpers/constants.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
  /**
   * A way to lock landscape mode:
   * SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.orange[100],
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: ThemeData.light().textTheme.button!.copyWith(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions =>
      _userTransactions.where((element) => element.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('yeah!' + state.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Personal Expenses App"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text("Personal Expenses App"),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );

    Widget _buildAdaptiveTransactionList(transactionListHeight) {
      return AdaptiveTransactionList(
        screenHeight: mediaQuery.size.height,
        appBarHeight: appBar.preferredSize.height,
        statusBarHeight: mediaQuery.padding.top,
        transactionListHeight: transactionListHeight,
        userTransactions: _userTransactions,
        deleteTransactionCallback: _deleteTransaction,
      );
    }

    Widget _buildAdaptiveChart(chartHeightLandscape) {
      return AdaptiveChart(
        screenHeight: mediaQuery.size.height,
        appBarHeight: appBar.preferredSize.height,
        statusBarHeight: mediaQuery.padding.top,
        chartHeight: chartHeightLandscape,
        recentTransactions: _recentTransactions,
      );
    }

    List<Widget> _buildLandscapeContent() {
      return [
        ShowChartSwitch(
          onChangeCallback: (val) => setState(() => _showChart = val),
          switchValue: _showChart,
        ),
        _showChart
            ? _buildAdaptiveChart(Constants.chartHeightLandscape)
            : _buildAdaptiveTransactionList(Constants.transactionListHeightLandscape),
      ];
    }

    List<Widget> _buildPortraitContent() {
      return [
        _buildAdaptiveChart(Constants.chartHeightPortrait),
        _buildAdaptiveTransactionList(Constants.transactionListHeightPortrait),
      ];
    }

    final Widget pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) ..._buildLandscapeContent() else ..._buildPortraitContent(),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
