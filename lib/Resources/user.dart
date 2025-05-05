
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/Resources/Ids.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String id;
  String name;
  String email;
  String? description;
  String? profilePicture; 
  String dob;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    this.description,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// provide's user information to the local application
final userStateProvider = StateProvider<User>((ref) {
  return User(
    id: generateTimeStampId(),
    name: 'John Doe',
    email: 'JohnDoe@gmail.com',
    dob: '07/20/2001',
    description: "I like tacos and bad puns",
  );
});

Widget buildProfilePicture(User user) {
  return GestureDetector(
    onTap: () {},
    child: CircleAvatar(
    backgroundImage: user.profilePicture != null
    ? FileImage(File(user.profilePicture!))
    : AssetImage('assets/cat.jpg')
  ),
  );
   
}

Future<void> uploadProfilePicture(User user) async {
  
}


