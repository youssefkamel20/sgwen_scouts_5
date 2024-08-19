import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/user_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/models/user_model.dart';
import 'package:sgwen_scouts_5/modules/announcements/movies_screen.dart';
import 'package:sgwen_scouts_5/modules/profile/profile_screen.dart';
import 'package:sgwen_scouts_5/modules/questions/questions_screen.dart';
import 'package:sgwen_scouts_5/modules/score/score_screen.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';


class UserCubit extends Cubit<UserStates>{
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  getUserData() async{
    UserData userDataFetcher = UserData();
    await userDataFetcher.fetchAndPrintUserData();
  }
  // userFetcher() async{
  // UserData userDataFetcher = UserData();
  // await userDataFetcher.fetchAndPrintUserData();}
///da nta lessa m3adlo shilo w esht8al login bas
//   void getUserData()async {
//     emit(UserLoadingState());
//
//
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc('$uId')
//         .get()
//         .then((value) {
//           print(value.toString());
//           UserModel model = UserModel.fromJson(value.data() as Map);
//           print(model);
//           emit(UserSuccessState());
//     })
//         .catchError((error) {
//           print(error.toString());
//           emit(UserErrorState(error.toString()));
//     });
//   }


  int screenIndex = 1;
  List<Widget> screens =[
    MoviesScreen(),
    ScoreScreen(),
    QuestionsScreen(),
    ProfileScreen(),
  ];
  void currentScreen(index){
    screenIndex = index ;
    screens[index];
    emit(UserChangeScreenState());
  }





}