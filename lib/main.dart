// ignore_for_file: avoid_print

import 'dart:io';

import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expense App",
      theme: ThemeData(
        errorColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late String _titleInput;
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      dateTime: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Personal Expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  return GestureDetector(
                    child: const Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context),
                  );
                })
              ],
            ),
          )
        : AppBar(
            title: const Text("Personal Expense App"),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: const Icon(Icons.add),
                );
              }),
            ],
          ) as PreferredSizeWidget;

    final pageBody = SafeArea(
      child: Column(
        children: <Widget>[
          if (mediaQuery.orientation == Orientation.landscape)
            SizedBox(
              height: ((mediaQuery.size.height) -
                      (appBar.preferredSize.height) -
                      (mediaQuery.padding.top)) *
                  0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          if (mediaQuery.orientation == Orientation.landscape)
            _showChart
                ? SizedBox(
                    height: ((mediaQuery.size.height) -
                            (appBar.preferredSize.height) -
                            (mediaQuery.padding.top)) *
                        0.7,
                    width: double.infinity,
                    child: Chart(recentTransactions: _recentTransactions),
                  )
                : SizedBox(
                    height: ((mediaQuery.size.height) -
                            (appBar.preferredSize.height) -
                            (mediaQuery.padding.top)) *
                        0.7,
                    child: TransactionList(
                      userTransaction: _userTransaction,
                      deleteTransaction: _deleteTransaction,
                    ),
                  ),
          if (!(MediaQuery.of(context).orientation == Orientation.landscape))
            SizedBox(
              height: ((mediaQuery.size.height) -
                      (appBar.preferredSize.height) -
                      (mediaQuery.padding.top)) *
                  0.3,
              width: double.infinity,
              child: Chart(recentTransactions: _recentTransactions),
            ),
          if (!(MediaQuery.of(context).orientation == Orientation.landscape))
            SizedBox(
              height: ((mediaQuery.size.height) -
                      (appBar.preferredSize.height) -
                      (mediaQuery.padding.top)) *
                  0.6,
              child: TransactionList(
                userTransaction: _userTransaction,
                deleteTransaction: _deleteTransaction,
              ),
            ),
        ],
      ),
    );

    return Builder(builder: (context) {
      /**
         * We have surrounded the IconButton with Builder, to get the perfect "context".
         * So, that we can pass it to the BottomSheet.
         * If not, BottomSheet is not being displayed.
         */
      return Platform.isIOS
          ? CupertinoPageScaffold(
              resizeToAvoidBottomInset: true,
              navigationBar: appBar as ObstructingPreferredSizeWidget,
              child: pageBody,
            )
          : Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: appBar,
              body: pageBody,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Platform.isIOS
                  ? const SizedBox()
                  : FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () => _startAddNewTransaction(context),
                    ),
            );
    });
  }
}
