import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'New Shoes', amount: 4323.22, date: DateTime.now()),
    Transaction(id: 't2', title: 'Weekly Groceries', amount: 623.22, date: DateTime.now()),
    Transaction(id: 't3', title: 'Mariyam', amount: 623.22, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
