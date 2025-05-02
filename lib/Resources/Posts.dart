import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'posts.g.dart';


// Flutter object that represents a Post
@JsonSerializable(explicitToJson: true)
class Post {
  final String id;
  final String name;
  final String description;
  final int fundsRequested;
  final int fundsReceived;

  Post({
    required this.id,
    required this.name,
    required this.description,
    required this.fundsRequested,
    required this.fundsReceived,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);  
  
  PostUI toUI() {
    return PostUI(postData: this,);
  }

}

// A post UI element to encapsulate and represent all post data
class PostUI extends StatefulWidget {
  final Post postData;
  PostUI({
    required this.postData,
  });
  @override
  _PostUIState createState() => _PostUIState();
}

class _PostUIState extends State<PostUI> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColorLight
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Post title & Author
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.postData.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            // Post description
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.postData.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
            ),
            ),
            // Funds Recieved/Requested and Donate Button.
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "\$${widget.postData.fundsRequested.toString()}/${widget.postData.fundsReceived.toString()}", style: TextStyle(fontSize: 20)),
                        TextSpan(text: " Funds Raised.", style: TextStyle(fontSize: 20)),
                      ]
                    ),
                  ),
                  ElevatedButton(
                  onPressed: () {} ,
                  child: Text("Donate?"),
                ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class PostStorage {
  // load JSON from assets (defualt data)
  Future<Map<String,dynamic>> loadDefaultJson() async {
    final file = await rootBundle.loadString('assets/postDataBase.json');
    return jsonDecode(file);
  }

  // Save updated JSON to local storage
  Future<void> saveJsonToLocal(Map<String,dynamic> json) async {
    // application storage directory
    final directory = await getApplicationDocumentsDirectory();
    final filepath = '${directory.path}/Coding/AppDev/test_app/clientDataStore/postDataBase.json';

    // Create a JsonEncoder with the indentation for pretty-printing
    final encoder = JsonEncoder.withIndent("  ");
    final formattedJson = encoder.convert(json);
    
    // Write JSON to the file
    final file = File(filepath);
    await file.writeAsString(formattedJson);
    print("JSON saved to $filepath");
  }

  // Load JSON from local storage
  Future<Map<String, dynamic>> loadJsonFromLocal() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/Coding/AppDev/test_app/clientDataStore/postDataBase.json';

    final file = File(filePath);

    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents);
    }
    else {
      print("Local JSON not found. Using initial data.");
      return await loadDefaultJson();
    }
  }

  Future<void> addPost(Post newPost) async {
    final json = await loadJsonFromLocal();
    (json["Posts"] as List).add(newPost.toJson());
    await saveJsonToLocal(json);
  }
}