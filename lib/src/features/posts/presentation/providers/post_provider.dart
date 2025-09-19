import 'package:flutter/material.dart';
import 'package:trainee_task/src/features/posts/domain/models/post.dart';
import 'package:trainee_task/src/features/posts/domain/repositories/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final IPostRepository _iPostRepository;

  PostProvider({required IPostRepository postRepository})
    : _iPostRepository = postRepository;

  bool _isLoading = false;
  List<Post> _posts = [];
  String? _error;
  String _searchQuery = "";

  bool get isLoading => this._isLoading;
  String? get error => this._error;
  String get searchQuery => this.searchQuery;
  List<Post> get posts {
    if (_searchQuery.isEmpty) {
      return _posts;
    } else {
      return _posts
          .where((post) =>
              post.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      this._posts = await _iPostRepository.getPosts();
      this._posts.shuffle();
    } catch (e) {
      _error = e.toString();
      print(_error);
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    this._searchQuery = query;
    notifyListeners();
  }
}
