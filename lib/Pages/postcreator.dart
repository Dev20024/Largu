import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/posts.dart';


class PostCreatorPage extends StatefulWidget {
  @override
  
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {

  final postStorage = PostStorage();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fundsRequestedController = TextEditingController();

  void createPost() {
    // User input controllers.
    String name = _nameController.text;
    String description = _descriptionController.text;
    String fundsRequested = _fundsRequestedController.text;
    // variable verification
    int? fundsRequestedNumeric = int.tryParse(fundsRequested);
    print(fundsRequested);
    print(fundsRequestedNumeric);
    bool valid = true;
    String errorMessage = "";

    // Check if all fields are filled.
    if (name.isEmpty || description.isEmpty || fundsRequested.isEmpty) {
      valid = false;
      errorMessage = "Make sure all Text Fields are filled out!";
    }
    // Check if dollar amount is Valid.
    else if (fundsRequestedNumeric == null ||  (fundsRequestedNumeric < 0) || (fundsRequestedNumeric > 10000) ) {
      valid = false;
      errorMessage = "Invalid Dollar amount!";
    }
    
    // If the form is not valid, display the proper error message.
    if (!valid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        )
      );
      return;
    }

    // create the post and add it to storage.
    Post newUserPost = Post(
      id: generateTimeStampId(),
      name: _nameController.text,
      description: _descriptionController.text,
      fundsRequested:  int.parse(_fundsRequestedController.text),
      fundsReceived: 0,
    );

    postStorage.addPost(newUserPost);
    // Display post creation success message.
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Alert"),
        content: Text("Post Successfully Created!"),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _fundsRequestedController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      // Post Creation UI
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Container(
          width: screenWidth *.9,
          height: screenHeight *.6,
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxWidth: 600, // maximum width for larger screens
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Post Tile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter the post title",
                border: OutlineInputBorder(),
              ),            
            ),
            SizedBox(height: 8,),
            Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write a description...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8,),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Funds Requested:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(width: 10),
                  Text("\$"),
                  Expanded(child: TextField(
                    controller: _fundsRequestedController,
                    keyboardType:  TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "How much money do you need?",
                      border: OutlineInputBorder(),
                      ),
                    )
                  )
                ],
              )
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: createPost,
                child: Text("Create Post"),
              )
            )
          ],
        ),
        )
        //color: Colors.blue,
        
      )
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
      rethrow;
    }

  }
}