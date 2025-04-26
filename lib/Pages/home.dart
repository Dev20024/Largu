import 'package:flutter/material.dart';
import 'package:namer_app/Resources/Ids.dart';
import 'package:namer_app/Resources/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Post> fetchPost() async {
  final uri = Uri.parse("http://jsonplaceholder.typicode.com/posts/1");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load post");
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // recent viewed posts data (horizontal scroll)
  final recentViewedPosts = List<PostUI>.generate(10, (index) {
    return PostUI(id: generateTimeStampId(), postText: "Post #${index+1}", fundsRequested: index * 100,);
  });

  // recommended posts data (vertical scroll)
  late final ScrollController recommendedPostsController;
  List<PostUI> recommendedPosts = [];
  bool isLoading = false;
  int page = 0;

  // create scroll controller and end of list reached event
  @override
  void initState() {
    super.initState();
    print("Initializing HomePage");
    recommendedPostsController = ScrollController()
      ..addListener(recScrollListener);
    loadRecommendedPosts();
  }

  void recScrollListener() {
    print("recScroller Listener Fired");
    if (isLoading) {return;}
    if (recommendedPostsController.position.atEdge && recommendedPostsController.position.pixels == recommendedPostsController.position.maxScrollExtent) {
      loadRecommendedPosts();
    }
  }

  // fetch more data for the recommended posts list
  Future<void> loadRecommendedPosts() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    //await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    
    List<PostUI> newPosts = [];
    
    for (int i = 0; i < 10; i++) {
      newPosts.add(PostUI(id: generateTimeStampId(), postText: '${page * 10 + i + 1}', fundsRequested: i*10));
    }
    
    setState(() {
      recommendedPosts.addAll(newPosts);
      isLoading = false;
      page++;
    });
    print(recommendedPosts);
    print("Loaded more recommended posts");
  }
  
  @override
  void dispose() {
    print("Disposing Home Page");
    recommendedPostsController.removeListener(recScrollListener);
    recommendedPostsController.dispose();
    recommendedPosts.clear();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    print("app building");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      // Home Page Title Bar
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
      // Home Page Body, includes recently viewed posts and recommended posts
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recently Viewed Posts Scroll Bar
            SizedBox(
              height: 300,
              child:  ListView.separated (
              itemCount: recentViewedPosts.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 25,),
              itemBuilder: (BuildContext context, int index) {
                
                PostUI postInfo = recentViewedPosts[index];

                return PostUI(
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
            // Seperator
            SizedBox(
              width: 5,
              height: 20,
            ),
            // Recommended Posts Scroll Bar
            Expanded(
              child: ListView.builder (
                  cacheExtent: 10,
                  controller: recommendedPostsController,
                  itemCount: recommendedPosts.length + (isLoading ? 1: 0), // add 1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index < recommendedPosts.length) {
                      print(recommendedPosts[index]);
                      PostUI postData = recommendedPosts[index];
                      return PostUI(id: postData.id, postText: postData.postText, fundsRequested: postData.fundsRequested);
                    }
                    // load indicator at the end
                    return Center(child: CircularProgressIndicator());
                  },
                ),
            )
            
          ],
        
      ),

    );
  }
}
