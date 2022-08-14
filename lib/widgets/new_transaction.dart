import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double) addNew;

  NewTransaction(this.addNew);

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
    widget.addNew(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) {
              //   amountInput = val;
              // },
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: () {
                // print(titleInput);
                // print(amountInput);
                print(titleController.text);
                print(amountController.text);
                submitData();
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
