import 'package:auto_size_text/auto_size_text.dart';
import 'package:feed_destination/MainPages/Adddata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var database = FirebaseDatabase().reference();
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  var name='';
  var profile='';
  List<Widget> posts=[];

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      setState(() {});
    });

    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
    database.child(uid2).child('Profile').once().then((DataSnapshot data){
      var res =data.value;
        setState(() {
          profile=res['ProfileImg'];
          name=res['Username'];
        });
    });

    database.child("Posts").once().then((DataSnapshot dataSnapshot) {
      Map<dynamic,dynamic> data = dataSnapshot.value;
      data.forEach((key, value) {
        database.child("Posts").child(key).once().then((DataSnapshot dataSnapshot) {
        Map<dynamic,dynamic> data1 = dataSnapshot.value;
        data1.forEach((key, value) {
        posts.add(
          Container(
              height: 300,
              width: 400,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: Colors.black)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:Stack(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                    value['Image'],
                                    height: 200.0,
                                    width: 400,
                                    fit: BoxFit.cover,
                                ),
                            )
                          ),
                          SizedBox(
                              child:  Container(
                                  height: 30.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: AutoSizeText(
                                      value['Location'],
                                      style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w700,color: Colors.white),
                                      maxLines: 2,
                                    ),
                                  )
                                ),
                              ),
                        ],
                      ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 20),),
                  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundImage:NetworkImage('${value['ProfileImg']}'),
                        ),
                      ),
                      Container(margin: const EdgeInsets.only(left: 10),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         SizedBox(
                            width: 250.0,
                            child: AutoSizeText(
                              value['Title'],
                              style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),
                              maxLines: 2,
                            ),
                         ),
                        Container(margin: const EdgeInsets.only(top: 5),),
                          Text(value['Date'], style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ));
        });
      });
    });
    });
    print(posts.length);
  }
/**/

 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Hi, ",style: TextStyle(color: Colors.black),),
                      Text("${name}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1,color: Colors.black)
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundImage:NetworkImage('${profile}'),
                        radius: 30,
                      ),
                    )
                  ),
                ],
              ),
            ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
        margin: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 130,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle,color: Colors.white,size: 50,),
                        Container(margin: const EdgeInsets.only(top: 10),),
                        Text("ADD",style: TextStyle(color: Colors.white,fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  width: 220,
                  margin: const EdgeInsets.only(left: 5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return 
                Container(
                  height: 130,
                  width: 100,  
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle,color: Colors.white,size: 50,),
                        Container(margin: const EdgeInsets.only(top: 10),),
                        Text("ADD",style: TextStyle(color: Colors.white,fontSize: 20)),
                      ],
                    ),
                  ),
                );
                  },
                ),
                )
              ]
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: posts,
              )
            ),
          ],
        ),
      ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Adddata()));
        },
        child: Icon(Icons.add_a_photo_outlined),
      ), 
    );
  }
}
