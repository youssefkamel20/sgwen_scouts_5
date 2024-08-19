abstract class ChiefStates{}

class ChiefInitialState extends ChiefStates {}

class ChiefScoreLoadingState extends ChiefStates {}

class ChiefScoreSuccessState extends ChiefStates {
  final items;
  ChiefScoreSuccessState(this.items);
}



