import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final title = TextEditingController();
  final notescontroller = TextEditingController();
  final refrence = FirebaseDatabase.instance.ref('posts');



  void savenotes(){
         final postid = DateTime.now().microsecondsSinceEpoch.toString();
         refrence.child(postid).set({
           "id":postid.toString(),
           "title":title.text.toString(),
           "Posts":notescontroller.text.toString(),
         }).then((value){
           ToastServices().showtoast("NotesAdded Successfully");

         })
             .onError((error, stackTrace){
               ToastServices().showtoast(error.toString());

         });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Enter your NotesTitle",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: notescontroller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your notes",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                savenotes();
              },
                  child: Padding(
                    padding:EdgeInsets.all(10),
                      child: Text("Submit Notes")))
            ],
          ),
        ),
      ),
    );
  }
}
