
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  Future<void> createAccountButtonPressed() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final displayName = _displayNameController.text.trim();
    final dob = _dateOfBirthController.text.trim();

    if (email.isEmpty || password.isEmpty || displayName.isEmpty || dob.isEmpty) {}
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
        child: Flexible(
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
                  decoration: InputDecoration(
                    label: Text("Date Of Birth"),
                    hintText: "Enter your date of birth",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: () {}, 
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
      ),
    );
  }
}
