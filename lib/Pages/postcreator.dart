import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/Posts.dart';


class PostCreatorPage extends StatefulWidget {
  @override
  
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  
  @override
  Widget build(BuildContext context) {
    getPost(context);
    return Center(
      child: PostUI(id: generateTimeStampId(), postText: "Hello", fundsRequested: 100),
    );

    
  }

  void getPost(BuildContext context) async {
    final file = await rootBundle.loadString('assets/response.json');
    final json = jsonDecode(file);

    print(json);
  }
}