import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainee_task/src/core/providers/theme_provider.dart';
import 'package:trainee_task/src/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:trainee_task/src/features/posts/data/repositories/post_repository_impl.dart';
import 'package:trainee_task/src/features/posts/domain/repositories/post_repository.dart';
import 'package:trainee_task/src/features/posts/presentation/providers/post_provider.dart';
import 'package:trainee_task/src/features/posts/presentation/screens/posts_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<Dio>(create: (_) => Dio()),
        Provider<IPostRemoteDataSource>(
          create: (context) =>
              PostRemoteDataSourceImpl(dio: context.read<Dio>()),
        ),
        Provider<IPostRepository>(
          create: (context) => PostRepositoryImpl(
            remoteDataSource: context.read<IPostRemoteDataSource>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              PostProvider(postRepository: context.read<IPostRepository>()),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const PostsListScreen(),
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
          );
        },
      ),
    );
  }
}
