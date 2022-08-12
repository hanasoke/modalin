import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class investmentModel extends StatefulWidget {
  const investmentModel({this.id});

  final String? id;
  @override
  State<investmentModel> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<investmentModel> {
  // set form key
  final _formKey = GlobalKey<FormState>();

  // set texteditingcontroller variable
  var amount = TextEditingController();
  var workplace = TextEditingController();

  // inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? investment;

  void getData() async {
    investment = firebase.collection('investment');

    // if have id
    if (widget.id != null) {
      // get users data based on id document
      var data = await investment!.doc(widget.id).get();

      // we get data.data()
      // so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      // set state to fill data controller from data firebase
      setState(() {
        amount = TextEditingController(text: item['amount']);
        workplace = TextEditingController(text: item['workplace']);
      });
    }
  }

  @override
  void initState() {
    // ignore
    // TODO: implement initStatel dv
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INVESTMENT"),
        actions: [
          // if have data show delete button
          widget.id != null
              ? IconButton(
                  onPressed: () {
                    // method to delegate data based on id
                    investment!.doc(widget.id).delete();

                    // back to main page
                    // '/' is home
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
              "INVEST NOW",
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
              controller: workplace,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "The Company that is Invested ?",
                  prefixIcon: Icon(Icons.business_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Workplace Company is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
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
                    investment!.add(
                        {'amount': amount.text, 'workplace': workplace.text});
                  } else {
                    investment!.doc(widget.id).update(
                        {'amount': amount.text, 'workplace': workplace.text});
                  }
                  // snackbar notification
                  final snackBar =
                      SnackBar(content: Text('Data Saved Sucessfully!'));
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
