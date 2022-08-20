import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(
    this.addNewTransaction, {
    Key? key,
  }) : super(key: key);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addNewTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: double.infinity,
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
