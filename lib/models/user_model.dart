

class UserModel {
  String? name;
  String? fatherName;
  String? email;
  String? phone;
  String? teamName;
  String? position;
  String? uId;

  UserModel({
    required this.name,
    required this.fatherName,
    required this.email,
    required this.phone,
    required this.teamName,
    required this.position,
    this.uId,
  });

  UserModel.fromJson(Map jason) {
    email = jason['email'];
    name = jason['name'];
    fatherName = jason['fatherName'];
    phone = jason['phone'];
    teamName = jason['teamName'];
    position = jason['position'];
    uId = jason['uId'];
  }

  Map<String, dynamic> toJason() {
    return {
      'name': name,
      'fatherName': fatherName,
      'email': email,
      'phone': phone,
      'teamName': teamName,
      'position': position,
      'uId': uId
    };
  }
}

