import 'dart:io';

import 'package:feed_destination/LoginScreens/Login.dart';
import 'package:feed_destination/MainPages/Navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  var database = FirebaseDatabase().reference();
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  var name='';
  var new_mail = '';
  var emailId = '';
  var profile= '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
    database.child("Usernames").child(uid2).once().then((DataSnapshot data){
      var res =data.value;
        setState(() {
          name=res['Username'];
          new_mail = uid2;
          emailId= uid;
        });
    });
    database.child(uid2).child('Profile').once().then((DataSnapshot data){
      var res =data.value;
      print(res['ProfileImg']);
        setState(() {
          profile=res['ProfileImg'];
        });
    });
  }

  addnotify(name,value) {
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
      var _database = FirebaseDatabase().reference().child(uid2).child("Notification").child(name);
      _database.update(
        {
          "Name": name,
          "Value": value
        }
      );

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
            height: 150,
            width: 350,
            margin: const EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.black),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Container(margin: const EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    Container(margin: const EdgeInsets.only(left: 10)),
                    Container(
                    height: 60,
                    width: 60,
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
                    Container(margin: const EdgeInsets.only(left: 20)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${emailId}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("${name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                      ],
                    )
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 10),),
                Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: (){
                    signout(context);
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    child:Center(
                      child: Text("Sign out this account",style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),),
                    )
                  ),
                )
              ],
            )
          ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20,top: 50),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Profile Settings",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.grey),),
                Container(margin: const EdgeInsets.only(top: 10),),
                Divider(height: 2,color: Colors.grey,),
                Container(margin: const EdgeInsets.only(top: 20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                      },
                      child: Container(margin: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_forward_ios, color: Colors.grey,),
                      ),
                    )
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Push Notifications",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                    Switch(
                      value: isSwitched1,
                      onChanged: (value){
                        addnotify("Push Notifications",value);
                        setState(() {
                          isSwitched1=value;
                          print(isSwitched1);
                        });
                      },
                      activeTrackColor: Colors.black,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chat Notifications",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                    Switch(
                      value: isSwitched2,
                      onChanged: (value){
                        addnotify("Chat Notifications",value);
                        setState(() {
                          isSwitched2=value;
                          print(isSwitched2);
                        });
                      },
                      activeTrackColor: Colors.black,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Update's",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                    Switch(
                      value: isSwitched3,
                      onChanged: (value){
                        addnotify("Updates",value);
                        setState(() {
                          isSwitched3=value;
                          print(isSwitched3);
                        });
                      },
                      activeTrackColor: Colors.black,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 20)),
                Text("Support",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.grey)),
                Container(margin: const EdgeInsets.only(top: 10),),
                Divider(height: 2,color: Colors.grey,),
                Container(margin: const EdgeInsets.only(top: 20),),
                Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                Container(margin: const EdgeInsets.only(top: 20),),
                Text("Feedback",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                Container(margin: const EdgeInsets.only(top: 20),),
                Text("Rate this 5 🌟",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                
            ],
            )
          ),
        ],
      ),
    );
  }
}

signout(BuildContext context) async{
  FirebaseAuth.instance.signOut().whenComplete(() => 
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()))
  );
}


class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

TextEditingController _controller1 = new TextEditingController();
TextEditingController _controller2 = new TextEditingController();
TextEditingController _controller3 = new TextEditingController();

class _EditProfileState extends State<EditProfile> {
 File _image;
  final picker = ImagePicker();
 var database = FirebaseDatabase().reference();
  final FirebaseAuth auth1 = FirebaseAuth.instance;
  var storage = FirebaseStorage.instance;
  var name='';
  bool isLoading = false;
  @override
  void initState() { 
    super.initState();
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
    database.child("Usernames").child(uid2).once().then((DataSnapshot data){
      var res =data.value;
        setState(() {
          name=res['Username'];
        });
    });
    _controller1.text = '';
    _controller2.text = '';
    _controller3.text = '';
  }

  Future pickImage() async {
    File pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      File cropped = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop your image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
      );

    setState(() {
      _image = cropped;
    });
    }
  }

  updatedata(username,country,description,img) async{
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
      print(img);
          StorageTaskSnapshot snapshot = await storage
              .ref()
              .child(uid2)
              .child("ProfileImage")
              .putFile(img)
              .onComplete;
          if (snapshot.error == null) {
            final String downloadUrl =
                await snapshot.ref.getDownloadURL();
                database.child(uid2).child("Profile").update(
                  {
                    "Username": username,
                    "Country": country,
                    "Description": description,
                    "ProfileImg": downloadUrl
                  }
                );
            
            setState(() {
              isLoading = false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navbar()));
          } else {
            print(
                'Error from image repo ${snapshot.error.toString()}');
            throw ('This file is not an image');
          }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            child: Icon(Icons.cancel_rounded,color: Colors.white,size: 35,),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: WillPopScope(
        child: SingleChildScrollView(
         child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(margin: const EdgeInsets.only(top: 50)),
                _image == null
                ? InkWell(
                  onTap: (){
                    pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined, size: 30),
                          Container(margin: const EdgeInsets.only(top: 20),),
                          Text("Add Image", style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                )
                : Container(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(_image,fit:BoxFit.contain,),
                  )
                ),
                Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 3),
                    child: TextFormField(
                      controller: _controller1,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Username...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 3),
                    child: TextFormField(
                      controller: _controller2,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Country...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 300,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _controller3,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 3,
                        maxLength: 30,
                        decoration: InputDecoration(
                          hintText: "Description...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                  ),
                ),
               
                Container(margin: const EdgeInsets.only(top: 30),),
              ],
            ),
          ),
        ),
      onWillPop: (){
        Navigator.pop(context);
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          updatedata(_controller1.text,_controller2.text,_controller3.text,_image);
        },
        child: Icon(Icons.check,size: 30),
      ),
    );
  }
}