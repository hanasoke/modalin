import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modalin/model/loan_model.dart';
import 'package:modalin/model/user_model.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference loans = firebase.collection('loan');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("LOAN"),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: loans.get(),
        builder: (_, snapshot) {
          // show if there is data
          if (snapshot.hasData) {
            // we take the document and pass it to a variable
            var alldata = snapshot.data!.docs;

            // if there is data, make list
            return alldata.length != 0
                ? ListView.builder(

                    // displayed as much as the variable data alldata
                    itemCount: alldata.length,

                    // make custom item with list tile.
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          // get first character of name
                          child: Text(alldata[index]['amount'][0]),
                        ),
                        title: Text(alldata[index]['company'],
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(alldata[index]['refund'],
                            style: TextStyle(fontSize: 20)),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loanModel(
                                        id: snapshot.data!.docs[index].id,
                                      )),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_outlined),
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          } else {
            return Center(child: Text("Loading"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => loanModel()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
