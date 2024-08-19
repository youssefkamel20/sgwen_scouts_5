import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgwen_scouts_5/layout/login_layout/login_layout.dart';
import 'package:sgwen_scouts_5/layout/user_layout/user_layout.dart';
import 'package:sgwen_scouts_5/shared/constants/constants.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    print('Splash screen is created');
    // uId = CacheHelper.getData(key: 'uId');
    // Widget widget;
    // //print('$uId');
    // if(uId == null){
    //   widget = LoginLayout();
    // }else {
    //   widget = UserLayout();
    // }
    Future.delayed(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginLayout()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          child: Image(
              image: AssetImage('images/groupLogo.png')),
        ),
      ),
    );
  }
}
