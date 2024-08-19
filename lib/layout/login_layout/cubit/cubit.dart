import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/chief_layout/chief_layout.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/layout/user_layout/user_layout.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

String? uId;

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  userLogin({
   required context,
   required key,
   required emailController,
   required passwordController,
}){
   if(key.currentState!.validate()){
     emit(LoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailController,
         password: passwordController,
     ).then((value) async {
       uId = value.user!.uid;
       UserData userDataFetcher = UserData();
       await userDataFetcher.fetchAndPrintUserData();

       ///if login success .. navigate to user layout
       if(UserData.data!['position'] != 'قائد'){
         navigateAndFinish(context, UserLayout());
       } else {
         navigateAndFinish(context, ChiefLayout());
       }


       emit(LoginSuccessState(value.user!.uid));
     }).catchError((error){
       emit(LoginErrorState(error.toString()));
     });
   }else{
     emit(LoginErrorInputState());
   }
 }


  bool isPasswordNotVisible = true;
  passwordVisibality() {
    if (isPasswordNotVisible) {
      isPasswordNotVisible = false;
      emit(PasswordVisibleState());
    } else {
      isPasswordNotVisible = true;
      emit(PasswordNotVisibleState());
    }
  }
}