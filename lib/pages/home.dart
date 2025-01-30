import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            FormPage(),
            Container(),
          ],
        ),
        backgroundColor: Colors.lightBlue,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(text: "บันทึกคะแนนสอบ",),
            Tab(text: "รายชื่อนักเรียน",),
          ],
        ),
      ),
    );
  }
}
