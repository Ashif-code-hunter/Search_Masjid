import 'package:knm_masjid_app/enum/role.dart';

class UserModel {
  String? userID;
  String? photoURL;
  String? phoneNumber;
  String? name;
  String? email;
  String? password;
  UserRole? role;

  UserModel(
      {this.name, this.email, this.password, this.role = UserRole.MASJID, this.userID, this.photoURL, this.phoneNumber});
  
  UserModel.fromJson(Map<String, dynamic> json) {
    UserModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role'] == 'admin' ? UserRole.ADMIN : UserRole.MASJID);
        userID = json['user_id'];
        photoURL = json['photoURL'];
        phoneNumber = json['phoneNumber'];
  }

  

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role == UserRole.ADMIN ? 'admin' : 'masjid',
      'user_id': userID,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, role: $role, user_id: $userID, photoURL: $photoURL, phoneNumber: $phoneNumber}';
  }
}
