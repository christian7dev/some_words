import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:some_words/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "something",
    home: App(),
  ));
}


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  
  final datas = FirebaseFirestore.instance.collection('words');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: text("SOME", "WORDS"),
        centerTitle: true,
      ),

      body : StreamBuilder(
        stream: datas.snapshots(),
        builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshots){
          if(snapshots.hasData){
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
                itemBuilder: (context , int index) {
                  final documnet = snapshots.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 20,
                      shadowColor: Colors.red,
                      child: Container(
                        margin: EdgeInsets.all(30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                  documnet['title'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                    documnet['words'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Add()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
            Icons.add,
          size: 22,
        ),
      ),
    );
  }
}


Widget text(first , second){
  return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: first,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )
          ),
          TextSpan(
              text: "  " + second,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              )
          )
        ]
      )
  );
}