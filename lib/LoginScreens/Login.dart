import 'package:feed_destination/MainPages/Home.dart';
import 'package:feed_destination/MainPages/Navbar.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar()));
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