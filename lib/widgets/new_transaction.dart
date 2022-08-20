import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  const NewTransaction(
    this.addNewTransaction, {
    Key? key,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addNewTransaction(
      titleController.text,
      double.parse(amountController.text),
    );

/**This will close the bottomSheet, once data is entered in all the fields and clicked on Done button. */
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            controller: titleController,
            // onChanged: (value) {
            //   _titleInput = value;
            // },
            decoration: const InputDecoration(labelText: "Title"),
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            controller: amountController,
            // onChanged: (value) {
            //   _amountInput = value;
            // },
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: submitData,
            child: const Text(
              "Add transaction",
              style: TextStyle(color: Colors.purple),
            ),
          )
        ]),
      ),
    );
  }
}
