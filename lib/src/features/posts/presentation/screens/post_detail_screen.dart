import 'package:flutter/material.dart';
import 'package:trainee_task/src/features/posts/domain/models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title, maxLines: 1)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(post.title),
              const SizedBox(height: 28),
              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}
