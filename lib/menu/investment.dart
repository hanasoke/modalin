import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modalin/model/investment_model.dart';
import 'package:modalin/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({Key? key}) : super(key: key);

  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference investment = firebase.collection('investment');

    return Scaffold(
      appBar: AppBar(
        title: Text("INVESTMENT"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 145, 255),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: investment.get(),
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

                    // make custom item with list tile
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          // get first character of name
                          child: Text(alldata[index]['amount'][0]),
                        ),
                        title: Text(alldata[index]['workplace'],
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(alldata[index]['amount'],
                            style: TextStyle(fontSize: 20)),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => investmentModel(
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
            MaterialPageRoute(builder: (context) => investmentModel()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
