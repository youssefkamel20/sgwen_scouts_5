import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sgwen_scouts_5/modules/score/cubit.dart';
import 'package:sgwen_scouts_5/modules/score/states.dart';
import 'package:sgwen_scouts_5/shared/components/class_components.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/constants/colors.dart';

class ScoreScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ScoreCubit()
        ..getTeamScore()
        ..getAllTeamsScore(),
      child: BlocConsumer<ScoreCubit, ScoreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ScoreCubit.get(context);
          int? teamScore = cubit.teamScore;


          return ConditionalBuilder(
              condition: state is !ScoreLoadingState,
              builder: (context) => CustomScaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: HexColor('#353535'), width: 2),
                              color: userTeamDarkColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ملايين الطليعة',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Ghayti',
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text('$teamScore Million',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            // width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[700]!.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              children: [
                                Text('ترتيب الطلائع',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Ghayti',
                                  ),
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          BlocBuilder<ScoreCubit, ScoreStates>(
                                            builder: (context, state) {
                                              if (state is ScoreTeamsUpdateState) {
                                                List<WidgetItem>? items = state.items;

                                                return Column(
                                                  children: items!.map((item) => item.widget).toList(),
                                                );
                                              }
                                              return CircularProgressIndicator(); // or some other loading indicator
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.green[900],
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.green[300],
                                            child: Text(
                                              '2',
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.yellow[300],
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.red[300],
                                            child: Text(
                                              '4',
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.blue, )),
          );
        },
      ),
    );
  }
}