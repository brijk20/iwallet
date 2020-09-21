import 'package:flutter/material.dart';
import 'package:iwallet/helper/helper.dart';
import '../models/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionList extends StatelessWidget {
  final DBHelper db = DBHelper.instance;
  final List<Transactions> transactions;

//Prints individual Transaction as ListView in a Card
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      child: FutureBuilder<List>(
          future: db.getAllRecords('TNX'),
          initialData: List(),
          builder: (context, transactions) {
            //Return the Updated List from Database
            return transactions.hasData
                ? ListView.builder(
                    itemCount: transactions.data.length,
                    itemBuilder: (ctx, index) {
            // return Card(
            //         child: ListTile(
            //           title: Text(
            //               "Employee Name: " + snapshot.data[index].row[1]),  //.row[0] = id, .row[1] = name, .row[2] = Category, .row[3] = amount
            //         ),
            //       );


                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 3.0, horizontal: 3),
                        elevation: 1,

                        //Card Color
                        color: CupertinoColors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            //Avatar's color
                            foregroundColor: CupertinoColors.label,
                            radius: 22,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FittedBox(
                                child: IconButton(
                                  icon: Icon(Icons.person),
                                  iconSize: 45,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),

                          //NAME
                          title: Text(
                            transactions.data[index].row[1].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),

                          //ID 
                          subtitle: Text(
                            'id: ${transactions.data[index].row[0]}',  //id
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),

                          //AMOUNT
                          trailing: Text(
                            '₹ ${transactions.data[index].row[3]}', //amount
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: transactions.data[index].row[2] == "Expense"
                                  ? Colors.red
                                  : Colors.lightGreen,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
