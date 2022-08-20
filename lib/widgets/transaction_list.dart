import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 620,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text('No transaction added yet!',
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('\$${transactions[idx].amount}'),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[idx].title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                            DateFormat.yMMMd().format(transactions[idx].date)),
                      ));
                },
                itemCount: transactions.length,
              ));
  }
}
