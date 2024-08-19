import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/chief_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';

class ChiefCubit extends Cubit<ChiefStates>{
  ChiefCubit() : super(ChiefInitialState());

  static ChiefCubit get(context) => BlocProvider.of(context);

  static List<WidgetsItem>? items;

}

class WidgetsItem{
  final Widget widget;
  final value;
  WidgetsItem({required this.widget, required this.value});
}