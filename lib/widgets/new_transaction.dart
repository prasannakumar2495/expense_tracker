import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

/**This will close the bottomSheet, once data is entered in all the fields and clicked on Done button. */
    Navigator.of(context).pop();
  }

  void _persentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            controller: _titleController,
            // onChanged: (value) {
            //   _titleInput = value;
            // },
            decoration: const InputDecoration(labelText: "Title"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _amountController,
            // onChanged: (value) {
            //   _amountInput = value;
            // },
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onSubmitted: (_) => _submitData(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    _selectedDate == null
                        ? "No Date Choosen!"
                        : "Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}",
                  ),
                ),
                Builder(builder: (context) {
                  return TextButton(
                    onPressed: () => _persentDatePicker(context),
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text("Add Transaction"),
          )
        ]),
      ),
    );
  }
}
