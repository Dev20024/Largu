import 'package:flutter/material.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/Posts.dart';





class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final recentViewedPosts = List<Post>.generate(10, (index) {
    return Post(id: generateTimeStampId(), postText: "Post #${index+1}", fundsRequested: index * 100,);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Pls Donate",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        ),
        elevation: 0.0,
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child:  ListView.separated (
              itemCount: recentViewedPosts.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 25,),
              itemBuilder: (BuildContext context, int index) {
                
                Post postInfo = recentViewedPosts[index];

                return Post(
                  id: postInfo.id,
                  postText: postInfo.postText, 
                  fundsRequested: postInfo.fundsRaised,
                );
              },
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
            ),
            ),
            SizedBox(
              width: 5,
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: ListView(
                  
                  itemExtent: 200,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  children: [
                    Post(id: generateTimeStampId(), postText: "#1", fundsRequested: 100),
                    Post(id: generateTimeStampId(), postText: "#2", fundsRequested: 50),
                    Post(id: generateTimeStampId(), postText: "#3", fundsRequested: 25,),
                  ],
                ),
            )
            
          ],
        
      ),

    );
  }
}