
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/Pages/current.dart';
import 'package:namer_app/Pages/login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthChecker extends ConsumerStatefulWidget {

  @override 
  ConsumerState<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends ConsumerState<AuthChecker> {
  Future<bool> userAuthenticated = isUserAuthenticated();

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isAuthenticated = await isUserAuthenticated();
    if (isAuthenticated) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => CurrentPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  } 
}

Future<void> saveAuthToken(String token) async {
  
}

Future<bool> isUserAuthenticated() async {
  

}

Future<void> logout() async {
  
}

Future<Map<String, dynamic>> fetchUserData() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/userData.json';
  final file = File(path);

  if (await file.exists()) {
    final content = await file.readAsString();
    return jsonDecode(content);
  }
  else {
    
  }
}