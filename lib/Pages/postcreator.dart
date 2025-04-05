import 'package:flutter/material.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/Posts.dart';


class PostCreatorPage extends StatefulWidget {
  @override
  
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Post(id: generateTimeStampId(), postText: "Hello", fundsRequested: 100),
    );
  }
}