import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? selectedType;
  bool is_loading = false;
  var titleCon = TextEditingController();
  var descCon = TextEditingController();
  CollectionReference mycollect =
      FirebaseFirestore.instance.collection('Blogs_Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: this.is_loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: titleCon,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Title......'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: descCon,
                    minLines: 3,
                    maxLines: 7,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Desc......'),
                  ),
                ),
                Text('Select Post Type'),
                RadioListTile(
                  title: Text('Flutter'),
                  value: 'Flutter',
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Web'),
                  value: 'web',
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Database'),
                  value: 'Database',
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleCon.text.isEmpty || descCon.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('All Fields Are Required')));
                      } else {
                        setState(() {
                          this.is_loading = true;
                          DateTime currenttime = DateTime.now();
                          Map<String,dynamic> mymap =<String,dynamic>{
                            'uid':'vjnvjfn',
                            'pictfv':'jvnjsdfn'

                          };
                          Map<String, dynamic> mydata = <String, dynamic>{
                            'title': titleCon.text,
                            'desc': descCon.text,
                            'type': selectedType,
                            'post_created': currenttime,
                            'post_approved': false,
                            'tags':['hello','ndvjsnvjsd','bchsdbvhsb'],
                            'map':mymap

                          };
                          mycollect.add(mydata).then((value) {
                            setState(() {
                              this.is_loading = false;
                              Navigator.of(context).pop();
                            });
                          }).catchError((onError) {
                            this.is_loading = false;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(onError)));
                          });
                        });
                      }
                    },
                    child: Text('Submit'),
                  ),
                )
              ],
            ),
    );
  }
}
