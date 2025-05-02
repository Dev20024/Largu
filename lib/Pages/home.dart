import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Resources/posts.dart';
import 'dart:convert';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // recent viewed posts data (horizontal scroll)
  List<Post> recentViewedPosts = [];
    
  // fetch recent posts data from json file
  Future<void> fetchRecentPosts() async {
    final file = await rootBundle.loadString('assets/recentPosts.json');
    
    recentViewedPosts = (jsonDecode(file)["Posts"] as List<dynamic>)
        .map((data) => Post.fromJson(data))
        .toList();

    setState(() {
      recentViewedPosts = recentViewedPosts;
    });
  }

  // recommended posts data (vertical scroll)
  late final ScrollController recommendedPostsController;
  List<Post> recommendedPosts = [];
  bool isLoading = false;
  int page = 0;

  // create scroll controller and end of list reached event
  @override
  void initState() {
    super.initState();
    print("Initializing HomePage");
    recommendedPostsController = ScrollController()
      ..addListener(recScrollListener);
    fetchRecentPosts();
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

    List<Post> newPosts = [];

    final file = await rootBundle.loadString('assets/response.json');
    await Future.delayed(const Duration(seconds: 2), () {}); // Simulate network delay
    newPosts = (jsonDecode(file)["Posts"] as List<dynamic>)
        .map((data) => Post.fromJson(data))
        .toList();

    if (!mounted) return;
    
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
                
                Post postInfo = recentViewedPosts[index];

                return postInfo.toUI();
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
                  addAutomaticKeepAlives: false,
                  cacheExtent: 10,
                  controller: recommendedPostsController,
                  itemCount: recommendedPosts.length + (isLoading ? 1: 0), // add 1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index < recommendedPosts.length) {
                      Post postData = recommendedPosts[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0, top: 20.0),
                        child: postData.toUI(),
                      ); 
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
