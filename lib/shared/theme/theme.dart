import 'package:flutter/material.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';
import 'package:sgwen_scouts_5/shared/theme/lion_theme/lion_theme.dart';
import 'package:sgwen_scouts_5/shared/theme/panther_theme/panther_theme.dart';
import 'package:sgwen_scouts_5/shared/theme/tiger_theme/tiger_theme.dart';
import 'package:sgwen_scouts_5/shared/theme/wolf_theme/wolf_theme.dart';

ThemeData appTheme ()
{
  String? teamName = UserData.data!['teamName'];
  var theme;

  ///condition for lion theme
  if(teamName == 'الأسد')
  {
    theme = LionTheme.lionTheme;
  }

  ///condition for wolf theme
  else if(teamName == 'الذئب')
  {
    theme = WolfTheme.wolfTheme;
  }

  ///condition for panther theme
  else if(teamName == 'الفهد')
  {
    theme = PantherTheme.pantherTheme;
  }

  ///condition for tiger theme
  else if(teamName == 'النمر')
  {
    theme = TigerTheme.tigerTheme;
  } else {
    return theme = PantherTheme.pantherTheme;
  }

  return theme;
}
