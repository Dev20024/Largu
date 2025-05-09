
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/Pages/current.dart';
import 'package:namer_app/Pages/login.dart';
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
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', token);
}

Future<bool> isUserAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('authToken');
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken');
}