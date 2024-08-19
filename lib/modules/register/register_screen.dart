import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/login_layout/login_layout.dart';
import 'package:sgwen_scouts_5/layout/user_layout/user_layout.dart';
import 'package:sgwen_scouts_5/modules/register/cubit.dart';
import 'package:sgwen_scouts_5/modules/register/states.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/constants/constants.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();
  var secondNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var teamName;
  var postion;
  bool isPasswordHidden = true;
  int? numbers;
  var dropteamNameItems =[
    'الأسد',
    'الذئب',
    'الفهد',
    'النمر',
  ];
  var dropPositionItems =[
    'عريف',
    'مساعد عريف',
    'فرد تالت',
    'فرد',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            uId = state.uId;
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value){
              print('uId is saved and it is ${state.uId}');
              navigateAndFinish(context, LoginLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.grey,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('أدخل بياناتك',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('تأكد من إدخال بياناتك بشكل صحيح',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'لازم تكتب اسمك';
                                        } else if (value.toString().contains('@')){
                                          return 'اكتب اسمك كويس';
                                        }
                                      },
                                      maxCharacters: 10,
                                      labelText: 'اسمك',
                                      controller: firstNameController,
                                      type: TextInputType.text,
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: defaultFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'لازم تكتب اسمك';
                                        } else if (value.toString().contains('@')){
                                          return 'اكتب اسمك كويس';
                                        }
                                      },
                                      maxCharacters: 10,
                                      labelText: 'اسم الوالد',
                                      controller: secondNameController,
                                      type: TextInputType.text,
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            defaultFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'متسيبش ده فاضى !!';
                                } else if (!value.toString().contains('@') || !value.toString().contains('.'))
                                {
                                  return 'اكتبه عدل بقى !!!!!!!';
                                }
                              },
                              labelText: 'الحساب',
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefixIcon: Icon(Icons.alternate_email),
                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'لازم تكتب كلمة المرور';
                                }
                              },
                              labelText: 'كلمة المرور',
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              passwordHidden: isPasswordHidden,
                              prefixIcon: Icon(Icons.lock),
                              suffix: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                icon: isPasswordHidden? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                              ),
                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              validator: (value){
                                if(value.isEmpty){
                                  return 'لازم تكتب رقمك';
                                } else if (value.length < 11){
                                  return 'راجع رقمك تانى';
                                }
                              },
                              labelText: 'رقم الهاتف',
                              controller: phoneController,
                              type: TextInputType.number,
                              prefixIcon: Icon(Icons.dialpad),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  child: defaultDropdownList(
                                      validationMessage: 'لازم تختار طليعتك',
                                      hintMessage: 'اختار طليعتك',
                                      value: teamName,
                                      items:
                                          dropteamNameItems.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          teamName = value;
                                        });
                                      }),
                                ),
                                Spacer(),
                                Container(
                                  width: 160,
                                  child: DropdownButtonFormField<String>(
                                    validator: (value){
                                      if (value == null){
                                        return 'انت اييييييه؟';
                                      }
                                      return null;
                                    },
                                    hint: Text('منصبك القيادى',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    value: postion,
                                    items: dropPositionItems.map((String items){
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      setState(() {
                                        postion = value;
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    dropdownColor: Colors.grey[700],
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            ConditionalBuilder(
                              condition: state is !RegisterLoadingState,
                              builder: (context) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    if(formKey.currentState!.validate()){
                                      RegisterCubit.get(context).userRegister(
                                        context: context,
                                          name: firstNameController.text,
                                          fatherName: secondNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          position: postion.toString(),
                                          teamName: teamName.toString());
                                    }
                                  },
                                  child: Text('سجل الأن',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) => CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
