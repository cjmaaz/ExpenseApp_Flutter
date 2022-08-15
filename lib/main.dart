import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Open Sans', fontSize: 20, fontWeight: FontWeight.bold,)
          )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New Shoes', amount: 4323.22, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Weekly Groceries', amount: 623.22, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Mariyam', amount: 623.22, date: DateTime.now()),
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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        // return GestureDetector(
        //   onTap: () {},
        //   child: NewTransaction(_addNewTransaction),
        //   behavior: HitTestBehavior.opaque,
        // );
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(onPressed: () => _startAddNewTransaction(context), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 5,
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                child: Text('CHART!'),
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
