import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:iwallet/helper/helper.dart';
import './widgets/bottom_bar.dart';
import './widgets/transaction_list.dart';
import './widgets/top_bar.dart';
import './models/transaction.dart';
import 'models/transaction.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iWallet',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//This method shows the Input Area for Adding Transaction
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Model Bottom Sheet Code

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      barrierColor: Colors.black87,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      elevation: 5,
      isScrollControlled: true,
      context: ctx,
      builder: (BuildContext bCtx) {
        //Container for Demo Sheet
        return Container(
          margin: EdgeInsets.only(top: 40, left: 5, right: 5),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: <Widget>[
              Container(
                width: 29,
                height: 20,
                child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Id",
                  ),
                  onSubmitted: (idss){
                    print('$idss');
                  },
                ),
              ),
              FloatingActionButton(
                child: Text("Done"),
                onPressed: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Expense",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _save(1, "demo1", "Income", 100.00);
                      // _addNewTransaction(tnxE);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Income",
                      style: TextStyle(color: Colors.lightGreen, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _addNewTransaction(tnx);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Methods for Saving AND Retriving data from database

  _save(int id, String name, String category, double amount) async {
    Transactions transaction = Transactions(id, name, category, amount);

    DBHelper helper = DBHelper.instance;
    id = await helper.insert(transaction);
    print('inserted row: $id');
  }

  _truncate(String tName) async {
    DBHelper helper = DBHelper.instance;
    await helper.truncateTable(tName);
  }

  _read() async {
    DBHelper helper = DBHelper.instance;
    int rowId = 1;
    Transactions transaction = await helper.queryTransaction(rowId);

    if (transaction == null) {
      print("read row $rowId: empty");
    } else {
      print('read row $rowId: ${transaction.name} ${transaction.amount} ');
    }
  }

  _readAll(String tName) async {
    DBHelper helper = DBHelper.instance;
    var table = await helper.getAllRecords(tName);
    print('$tName');
    print('$table');
  }

//_userTransaction Method:
  Transactions tnx = Transactions(12, "Add_Demo", 'Income', 100.00);

  List<Transactions> _userTransaction = [
    Transactions(
      1,
      "Demo 1",
      "Income",
      129.00,
    ),
    Transactions(
      2,
      "Demo 2",
      "Expense",
      100.892,
    ),
  ];

  void _addNewTransaction(Transactions transaction) {
    final newTx = transaction;
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                print("..Truncating Table..");
                _truncate('TNX');
              }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("...");
                _readAll("TNX");
                // _userTransaction.forEach((x) => print('${x.amount}'));
                print("...");
                // usrMap.forEach((k,v) => print('${k}: ${v}'));
              },
            ),
          ],
          backgroundColor: Colors.grey,
          elevation: 10,
          title: Text(
            'Personal',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: <Widget>[
              TopBar(_userTransaction),
              TransactionList(_userTransaction),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                ),
              ),
              BottomBar(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _startAddTransaction(context);
          },
          child: Text("//"),
        ),
      ),
    );
  }
}
