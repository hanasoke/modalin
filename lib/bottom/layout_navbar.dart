import 'package:flutter/material.dart';
import 'package:modalin/menu/bussiness.dart';
import 'package:modalin/menu/loan.dart';

import 'package:modalin/menu/investment.dart';
import 'package:modalin/menu/profile.dart';
import 'package:modalin/screens/home_screen.dart';

class LayoutNavigationBar extends StatefulWidget {
  @override
  _LayoutNavigationBarState createState() => _LayoutNavigationBarState();
}

class _LayoutNavigationBarState extends State<LayoutNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const LoanScreen(),
    const InvestmentScreen(),
    const BussinessScreen(),
    const ProfileScreen(),
  ];

  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onBarTapped,
          items: [
            BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: new Icon(Icons.money_sharp), label: 'Loan'),
            BottomNavigationBarItem(
                icon: new Icon(Icons.attach_money_rounded),
                label: 'Investment'),
            BottomNavigationBarItem(
                icon: new Icon(Icons.business_center), label: 'My Bussiness'),
            BottomNavigationBarItem(
                icon: new Icon(Icons.person_pin_rounded), label: 'Profile'),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
