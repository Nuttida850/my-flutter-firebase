import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
                  var i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายงานคะแนนสอบ"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("students").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 10,
                  shadowColor: Colors.blueAccent.withValues(alpha: 0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            document["score"],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      title: Text(document["fname"] +' '+ document["lname"],  style: TextStyle(fontSize: 20, color: Colors.black)),
                      subtitle: Text(document["email"], style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
