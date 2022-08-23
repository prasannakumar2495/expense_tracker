import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;

  const TransactionList(
      {Key? key,
      required this.userTransaction,
      required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "No transactions added yet!",
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }),
          )
        : ListView.builder(
            itemCount: userTransaction.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: FittedBox(
                          child: Text("\$${userTransaction[index].amount}")),
                    ),
                  ),
                  title: Text(
                    userTransaction[index].title,
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransaction[index].dateTime),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () => deleteTransaction(
                            userTransaction[index].id,
                          ),
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                        )
                      : IconButton(
                          onPressed: () => deleteTransaction(
                            userTransaction[index].id,
                          ),
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              );
            },
          );
  }
}
