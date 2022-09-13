import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:some_words/main.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {


  final db = FirebaseFirestore.instance.collection('words');
  final _formkey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _words = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: text("ADD", "WORD"),
         centerTitle: true,
         backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _title,
                validator: (val){
                  if( val == null || val.isEmpty ){
                    return "ENTER TITLE";
                  }
                },
                maxLength: 50,
                decoration: const InputDecoration(
                  hintText: "TITLE",
                  hintStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _words,
                validator: (val){
                  if( val == null || val.isEmpty ){
                    return "ENTER TITLE";
                  }
                },
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "SAY SOMETHING",
                  hintStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),


            SizedBox(
              height: 20,
            ),


            GestureDetector(
              onTap: () async {
                if(_formkey.currentState!.validate()){
                 await  db.doc().set({
                    'title' : _title.text,
                    'words' : _words.text
                  }).then((value) => Navigator.pop(context));
                  return null;
                }
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 10,

                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    "POST",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
