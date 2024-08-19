abstract class UserStates{}

class UserInitialState extends UserStates{}

class UserLoadingState extends UserStates{}

class UserSuccessState extends UserStates{}

class UserErrorState extends UserStates{
  final String error;
  UserErrorState(this.error);
}

class UserChangeScreenState extends UserStates{}
