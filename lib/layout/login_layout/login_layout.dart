import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/states.dart';
import 'package:sgwen_scouts_5/layout/user_layout/user_layout.dart';
import 'package:sgwen_scouts_5/modules/register/register_screen.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/constants/constants.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';


class LoginLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState){
              showToast(
                  text: state.error,
                  state: ToastStates.ERROR,
              );
            }
            if(state is LoginSuccessState){
              uId = state.uId;
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId
              ).then((value){
                print('uId is saved and it is ${state.uId}');
              });
            }
          },
          builder: (context, state) {

            LoginCubit cubit = LoginCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.grey,
              appBar: AppBar(
                backgroundColor: Colors.grey,
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 15,
                    right: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('الفرقة الخامسة',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('قم بتسجيل الحساب',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 60,
                                ),

                                //Email TextFormField
                                TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'متسيبش ده فاضى !!';
                                    } else if (!value.toString().contains('@') || !value.toString().contains('.'))
                                    {
                                      return 'اكتبه عدل بقى !!!!!!!';
                                    }
                                    return null;
                                    },
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'الحساب',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIconColor: Colors.orangeAccent,
                                    prefixIcon: Icon(Icons.alternate_email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),

                                //Password TexFormField
                                TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'password must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: cubit.isPasswordNotVisible,
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'كلمة المرور',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                    prefixIconColor: Colors.orangeAccent,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        cubit.passwordVisibality();
                                      },
                                      icon: Icon(Icons.remove_red_eye,
                                        color: Colors.orangeAccent,),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  height: 80,
                                ),
                                ConditionalBuilder(
                                    condition: state is !LoginLoadingState,
                                    builder: (context) => Container(
                                      decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                      child: TextButton(
                                        onPressed: (){
                                          cubit.userLogin(
                                            context: context,
                                            key: formKey,
                                            emailController: emailController.text,
                                            passwordController: passwordController.text,
                                          );
                                        },
                                        child: Text('تسجيل الدخول',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),),
                                      ),
                                    ),
                                    fallback: (context) => CircularProgressIndicator(),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                      },
                                      child: Text('سجل دلوقتى',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orangeAccent,
                                        ),),
                                    ),
                                    Text('معندكش حساب ؟؟',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Bottom Ribbons
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              child: Image(
                                image: AssetImage('images/lion.png',),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.yellow[700],
                              ),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              child: Image(
                                image: AssetImage('images/wolf.png',),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.red[700],
                              ),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 80,
                              child: Image(
                                image: AssetImage('images/panther.png',),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.purple,
                              ),

                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              child: Image(
                                image: AssetImage('images/tiger.png',),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.blue[700],
                              ),

                            ),
                          ),
                        ],
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
