import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/firebase_options.dart';
import 'package:sgwen_scouts_5/layout/chief_layout/chief_layout.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/login_layout/login_layout.dart';
import 'package:sgwen_scouts_5/layout/user_layout/user_layout.dart';
import 'package:sgwen_scouts_5/modules/register/register_screen.dart';
import 'package:sgwen_scouts_5/shared/constants/constants.dart';
import 'package:sgwen_scouts_5/shared/network/bloc_observer.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';
import 'package:sgwen_scouts_5/modules/splash/splash_screen.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  //print('uId is removed on open');
  //CacheHelper.saveData(key: 'uId', value: 'wvjk8P5u1pfjmswYkyZszxi9hd32').then((value){print('uId is saved');});
  // uId = CacheHelper.getData(key: 'uId');
  print('the uid is $uId');
  // print("uId is which saved from last login is $uidData in cache memory");
  // UserData userDataFetcher = UserData();
  // userDataFetcher.fetchAndPrintUserData();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      ///Don't touch it is hot
      //theme: appTheme(),
      //theme: lightTheme,
      // themeMode: ThemeMode.system,
      // darkTheme: darkTheme,
    );
  }
}

