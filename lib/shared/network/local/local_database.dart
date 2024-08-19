import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgwen_scouts_5/layout/login_layout/cubit/cubit.dart';


class UserData {


  static UserData userDataFetcher = UserData();
  static Map<String, dynamic>? data;

  // Method to fetch and print user data
  Future<void> fetchAndPrintUserData() async {
    print('fetching database at $uId');
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('${uId}')
          .get();

      if (snapshot.exists) {
        // Print the entire document data
        data = snapshot.data() as Map<String, dynamic>?;
        print('User Data: ${data}');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}

