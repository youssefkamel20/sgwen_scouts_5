import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/modules/score/states.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

class ScoreCubit extends Cubit<ScoreStates> {
  ScoreCubit() : super(ScoreInitialState());

  static ScoreCubit get(context) => BlocProvider.of(context);

  int? teamScore;
  List<WidgetItem>? items;
  Future<int?> getTeamScore() async {
    emit(ScoreLoadingState());

    DocumentSnapshot teamSnapshot = await FirebaseFirestore.instance
        .collection('Score')
        .doc('${UserData.data!['teamName']}')
        .get();

    if (teamSnapshot.exists) {
      // Assuming 'selectedValue' is a string field
      teamScore = teamSnapshot.get('score');
      CacheHelper.saveData(key: 'teamScore', value: teamScore);
      print('Team score is : $teamScore');
      emit(ScoreSuccessState(teamScore));
      return teamScore;
    } else {
      print('Document does not exist');
      emit(ScoreErrorState());
      return null;
    }
  }

  int? lionScore;
  int? wolfScore;
  int? pantherScore;
  int? tigerScore;
  getAllTeamsScore() async {
    DocumentSnapshot lionSnapshot = await FirebaseFirestore.instance.collection('Score').doc('الأسد').get();
    DocumentSnapshot wolfSnapshot = await FirebaseFirestore.instance.collection('Score').doc('الذئب').get();
    DocumentSnapshot pantherSnapshot = await FirebaseFirestore.instance.collection('Score').doc('الفهد').get();
    DocumentSnapshot tigerSnapshot = await FirebaseFirestore.instance.collection('Score').doc('النمر').get();
    lionScore = lionSnapshot.get('score');
    wolfScore = wolfSnapshot.get('score');
    pantherScore = pantherSnapshot.get('score');
    tigerScore = tigerSnapshot.get('score');

    items = [
      WidgetItem(widget: lionResult(), value: lionScore),
      WidgetItem(widget: wolfResult(), value: wolfScore),
      WidgetItem(widget: pantherResult(), value: pantherScore),
      WidgetItem(widget: tigerResult(), value: tigerScore),
    ];
    items!.sort((b, a) => a.value!.compareTo(b.value as num));

    emit(ScoreTeamsUpdateState(items));
    items!.forEach((item){
      item.widget;
    });
  }

  var teamNameValue;
  int? scoreToDatabase;
  var plusController = TextEditingController();
  var minusController = TextEditingController();
  int? scoreEdit (){
    if (plusController == null){
      scoreToDatabase = int.tryParse(minusController.text);
    } else {
      scoreToDatabase = int.tryParse(plusController.text);
    };
    return scoreToDatabase;
  }
  Map<String, dynamic> sendEditToDatabase(){
    return {
      'score' : plusController ,
    };
  }
  List<String> teamName = [
    'الأسد',
    'الذئب',
    'الفهد',
    'النمر',
  ];
  editTeamScore(value){
    teamNameValue = value;
  }

}

class WidgetItem{
  final Widget widget;
  final int? value;
  WidgetItem({required this.widget, required this.value});
}