import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:feed_destination/MainPages/Home.dart';
import 'package:feed_destination/MainPages/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Navbar extends StatefulWidget {
  Navbar({Key key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
 int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                Home(),
                Container(color: Colors.red,),
                Container(color: Colors.green,),
                Setting()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: Text('Home'),
                icon: Icon(Icons.home)
              ),
              BottomNavyBarItem(
                title: Text('Locations'),
                icon: Icon(Icons.apps)
              ),
              BottomNavyBarItem(
                title: Text('Chat'),
                icon: Icon(Icons.chat_bubble)
              ),
              BottomNavyBarItem(
                title: Text('Settings'),
                icon: Icon(Icons.settings)
              ),
            ],
          ),
        ),
        onWillPop: (){showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        );
        }
      );
  }
}