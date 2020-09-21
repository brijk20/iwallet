import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwallet/helper/helper.dart';
import 'package:iwallet/models/transaction.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     int ids = 10;
    _insertData(int id, String name, String category, double amount) async {
      Transactions transaction = Transactions(id, name, category, amount);
      DBHelper helper = DBHelper.instance;
      int insertId = await helper.insert(transaction);
      print("inserted row $insertId");
      ids +=1;
    }

    //Opening BottomSheet
    void _startAddTransaction(BuildContext ctx, bool i) {
      showModalBottomSheet(
        barrierColor: Colors.black87,
        backgroundColor: i == false ? Colors.red : Colors.lightGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        elevation: 5,
        isScrollControlled: true,
        context: ctx,
        builder: (BuildContext bCtx) {
          if (i == false) {
            return Container(
              margin: EdgeInsets.only(top: 40, left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Text("Expense"),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 40, left: 5, right: 5),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Text("Income"),
          );
        },
      );
    }

    return Row(
      children: <Widget>[
        //Add Expense Button
        Expanded(
          flex: 50,
          child: Container(
            height: 70,
            child: RaisedButton(
              elevation: 10.0,
              padding: EdgeInsets.all(20.0),
              color: Colors.red,
              onPressed: () {
                _insertData(ids, "Demo New", "Expense",1000.00);
                ids = ids+1;
                // _startAddTransaction(context, false);
              },
              child: Text(
                "Add Expense",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Text(''),
        ),

        //Add Income Button
        Expanded(
          flex: 50,
          child: Container(
            height: 70,
            child: RaisedButton(
              elevation: 10.0,
              padding: EdgeInsets.all(20.0),
              color: Colors.lightGreen,
              onPressed: () {
                _startAddTransaction(context, true);
              },
              child: Text(
                "Add Income",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// onPressed: (){DBHelper.insert('transactions', {
//    'id': '003',
//    'type': 'expense',
//    'category': 'allowances',
//    'amount' : 2000.00,
//    'notes' : '#Test'
//     });
//     print("...");

//     },
