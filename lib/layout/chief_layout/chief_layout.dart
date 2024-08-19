import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/chief_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/chief_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/modules/score/cubit.dart';
import 'package:sgwen_scouts_5/modules/score/states.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';

class ChiefLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCubit()..getAllTeamsScore(),
      child: BlocConsumer<ScoreCubit, ScoreStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = ScoreCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
            ),
            backgroundColor: Colors.orangeAccent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    //نتائج الطلائع
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black54,
                            width: 2,
                          )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('نتائج الطلائع',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ghayti',
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          BlocBuilder<ScoreCubit, ScoreStates>(
                            builder: (context, state) {
                              if (state is ScoreTeamsUpdateState) {
                                List<WidgetItem>? items = state.items;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: items!.map((item) => item.widget).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: items.map((item) => customScore(item.value)).toList(),
                                    ),
                                  ],
                                );
                              }
                              return CircularProgressIndicator(); // or some other loading indicator
                            },
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),
                    //عدل النتيجة
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black54,
                            width: 2,
                          )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //choose team
                          Container(
                            width: 170,
                            child: defaultDropdownList(
                                validationMessage: 'لازم تختار الطليعة',
                                hintMessage: 'الطليعة',
                                value: cubit.teamNameValue,
                                items: cubit.teamName.map((String items){
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (value){
                                  cubit.editTeamScore(value);
                                }),
                          ),
                          SizedBox(height: 15,),
                          //plus or minus
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: cubit.plusController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      labelText: 'زود',
                                      labelStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: cubit.plusController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      labelText: 'اخصم',
                                      labelStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          //frequent modification
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              frequentModificationButton(
                                onPressed: (){},
                                textLabel: '-5',
                              ),
                              frequentModificationButton(
                                onPressed: (){},
                                textLabel: '-2',
                              ),
                              frequentModificationButton(
                                onPressed: (){},
                                textLabel: '+2',
                              ),
                              frequentModificationButton(
                                onPressed: (){},
                                textLabel: '+5',
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          //submit and update result
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  print('your score to database is: ${cubit.scoreToDatabase}');
                                },
                                child: Text('Submit',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
