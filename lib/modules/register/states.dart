abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final String uId;
  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends RegisterStates{}

class RegisterCreateUserSuccessState extends RegisterStates{}

class RegisterCreateUserErrorState extends RegisterStates{
  final String error;
  RegisterCreateUserErrorState(this.error);
}