import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((eachTransaction) {
        return Card(
          //elevation: 5,
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Text(
                  '\$${eachTransaction.amount.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    eachTransaction.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(eachTransaction.date),
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
