import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

Color? userteamColor;
Color? userTeamDarkColor;
Color? userColor(){
  var data = UserData.data!['teamName'];

  if (data == 'الأسد'){
    userteamColor = Colors.yellow[700];
    userTeamDarkColor = Colors.yellow[900]!.withOpacity(0.5);
  }else if (data == 'الفهد'){
    userteamColor = Colors.purple[700];
    userTeamDarkColor = Colors.purple[900]!.withOpacity(0.5);
  }else if (data == 'النمر'){
    userteamColor = Colors.blue[900];
    userTeamDarkColor = HexColor('#031f70').withOpacity(0.5);

  }else if (data == 'الذئب'){
    userteamColor = Colors.red[700];
    userTeamDarkColor = Colors.red[900]!.withOpacity(0.5);
  }
  userTeamDarkColor;
  return userteamColor;
}



Image? backgroundImage;
Image? backgroundTheme() {

  var data = UserData.data!['teamName'];
  // var data = 'الأسد';

  if (data == 'الأسد'){
    backgroundImage = Image.asset('images/lion.png');
    }else if (data == 'الفهد'){
    backgroundImage = Image.asset('images/panther.png');
  }else if (data == 'النمر'){
    backgroundImage = Image.asset('images/tiger.png');
  }else if (data == 'الذئب'){
    backgroundImage = Image.asset('images/wolf.png');
  }
  return backgroundImage;
}