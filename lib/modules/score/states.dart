abstract class ScoreStates{}

class ScoreInitialState extends ScoreStates {}

class ScoreLoadingState extends ScoreStates {}

class ScoreSuccessState extends ScoreStates {
  final score;
  ScoreSuccessState(this.score);
}

class ScoreErrorState extends ScoreStates {}

class ScoreTeamsUpdateState extends ScoreStates{
  final items;
  ScoreTeamsUpdateState(this.items);
}

class ScoreChiefUpdateState extends ScoreStates{}


