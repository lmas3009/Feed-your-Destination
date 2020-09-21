import 'package:feed_destination/MainPages/Home.dart';
import 'package:feed_destination/MainPages/Navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Feed Your Destinaton" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                },
                child: Container(
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 10
                      )
                    ]
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.phone_android,color: Colors.white,size: 30,),
                        Text("Login Using Phone",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w800),),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

TextEditingController _controller1 = new TextEditingController();
TextEditingController _controller2 = new TextEditingController();
TextEditingController _controller3 = new TextEditingController();
TextEditingController _controller4 = new TextEditingController();
TextEditingController _controller5 = new TextEditingController();

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1.text = '';
    _controller2.text = '';
    _controller3.text = '';
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("jskdfgsjh"),
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: Column(
                children: [
                  Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextFormField(
                      controller: _controller1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_box_rounded),
                          hintText: "Username...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                    )
                  ),
                ),
                  Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextFormField(
                      controller: _controller2,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          hintText: "Email Id...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                    )
                  ),
                ),
                Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 3),
                    child: Center(
                      child: TextFormField(
                      controller: _controller3,
                        maxLines: 1,
                        decoration: InputDecoration(
                          icon: Icon(Icons.security_outlined),
                          hintText: "Password...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                    )
                  ),
                ),
                InkWell(
                  onTap: (){
                    createUser(_controller1.text,_controller2.text,_controller3.text).whenComplete(() => 
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar()))
                    );
                  },
                      child: Container(
                      height: 55,
                      width: 200,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Create Account",style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),
                      )
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 20),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    },
                    child: Text("Have an account? SignIn",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: (){
        Navigator.pop(context);
      },
      )
    );
  }
}


class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller4.text = '';
    _controller5.text = '';
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("jskdfgsjh"),
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: Column(
                children: [
                  Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextFormField(
                      controller: _controller4,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined),
                          hintText: "Email Id...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          ),
                      ),
                    )
                  ),
                ),
                Container(
                  height: 60,
                  width: 300,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,bottom: 3),
                    child: Center(
                      child: TextFormField(
                      controller: _controller5,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.security_outlined),
                          hintText: "Password...",
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hoverColor: Colors.red,
                          
                          ),
                      ),
                    )
                  ),
                ),
                InkWell(
                  onTap: (){
                    loginuser(_controller4.text,_controller5.text).whenComplete(() => 
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Navbar()))
                    );
                  },
                      child: Container(
                      height: 55,
                      width: 200,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Sign In",style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),
                      )
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 20),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                    child: Text("Don't have an account? SignUp",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: (){
        Navigator.pop(context);
      },
      )
    );
  }
}
final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;


Future createUser(username,email,password) async{
  var email_1 = email.toString().replaceAll('@', "_");
  var email1 = email_1.replaceAll('.', "-");

  var _firebasedata = FirebaseDatabase().reference().child("Usernames").child(email1);
    try{
      final auth.User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      _firebasedata.set(
        {
          "Email": email,
          "Username": username
        }
      );
    return user!=null;
    }
    catch(e){
      return e.message;
    }
}  

Future loginuser(email,password) async{
  try{
    final auth.User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user!=null;
  }
  catch(e){
    return e.message;
  }
}