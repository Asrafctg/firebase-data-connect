import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addpostpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color activeColors =Colors.green;
  final Color disactiveColors =Colors.red;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Blogs_Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Post'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> AddPostPage()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((mydata){
              Timestamp dbtime = mydata['post_created'];
              DateTime postTime = dbtime.toDate();
              bool is_approved = mydata['post_approved'];
              var documentid = mydata.id;
              return GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Are You Sure!.....'),
                          content: Text('You want to Deleted your life'),
                          actions: [
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text('No')),
                            TextButton(
                              onPressed: (){
                                collectionReference.doc(documentid).delete()
                                    .then((value){
                                      Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Post has been deleted Succcessfukly ')));
                                }).catchError((onError)=> print(onError));
                              },
                              child: Text('No'),
                            )
                          ],
                        );
                      });
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  color: is_approved?activeColors:disactiveColors,
                  child: Column(
                    children: [
                      Text(mydata['title']),
                      Text(mydata['desc']),
                      Text(mydata['type']),
                      Text(postTime.toString()),
                    ],
                  ),
                ),
              );
            }).toList()
          );
        },
      ),
    );
  }
}
