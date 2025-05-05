import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/Resources/user.dart';

class ProfilePage extends ConsumerStatefulWidget {

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: [
          // Profile public Info display
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: screenWidth *.9,
              height: screenHeight *.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/cat.jpg'),
                    minRadius: 50,
                    maxRadius: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display Name
                      Text.rich(
                        TextSpan(
                          children: <TextSpan> [
                            TextSpan(text: "Display Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: user.name),
                          ],
                        ),
                      ),
                      // Email
                      Text(
                        user.email,
                        style: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      // User Description
                      Text(user.description ?? ""),
                    ],
                  )
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}