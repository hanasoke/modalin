import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bussinessModel extends StatefulWidget {
  const bussinessModel({this.id});

  final String? id;
  @override
  State<bussinessModel> createState() => _BussinessPageState();
}

class _BussinessPageState extends State<bussinessModel> {
  // set form key
  final _formKey = GlobalKey<FormState>();

  // set texteditingcontroller variable
  var type = TextEditingController();
  var name = TextEditingController();
  var taxpayer = TextEditingController();
  var legality = TextEditingController();
  var turnover = TextEditingController();
  var address = TextEditingController();
  var marketplace = TextEditingController();
  var socialmedia = TextEditingController();
  var other = TextEditingController();

  // inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? bussiness;

  void getData() async {
    // get loan collection from firebase
    // collection is table in mysql
    bussiness = firebase.collection('bussiness');

    // if have id
    if (widget.id != null) {
      // get users data based on id document
      var data = await bussiness!.doc(widget.id).get();

      // we get data.data()
      // so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      // set state to fill data controller from data firebase
      setState(() {
        type = TextEditingController(text: item['type']);
        name = TextEditingController(text: item['name']);
        taxpayer = TextEditingController(text: item['taxpayer']);
        legality = TextEditingController(text: item['legality']);
        turnover = TextEditingController(text: item['turnover']);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BUSSINESS FORM"),
        actions: [
          // if have data show delete button
          widget.id != null
              ? IconButton(
                  onPressed: () {
                    // method to delegate data based on id
                    bussiness!.doc(widget.id).delete();

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
              "Personal Bussiness Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: type,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Type of Bussiness",
                  prefixIcon: Icon(Icons.business_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Type of Bussiness is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Name of Bussiness",
                  prefixIcon: Icon(Icons.add_business),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name of Bussiness is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: taxpayer,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Taxpayer Number",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Taxpayer Number is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: legality,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Bussiness Legality",
                  prefixIcon: Icon(Icons.business_center_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bussiness Legality is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: turnover,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Bussiness Turnover",
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bussiness Turnover is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: address,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "fill the Company Address",
                  prefixIcon: Icon(Icons.playlist_add_circle_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Company Address is Required!';
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
                  return 'Marketplace is Required!';
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
                    bussiness!.add({
                      'type': type.text,
                      'name': name.text,
                      'taxpayer': taxpayer.text,
                      'legality': legality.text,
                      'turnover': turnover.text,
                      'address': address.text,
                      'marketplace': marketplace.text,
                      'socialmedia': socialmedia.text,
                      'other': other.text,
                    });
                  } else {
                    bussiness!.doc(widget.id).update({
                      'type': type.text,
                      'name': name.text,
                      'taxpayer': taxpayer.text,
                      'legality': legality.text,
                      'turnover': turnover.text,
                      'address': address.text,
                      'marketplace': marketplace.text,
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
            ),
          ],
        ),
      ),
    );
  }
}
