import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final void Function(String, double) addNew;

  NewTransaction(this.addNew);

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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) {
              //   amountInput = val;
              // },
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                // print(titleInput);
                // print(amountInput);
                print(titleController.text);
                print(amountController.text);
                addNew(titleController.text, double.parse(amountController.text));
              },
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
