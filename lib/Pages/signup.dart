
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/user.dart';

class SignupPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
   final userStorage = UserStorage();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  Future<void> createAccountButtonPressed() async {
    final email = _emailController.text.trim();
    final passWord = _passwordController.text.trim();
    final displayName = _displayNameController.text.trim();
    final dob = _dateOfBirthController.text.trim();

    bool isVaid = true;
    String errorMessage = "";

    if (email.isEmpty || passWord.isEmpty || displayName.isEmpty || dob.isEmpty) {isVaid=false; errorMessage="Please fill out all information!";}

    if (!isVaid) {
      showDialog(
        context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(errorMessage),
            actions: [
              TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Ok"))
            ],
          );
        }
      );
    }
    else {
      print("Creating Account!");
      User newUser = User(id: generateTimeStampId(), displayName: displayName, email: email, passWord: passWord, dob: dob);
      userStorage.addUser(newUser);
    }

  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
      ),
      body: Center(
        
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: screenWidth * .8,
            constraints: BoxConstraints(
              maxHeight: 600,
              maxWidth: 600,
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
                SizedBox(height: 15.0),
                // Email input
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text("Username"),
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 25.0),
                // Password input
                 TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hintText: "Create a password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 25.0),
                // DisplayName input
                 TextField(
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    label: Text("Display Name"),
                    hintText: "Create a display name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 25.0),
                // DOB input
                 TextField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    label: Text("Date Of Birth"),
                    hintText: "Enter your date of birth",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: createAccountButtonPressed, 
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text("Create Account"),
                  
                  ),
              ],

            ),
          )
        ),
    );
  }
}
