import 'package:flutter/material.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/layout/login_layout/login_layout.dart';
import 'package:sgwen_scouts_5/layout/user_layout/cubit/cubit.dart';
import 'package:sgwen_scouts_5/shared/components/class_components.dart';
import 'package:sgwen_scouts_5/shared/components/components.dart';
import 'package:sgwen_scouts_5/shared/constants/constants.dart';
import 'package:sgwen_scouts_5/shared/network/local/cache_helper.dart';
import 'package:sgwen_scouts_5/shared/network/local/local_database.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //User Data & LogOut button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[600]!.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ///بيانات الكشاف
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'بيانات الكشاف',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ghayti',
                        ),
                      ),
                    ),

                    //scout name
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          //first is for parameter
                          Expanded(
                            child: Text(
                              '${UserData.data!['name']} ${UserData.data!['fatherName']}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                          //second is for value
                          Expanded(
                            child: Text(
                              'اسم الكشاف',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //scout email
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          //first is for value
                          Expanded(
                            child: Text(
                              '${UserData.data!['email']}',
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 17,
                                // overflow: TextOverflow.ellipsis,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                          //second is for parameter
                          Expanded(
                            child: Text(
                              'الحساب الشخصى',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //scout phone
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          //first is for value
                          Expanded(
                            child: Text(
                              '${UserData.data!['phone']}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                          //second is for parameter
                          Expanded(
                            child: Text(
                              'رقم الهاتف',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //scout position
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          //first is for value
                          Expanded(
                            child: Text(
                              '${UserData.data!['position']}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                          //second is for parameter
                          Expanded(
                            child: Text(
                              'المنصب القيادى',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sabah',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    //LogOut button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(40)),
                        child: TextButton(
                            onPressed: () async {
                              uId = null;
                              await CacheHelper.removeData(key: 'uId')
                                  .then((value) {
                                print('user logged out and cached uid is ${CacheHelper.getData(key: 'uId')}');
                                print('but the uId variable is $uId');
                                navigateAndFinish(context, LoginLayout());
                              });
                            },
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //User Badges
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ///شارات الكشاف
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'الشارات',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ghayti',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
