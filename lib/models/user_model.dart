class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? uid;
  String? createdAt;

  UserModel(
      {this.email, this.firstName, this.lastName, this.uid, this.createdAt});

  UserModel copyWith(
      {String? email, String? firstName, String? lastName, String? uid, String? createdAt}) =>
      UserModel(email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          uid: uid ?? this.uid,
          createdAt: createdAt ?? this.createdAt);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["email"] = email;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["uid"] = uid;
    map["createdAt"] = createdAt;
    return map;
  }

  UserModel.fromJson(dynamic json){
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    uid = json["uid"];
    createdAt = json["createdAt"];
  }
}