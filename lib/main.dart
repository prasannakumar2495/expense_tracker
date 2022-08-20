// ignore_for_file: avoid_print

import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late String _titleInput;
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 69.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Groceries",
    //   amount: 9.99,
    //   dateTime: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      dateTime: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expense App",
      theme: ThemeData(
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
              ))
              .headline6,
        ),
      ),
      home: Builder(builder: (context) {
        /**
         * We have surrounded the Scaffold with Builder, to get the perfect "context".
         * So, that we can pass it to the BottomSheet.
         * If not, BottomSheet is not being displayed.
         */
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            /**This is the name displayed, in the AppBar when the application is open. */
            title: const Text("Personal Expense App"),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: Chart(recentTransactions: _recentTransactions),
              ),
              TransactionList(userTransaction: _userTransaction),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        );
      }),
    );
  }
}
