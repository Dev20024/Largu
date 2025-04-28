import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/Resources/posts.dart';



class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {

  List<Post> postDataBase = [];

  Future<void> fetchPosts() async {
  // Simulate a network call

  final file = await rootBundle.loadString('assets/postDataBase.json');
  // Simulate a delay
  await Future.delayed(const Duration(seconds: 2));

  // Decode the JSON data
  postDataBase = (jsonDecode(file)["Posts"] as List<dynamic>)
    .map((data) => Post.fromJson(data))
    .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(postDataBase));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}



 


class CustomSearchDelegate extends SearchDelegate {
  final List<Post> posts;


  CustomSearchDelegate(this.posts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // filter posts based on the query
    List<Post> matchQuery = posts.where((post) {
      return post.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var post = matchQuery[index];
        return post.toUI();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Provide suggestions based on the query
    List<Post> matchQuery = posts.where((post) {
      return post.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var post = matchQuery[index];
        return ListTile(
          title: Text(post.name),
          onTap: () {
            query = post.name;
            showResults(context);
          }
        );
      }
    );
  }
}