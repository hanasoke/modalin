import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modalin/model/bussiness_model.dart';
import 'package:modalin/model/user_model.dart';

class BussinessScreen extends StatefulWidget {
  const BussinessScreen({Key? key}) : super(key: key);

  @override
  State<BussinessScreen> createState() => _BussinessScreenState();
}

class _BussinessScreenState extends State<BussinessScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference bussiness = firebase.collection('bussiness');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Bussiness'),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: bussiness.get(),
        builder: (_, snapshot) {
          // show if there is data
          if (snapshot.hasData) {
            // we take the document and pass it to a variable
            var alldata = snapshot.data!.docs;

            // if there is data, make list
            return alldata.length != 0
                ? ListView.builder(

                    // display as much as the variable data alldata
                    itemCount: alldata.length,

                    // make custom itemk with list tile.
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          // get first character of name
                          child: Text(alldata[index]['type'][0]),
                        ),
                        title: Text(alldata[index]['name'],
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text(alldata[index]['type'],
                            style: TextStyle(fontSize: 20)),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bussinessModel(
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
            MaterialPageRoute(builder: (context) => bussinessModel()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
