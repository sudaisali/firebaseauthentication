import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseauthentication/screens/addpost.dart';
import 'package:firebaseauthentication/screens/login_screen.dart';
import 'package:firebaseauthentication/services/toast_services.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final userid = FirebaseAuth.instance.currentUser!.uid.toString();
  final ref = FirebaseDatabase.instance.ref('posts');
  final searchController = TextEditingController();
  final titleController = TextEditingController();
  final noteController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }).onError((error, stackTrace) {});
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search",
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              //Fire base animated list
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    //get value of title in variable for search
                    final title = snapshot.child('title').value.toString();
                    final note = snapshot.child('Posts').value.toString();
                    final id = snapshot.child('id').value.toString();
                    

                    //search empty show all list
                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot
                            .child('title')
                            .value
                            .toString()),
                        subtitle:
                        Text(snapshot
                            .child('Posts')
                            .value
                            .toString()),
                        trailing: PopupMenuButton(

                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) =>
                          [
                            PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  onTap: () {
                                    showMyDialouge(title,note,id);
                                  },
                                )),
                            PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                  onTap: (){
                                    ref.child(id).remove();
                                    Navigator.pop(context);
                                  },
                                )
                            )
                          ],
                        ),
                      );
                    }
                    //if search not empty return match string
                    else if (title.toLowerCase().contains(
                        searchController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot
                            .child('title')
                            .value
                            .toString()),
                        subtitle:
                        Text(snapshot
                            .child('Posts')
                            .value
                            .toString()),
                      );
                    }
                    //other wise nothing
                    else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialouge(String title , String note , String id) async {
    titleController.text = title;
    noteController.text = note;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: SizedBox(
              height: 116,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter your NotesTitle",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                       controller: noteController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Enter your notes",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                 ref.child(id).update({
                   "title":titleController.text.toString(),
                   "Posts":noteController.text.toString(),
                 }).then((value) => {
                   ToastServices().showtoast("DataSave Successfully"),
                 }).onError((error, stackTrace)=>{
                   ToastServices().showtoast(error.toString()),
                 });
                            Navigator.pop(context);
              }, child: Text("Update")),
              TextButton(onPressed: (){
                            Navigator.pop(context);
              }, child: Text("Cancel"))
            ],
          );
        }
    );

  }
}

// Widget Streambuilders(){
//   return  Expanded(
//       child: StreamBuilder(
//         stream: ref.onValue,
//         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//           Map<dynamic , dynamic> map  = snapshot.data!.snapshot.value as
//           dynamic;
//           List<dynamic> list = [];
//           list.clear();
//           list = map.values.toList();
//           if (!snapshot.hasData) {
//             return const  Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black26,
//                 strokeWidth: 5,
//               ),
//             );
//           } else {
//             return ListView.builder(
//                 itemCount: snapshot.data!.snapshot.children.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(list[index]['title']),
//                     subtitle: Text(list[index]['Posts']),
//                   );
//                 });
//           }
//         },
//       ));
// }
