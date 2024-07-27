import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Page'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, AddNewBlogPage.route()),
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
