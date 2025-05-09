
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:path_provider/path_provider.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String id;
  String displayName;
  String email;
  String passWord;
  String? description;
  String? profilePicture; 
  String dob;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.passWord,
    required this.dob,
    this.description,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


// A state notifier to manage the user state.
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void login(User user) {
    state = user;
  }

  void logout() {
    state = null;
  }
}

// provide's user information to the local application
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

User guest = User(
  id: generateTimeStampId(),
  displayName: "Bob Hendricks",
  email: "BobHendricks3000@gmail.com",
  passWord: "1234",
  dob: "09/20/1989",
);


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

class UserStorage {
  Future<Map<String, dynamic>> loadDefaultData() async {
    final file = await rootBundle.loadString('assets/userDataBase.json');
    return jsonDecode(file);
  }

  Future<Map<String, dynamic>> loadJsonFromLocal() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/Coding/AppDev/test_app/clientDataStore/userDataBase.json';

    final file = File(filePath);

    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents);
    }
    else {
      print("No local data to load from, returning default data!");
      return loadDefaultData();
    }
  }

  Future<void> saveJsonToLocal(Map<String,dynamic> json) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/Coding/AppDev/test_app/clientDataStore/userDataBase.json';

    final file = File(filePath);

    final encoder = JsonEncoder.withIndent("  ");
    final formattedJson = encoder.convert(json);

    await file.writeAsString(formattedJson);
  }

  Future<void> addUser(User newUser) async {
    final json = await loadJsonFromLocal();
    (json["Users"] as List).add(newUser.toJson());
    await saveJsonToLocal(json);
  }

}


