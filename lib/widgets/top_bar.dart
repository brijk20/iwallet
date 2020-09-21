import 'package:flutter/material.dart';
import 'package:iwallet/models/transaction.dart';

class TopBar extends StatelessWidget {
  final List<Transactions> transaction;
  TopBar(this.transaction);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    double tExp = 0;
    double tInc = 0;

                                    // _userTransaction.forEach((x) => print('${x.amount}'));
    transaction.forEach((element) {
      tExp = element.category == "Expense" ? (tExp + element.amount) : tExp + 0;
      tInc = element.category == "Income" ? (tInc + element.amount) : tInc + 0;
    });

    double tTot = tInc - tExp;

    return Container(
      height: 70.0,
      width: deviceWidth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.red,
            width: deviceWidth / 2,
            height: 70.0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Expense\n ${tExp.roundToDouble()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Container(
            width: deviceWidth / 2,
            height: 70.0,
            color: Colors.lightGreen,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Income\n ${tInc.roundToDouble()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Container(
            width: deviceWidth,
            color: Colors.blueAccent[700],
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Ballance\n${tTot.roundToDouble()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
