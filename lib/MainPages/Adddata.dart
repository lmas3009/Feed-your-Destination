import 'dart:io';

import 'package:feed_destination/MainPages/Navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Adddata extends StatefulWidget {
  Adddata({Key key}) : super(key: key);

  @override
  _AdddataState createState() => _AdddataState();
}

TextEditingController _controller1 = new TextEditingController();
TextEditingController _controller2 = new TextEditingController();
TextEditingController _controller3 = new TextEditingController();

class _AdddataState extends State<Adddata> {
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
    _controller1.text = '';
    _controller2.text = '';
    _controller3.text = '';
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
    database.child(uid2).child('Profile').once().then((DataSnapshot data){
                    var res =data.value;
                    print(res['ProfileImg']);
                      setState(() {
                        profile=res['ProfileImg'];
                      });
                  });
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
  var profile = '';
 

  Post(title,location,description,date,img) async{
    final auth.User user =auth1.currentUser;
      final uid = user.email;
      var uid1 = uid.replaceAll("@", "_");
      var uid2 = uid1.replaceAll(".", "-");
      print(img);
          StorageTaskSnapshot snapshot = await storage
              .ref()
              .child(uid2)
              .child("Posts")
              .child(title)
              .putFile(img)
              .onComplete;
          if (snapshot.error == null) {
            final String downloadUrl =
                await snapshot.ref.getDownloadURL();
                print(profile);
                database.child("Posts").child(uid2).child(title).update(
                  {
                    "Title": title,
                    "Location": location,
                    "Description": description,
                    "Date": date,
                    "Image": downloadUrl,
                    "ProfileImg": profile
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

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar()));
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
                      controller: _controller3,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Title...",
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
                      controller: _controller1,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        maxLength: 20,
                        decoration: InputDecoration(
                          hintText: "Location...",
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
                      controller: _controller2,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Description...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 160,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text("${selectedDate.toLocal().toString().substring(0,10)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                        )
                      )
                    ),
                    InkWell(
                      onTap: (){
                        _selectDate(context);
                      },
                      child: Container(
                      height: 55,
                      width: 120,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10))
                      ),
                      child: Center(
                        child: Text("Pick date",style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),
                      )
                    ),
                    ),
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 30),),
              ],
            ),
          ),
        ),
      onWillPop: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar()));
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Post(_controller3.text,_controller1.text,_controller2.text,selectedDate.toLocal().toString().substring(0,10),_image);
        },
        child: Icon(Icons.check,size: 30),
      ),
    );
  }
}