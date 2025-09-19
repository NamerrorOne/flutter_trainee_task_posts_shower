import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainee_task/src/core/providers/theme_provider.dart';
import 'package:trainee_task/src/features/posts/presentation/providers/post_provider.dart';
import 'package:trainee_task/src/features/posts/presentation/screens/post_detail_screen.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<PostProvider>().fetchPosts(),
    );

    _searchController.addListener(
      () => context.read<PostProvider>().search(_searchController.text),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search by title...",
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintStyle: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        child: _buildBody(postProvider),
        onRefresh: () => context.read<PostProvider>().fetchPosts(),
      ),
    );
  }
}

Widget _buildBody(PostProvider postProvider) {
  if (postProvider.isLoading && postProvider.posts.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }

  if (postProvider.error != null) {
    return Center(child: Text('An error occurred: ${postProvider.error}'));
  }

  if (postProvider.posts.isEmpty) {
    return const Center(child: Text('No posts found.'));
  }

  return ListView.builder(
    itemCount: postProvider.posts.length,
    itemBuilder: (context, index) {
      final post = postProvider.posts[index];
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 12),
        child: ListTile(
          title: Text("Пост номер ${post.id}\n" + post.title),
          subtitle: Text(
            post.body,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: post),
              ),
            );
          },
        ),
      );
    },
  );
}
