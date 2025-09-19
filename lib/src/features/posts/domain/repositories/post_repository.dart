import "../models/post.dart";

abstract interface class IPostRepository {
  Future<List<Post>> getPosts();
  Future<Post> getPostById(int id);
}
