import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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