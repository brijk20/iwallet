// import 'package:flutter/material.dart';
// import 'package:iwallet/helper/helper.dart';
// import '../models/transaction.dart';
// import '../widgets/new_transaction.dart';
// import '../widgets/transaction_list.dart';


// class UserTransactions extends StatefulWidget {
//   @override
//   _UserTransactionsState createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {

// Future<List<Transactions>> updatedTransaction = DBHelper.newTable();

// List<Transactions> _userTransaction = [
//     Transactions(
//       id:1,
//       name: "Demo 1",
//       amount: 129,
      
//     ),
//     Transactions(
//       id:2,
//       name: "Demo 2",
//       amount: 100.892,
//     ),
    
   
//   ];



//   void _addNewTransaction(Transactions transaction) {
//     final newTx = transaction;
//     setState(() {
//       _userTransaction.add(newTx);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
        
//         TransactionList(_userTransaction),
//       ],
//     );
//   }
// }
