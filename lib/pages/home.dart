import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/display.dart';
import 'package:flutter_firebase/pages/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  List pages = [
    FormPage(),
    DisplayPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 20, offset: Offset(0, 10))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            currentIndex: _index,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.lightBlue,
            unselectedItemColor: Colors.black,
            selectedFontSize: 18,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit_document), label: "บันทึกคะแนนสอบ"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "รายชื่อนักเรียน"),
            ],
          ),
        ),
      ),
      body: pages[_index],
    );
  }
}
