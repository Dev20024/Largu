import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Resources/posts.dart';


class PostCreatorPage extends StatefulWidget {
  @override
  
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fundsRequestedController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Center(
      // Post Creation UI

    );

    
  }

  Future<PostUI> getExamplePost(BuildContext context) async {
    try {
    print("first post function fired");
    final file = await rootBundle.loadString('assets/response.json');
    print("json filed fetched");
    Map<String, dynamic> jsonMap = jsonDecode(file)["Posts"][0];
    print(jsonMap);
    Post firstPost = Post.fromJson(jsonMap);
    print("WHY DONT U EXECUTE");
    return firstPost.toUI();
    } catch (e, stracktrace) {
      print("Error Occured: $e");
      print("Stracktrace: $stracktrace");
      throw e;
    }

  }
}