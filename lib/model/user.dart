import 'package:knm_masjid_app/enum/role.dart';
import 'package:knm_masjid_app/model/majid.dart';

class UserModel {
  String? userID;
  String? photoURL;
  String? phoneNumber;
  String? name;
  String? email;
  String? password;
  UserRoleLocal? role;
  Masjid? masjid;

  UserModel(
      {this.name, this.email, this.password, this.role = UserRoleLocal.MASJID, this.userID, this.photoURL, this.phoneNumber, this.masjid});
  
  UserModel.fromJson(Map<String, dynamic> json) {
      UserModel(
          name: json['name'],
          email: json['email'],
          password: json['password'],
          role: json['role'] == 'admin' ? UserRoleLocal.ADMIN : UserRoleLocal.MASJID,
          userID: json['user_id'],
          photoURL: json['photoURL'],
          phoneNumber: json['phoneNumber'],
          masjid: Masjid.fromJson(json['masjid']));
    }
  

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role == UserRoleLocal.ADMIN ? 'admin' : 'masjid',
      'user_id': userID,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'masjid': masjid?.toJson(),
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, role: $role, user_id: $userID, photoURL: $photoURL, phoneNumber: $phoneNumber}';
  }
}
