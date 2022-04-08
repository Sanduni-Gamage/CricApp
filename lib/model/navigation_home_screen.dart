import 'package:cricketapp/pages/home.dart';

import 'package:flutter/material.dart';

import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';

import '../service/app_theme.dart';


// ignore: use_key_in_widget_constructors
class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  
  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
           onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const HomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
           
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
           
          });
          break;
        default:
          break;
      }
    }
  }
}
