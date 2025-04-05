import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String id;
  final String postText;
  final int fundsRequested;
  int fundsRaised = 0;
  Post({required this.id,required this.postText, required this.fundsRequested});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

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