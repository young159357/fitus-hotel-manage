// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
    UserProfile({
        required this.username,
        required this.name,
        required this.phone,
        required this.email,
        required this.gender,
        required this.password,
        required this.birthday,
        required this.address,
    });

    String username;
    String name;
    String phone;
    String email;
    String gender;
    String password;
    String birthday;
    String address;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        username: json["Username"],
        name: json["Name"],
        phone: json["Phone"],
        email: json["Email"],
        gender: json["Gender"],
        password: json["Password"],
        birthday: json["Birthday"],
        address: json["Address"],
    );

    Map<String, dynamic> toJson() => {
        "Username": username,
        "Name": name,
        "Phone": phone,
        "Email": email,
        "Gender": gender,
        "Password": password,
        "Birthday": birthday,
        "Address": address,
    };
}
