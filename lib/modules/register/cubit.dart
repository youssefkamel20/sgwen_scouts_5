import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/models/user_model.dart';
import 'package:sgwen_scouts_5/modules/register/states.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

import '../../layout/user_layout/user_layout.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required context,
    required String name,
    required String fatherName,
    required String email,
    required String password,
    required String phone,
    required String teamName,
    required String position,
    String? uId,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      uId = value.user!.uid;
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      print(value.user!.email);
      print('what you are looking for is: $uId');
      createUser(
        name: name,
        fatherName: fatherName,
        email: email,
        phone: phone,
        teamName: teamName,
        position: position,
        uId: value.user!.uid,
      );
      print('(*&^%#@the registered uid is: $uId');
      UserData userDataFetcher = UserData();
      await userDataFetcher.fetchAndPrintUserData();

      ///if login success .. navigate to user layout
      // navigateAndFinish(context, UserLayout());
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState());
      print(error.toString());
    });
  }

  void createUser({
    required String name,
    required String fatherName,
    required String email,
    required String phone,
    required String teamName,
    required String position,
    required String uId,
  }) {
    var model = UserModel(
        name: name,
        fatherName: fatherName,
        email: email,
        phone: phone,
        teamName: teamName,
        position: position,
        uId: uId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJason())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
      print(error);
    });
  }
}
