import 'package:trainee_task/src/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:trainee_task/src/features/posts/data/models/post_dto.dart';
import 'package:trainee_task/src/features/posts/domain/models/post.dart';
import 'package:trainee_task/src/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements IPostRepository {
  final IPostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Post> getPostById(int id) async {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts() async {
    try {
      final List<PostDto> postDtos = await remoteDataSource.getPosts();
      final List<Post> posts = postDtos.map((dto) => dto.toDomain()).toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
