import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modalin/model/user_model.dart';

class loanModel extends StatefulWidget {
  const loanModel({this.id});

  final String? id;
  @override
  State<loanModel> createState() => _LoanPageState();
}

class _LoanPageState extends State<loanModel> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // set form key
  final _formKey = GlobalKey<FormState>();

  // set texteditingcontroller variable
  var amount = TextEditingController();
  var refund = TextEditingController();
  var company = TextEditingController();
  var address = TextEditingController();
  var marketplace = TextEditingController();
  var socialmedia = TextEditingController();
  var other = TextEditingController();

  // inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? loan;

  void getData() async {
    //get loan collection from firebase
    // collection is table in mysql
    loan = firebase.collection('loan');

    // if have id
    if (widget.id != null) {
      // get users data based on id document
      var data = await loan!.doc(widget.id).get();

      // we get data.data()
      // so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      // set state to fill data controller from data firebase
      setState(() {
        amount = TextEditingController(text: item['amount']);
        refund = TextEditingController(text: item['refund']);
        company = TextEditingController(text: item['company']);
        address = TextEditingController(text: item['address']);
        marketplace = TextEditingController(text: item['marketplace']);
        socialmedia = TextEditingController(text: item['socialmedia']);
        other = TextEditingController(text: item['other']);
      });
    }
  }

  @override
  void initState() {
    // ignore
    // TODO: implement initState
    getData();
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOAN FORM"),
        actions: [
          // if have data show delete button
          widget.id != null
              ? IconButton(
                  onPressed: () {
                    // method to delegate data based on id
                    loan!.doc(widget.id).delete();

                    // back to main page
                    // '/' is home
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.delete))
              : SizedBox()
        ],
      ),
      // this form for add and edit data
      // if have id passed from main, field will show data
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              "TAKE THE LOAN",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Borrower : ${loggedInUser.firstName} ${loggedInUser.secondName}",
            ),
            SizedBox(height: 10),
            Text(
              "Phone Number : ${loggedInUser.phoneNumber}",
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Amount",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Amount is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: refund,
              decoration: InputDecoration(
                  hintText: "Refund",
                  prefixIcon: Icon(Icons.money_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Refund is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: company,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Name of Company",
                  prefixIcon: Icon(Icons.business_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Company Name is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: address,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Company Address",
                  prefixIcon: Icon(Icons.roundabout_right),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: marketplace,
              decoration: InputDecoration(
                  hintText: "MarketPlace",
                  prefixIcon: Icon(Icons.store_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'MarketPlace is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: socialmedia,
              decoration: InputDecoration(
                  hintText: "Social Media",
                  prefixIcon: Icon(Icons.apps_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Social Media is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: other,
              decoration: InputDecoration(
                  hintText: "Other Application",
                  prefixIcon: Icon(Icons.devices_other),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Other Application is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.id == null) {
                    loan!.add({
                      'amount': amount.text,
                      'refund': refund.text,
                      'company': company.text,
                      'address': address.text,
                      'marketplace': marketplace.text,
                      'socialmedia': socialmedia.text,
                      'other': other.text,
                    });
                  } else {
                    loan!.doc(widget.id).update({
                      'amount': amount.text,
                      'refund': refund.text,
                      'company': company.text,
                      'address': address.text,
                      'marketplace': marketplace.text,
                      'socialmedia': socialmedia.text,
                      'other': other.text,
                    });
                  }
                  // snackbar notification
                  final snackBar =
                      SnackBar(content: Text('Data Saved Successfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // back to main page
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
