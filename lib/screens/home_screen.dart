import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modalin/model/user_model.dart';
import 'package:modalin/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
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
        title: Text("MODALIN"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 145, 255),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              // passing this to our root
              logout(context);
            }),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Color.fromARGB(255, 0, 157, 255),
                height: 200,
                width: 500,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25),
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${loggedInUser.email}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${loggedInUser.phoneNumber}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                height: 458,
                width: 500,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 230, left: 25),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Grow Your Asset",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Explore new opportunity everyday",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: AssetImage("assets/loan.png"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Color.fromARGB(255, 178, 178, 178),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            "Ajukan Pinjaman Modal Usaha",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Pinjaman mudah dilakukan hanya dengan 1 klik",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: AssetImage("assets/giving.png"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Color.fromARGB(255, 178, 178, 178),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            "Berikan Pinjaman",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Berikan Pinjaman Uang kepada Pelaku Usaha",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: AssetImage("assets/data.png"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Color.fromARGB(255, 178, 178, 178),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            "Data Usaha",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Isi Kelengkapan Data Usaha untuk melakukan Peminjaman",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: AssetImage("assets/profile.png"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                color: Color.fromARGB(255, 178, 178, 178),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          title: Text(
                            "Lihat Profile",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "Lihat Profile Sekarang",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
