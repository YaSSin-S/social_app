class UsersModel {
  late String name;
  late String email;
  late String phone;
  late String uID;
  late String cover;
  late String image;
  late String bio;
  // late bool isEmailVerified;

  UsersModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uID,
    required this.cover,
    required this.image,
    required this.bio,
    // required this.isEmailVerified,
  });

  UsersModel.fromJson(json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uID = json['uId'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    // isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uID,
      'cover': cover,
      'image': image,
      'bio': bio,
      // 'isEmailVerified': isEmailVerified,
    };
  }
}


// class SocialUserModel {
//   late String name;
//   late String email;
//   late String phone;
//   late String uId;
//   late String image;
//   late String cover;
//   late String bio;
//   late bool isEmailVerified;
//
//   SocialUserModel({
//     required this.email,
//     required this.name,
//     required this.phone,
//     required this.uId,
//     required this.image,
//     required this.cover,
//     required this.bio,
//     required this.isEmailVerified,
//   });
//
//   SocialUserModel.fromJson(Map<String, dynamic> json)
//   {
//     email = json['email'];
//     name = json['name'];
//     phone = json['phone'];
//     uId = json['uId'];
//     image = json['image'];
//     cover = json['cover'];
//     bio = json['bio'];
//     isEmailVerified = json['isEmailVerified'];
//   }
//
//   Map<String, dynamic> toMap()
//   {
//     return {
//       'name':name,
//       'email':email,
//       'phone':phone,
//       'uId':uId,
//       'image':image,
//       'cover':cover,
//       'bio':bio,
//       'isEmailVerified':isEmailVerified,
//     };
//   }
// }