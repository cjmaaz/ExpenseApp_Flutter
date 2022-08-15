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
        child: transactions.isEmpty ? Column(
          children: <Widget>[
            Text('No transaction added yet!', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 30,),
            Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
            )
          ],
        ) : ListView.builder(
          itemBuilder: (ctx, idx) {
            return Card(
              //elevation: 5,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    child: Text(
                      '\$${transactions[idx].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transactions[idx].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat.yMMMMd().format(transactions[idx].date),
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: transactions.length,
        ));
  }
}
