import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(
    this.addNewTransaction, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
          ),
          TextField(
            controller: amountController,
            // onChanged: (value) {
            //   _amountInput = value;
            // },
            decoration: const InputDecoration(labelText: "Amount"),
          ),
          TextButton(
            onPressed: () {
              addNewTransaction(
                  titleController.text, double.parse(amountController.text));
            },
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
