// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  //! Restricting the Device Orientation

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp
  // ]);
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
                  titleMedium: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
          ),
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
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
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 4323.22, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Groceries',
    //     amount: 623.22,
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Mariyam', amount: 623.22, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((eachTx) {
      return eachTx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
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

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
}

  @override
  Widget build(BuildContext context) {
    final bool renderLeft = Platform.isIOS;
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    // PLATFORM DEPENDENCY
    final PreferredSizeWidget appBar = renderLeft ? CupertinoNavigationBar(
      middle: Text('Expense Manager'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    ) as PreferredSizeWidget : AppBar(
      title: Text('Expense Manager'),
      actions: <Widget>[
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add)
        )
      ],
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height -  mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
    );
    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch.adaptive(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                }),
              ],
            ),
            if(!isLandscape) Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top ) * 0.3,
                child: Chart(_recentTransaction)
            ),
            if(!isLandscape) txListWidget,
            if(isLandscape) _showChart ? Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top ) * 0.7,
                child: Chart(_recentTransaction)
            ): txListWidget
          ],
        ),
      ),
    );
    // PLATFORM DEPENDENCY
    return renderLeft ? CupertinoPageScaffold(
        child: appBody,
        navigationBar: appBar as ObstructingPreferredSizeWidget,
      ) : Scaffold(
      appBar: appBar,
      body: appBody,
      // PLATFORM DEPENDENCY
      floatingActionButton: renderLeft ? Container() : FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
