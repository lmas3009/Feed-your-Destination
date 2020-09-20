import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
            height: 150,
            width: 300,
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
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                    ),
                    Container(margin: const EdgeInsets.only(left: 20)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Aravind Kumar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("+91 111 111 1111",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
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
                    print("hello");
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
                Container(margin: const EdgeInsets.only(top: 10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Push Notifications",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),),
                    Switch(
                      value: isSwitched1,
                      onChanged: (value){
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