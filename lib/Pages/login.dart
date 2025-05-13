import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/Pages/current.dart';
import 'package:namer_app/Pages/signup.dart';
import 'package:namer_app/Resources/user.dart';

class LoginPage extends ConsumerStatefulWidget {
  
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final userStorage = UserStorage();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  Future<void> _loginButtonPressed() async {
    String email = _userNameController.text.trim();
    String passWord = _passWordController.text.trim();

    bool valid = true;
    String errorMessage = " ";

    if (email.isEmpty || passWord.isEmpty ) {
      valid = false;
      errorMessage = "Please fill in your username and/or password!";
    }

    if (!valid) {
      showDialog(
        context: context,
        builder:(BuildContext context) {
          return AlertDialog(
            title: Text("Alert!"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {Navigator.of(context).pop();}, 
                child: Text("Ok!")
              )
            ],
          );
        },
      );
      return;
    }
    else {
      Map<String, dynamic> userDataBase = await userStorage.loadJsonFromLocal();
      final usersList = userDataBase["Users"] as List<dynamic>;
      final userMap = {
        for (var user in usersList) user['email']: user,
      };

      if (!userMap.containsKey(email)) {return;}
      final user = userMap[email];
      if (user['password'] != passWord) {return;}
      ref.read(userProvider.notifier).login(user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CurrentPage()));
    }
  }  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, // prevents UI from being overlapped by the keyboard
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign In", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(5.0),
                width: screenWidth * .8,
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 700,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(101, 0, 0, 0),
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Username input field
                    TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your username",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Password input field
                    TextField(
                      controller: _passWordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    // Sign in button
                    ElevatedButton(
                      onPressed: _loginButtonPressed,
                      style: ElevatedButton.styleFrom(
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text("Login"),
                      ),
                    SizedBox(height: 16.0),
                    // Sign up button
                    Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14.0),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}