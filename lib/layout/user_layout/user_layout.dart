import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/layout/user_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/user_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/shared/constants/colors.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

class UserLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserData(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            UserCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {
          var cubit = UserCubit.get(context);


          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 70,
              shadowColor: Colors.black,
              elevation: 8,
              title:  Text('أهلا يا ${UserData.data!['name']}',
                textDirection: TextDirection.rtl,),
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
            ),
            backgroundColor: userColor(),
            body: cubit.screens[cubit.screenIndex],
            bottomNavigationBar: SalomonBottomBar(
                onTap: (index){
                  cubit.currentScreen(index);
                },
                backgroundColor: Colors.grey,
                selectedItemColor: Colors.purple[800],
                curve: Curves.ease,
                currentIndex: cubit.screenIndex,
                items: [
                  SalomonBottomBarItem(
                    icon: Icon(Icons.flag),
                    title: Text('التنبيهات'),
                  ),
                  SalomonBottomBarItem(
                    icon: ImageIcon(AssetImage('images/score.png'), size: 40,),
                    title: Text('النتيجة'),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.question_mark),
                    title: Text('الأسئلة'),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.person),
                    title: Text('الحساب'),
                  ),
                ]
            ),
          );
        },
      ),
    );
  }
}
