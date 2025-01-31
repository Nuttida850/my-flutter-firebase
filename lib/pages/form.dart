import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = Student();
  //เตรียม Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  //สร้างCollectionชื่อ students
  CollectionReference studenCollection = FirebaseFirestore.instance.collection("students");
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                  centerTitle: true,
                ),
                body: Center(
                  child: Text("${snapshot.error}"),
                ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("แบบฟอร์มบันทึกคะแนนสอบ"),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FormStudent(
                          text: "ชื่อนักเรียน",
                          keyboardType: TextInputType.text,
                          hintText: "ป้อนชื่อนักเรียน",
                          student: myStudent.fname,
                          validator: RequiredValidator(
                              errorText: "กรุณาป้อนชื่อนักเรียน"),
                          save: (value) => myStudent.fname = value,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormStudent(
                          text: "นามสกุล",
                          keyboardType: TextInputType.text,
                          hintText: "ป้อนนามสกุล",
                          student: myStudent.lname,
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนนามสกุล"),
                          save: (value) => myStudent.lname = value,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormStudent(
                          text: "อีเมล",
                          keyboardType: TextInputType.emailAddress,
                          hintText: "ป้อนอีเมล",
                          student: myStudent.email,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "กรุณาป้อนชื่อนักเรียน"),
                            EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                          ]),
                          save: (value) => myStudent.email = value,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormStudent(
                          text: "คะแนน",
                          keyboardType: TextInputType.number,
                          hintText: "ป้อนคะแนน",
                          student: myStudent.score,
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนคะแนน"),
                          save: (value) => myStudent.score = value,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: Text(
                              "บันทึกข้อมูล",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await studenCollection.add({
                                  "fname": myStudent.fname,
                                  "lname": myStudent.lname,
                                  "email": myStudent.email,
                                  "score": myStudent.score,
                              });
                                formKey.currentState!.reset();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class FormStudent extends StatelessWidget {
  FormStudent(
      {super.key,
      this.keyboardType,
      this.hintText,
      this.text,
      this.student,
      this.validator,
      this.save});

  TextInputType? keyboardType;
  String? hintText;
  String? text;
  String? student;
  FieldValidator<dynamic>? validator;
  Function(String?)? save;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        text!,
        style: TextStyle(fontSize: 20),
      ),
      TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: hintText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          validator: validator!.call,
          onSaved: save),
    ]);
  }
}
