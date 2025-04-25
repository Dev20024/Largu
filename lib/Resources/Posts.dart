import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';



// Flutter object that represents a Post
@JsonSerializable(explicitToJson: true)
class Post {
  final String id;
  final String name;
  final String description;
  final int fundsRequested;
  final Float fundsRecieved;

  Post({
    required this.id,
    required this.name,
    required this.description,
    required this.fundsRequested,
    required this.fundsRecieved,
  });

  factory Post.fromjson(Map<String, dynamic> json) =>
    Post(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      fundsRequested: json["fundsRequested"],
      fundsRecieved: json["fundsRecieved"]
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'fundsRequested': fundsRequested,
    'fundsRecieved': fundsRecieved,
  };

  PostUI toUI() {
    return PostUI(id: id, postText: description, fundsRequested: fundsRequested);
  }

    



}

// A post UI element to encapsulate and represent all post data
class PostUI extends StatefulWidget {
  final String id;
  final String postText;
  final int fundsRequested;
  int fundsRaised = 0;
  PostUI({
    required this.id,
    required this.postText,
    required this.fundsRequested
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
            Text.rich(
              maxLines: 1,
              overflow: TextOverflow.fade,
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "\$${widget.fundsRaised.toString()}/${widget.fundsRequested.toString()}", style: TextStyle(fontSize: 20)),
                  TextSpan(text: " Funds Raised.", style: TextStyle(fontSize: 20)),
                ]
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.postText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
            ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                 ElevatedButton(
                  onPressed: () {} ,
                  child: Text("Hello"),
            ),
            ),
           
          ],
        ),
      )
    );
  }
}