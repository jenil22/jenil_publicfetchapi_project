import 'package:hive_flutter/hive_flutter.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';

class LocalDatabaseHelper {
  static const String _boxName = 'posts';
  static Box<PostModel>? _postsBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostModelAdapter());
    _postsBox = await Hive.openBox<PostModel>(_boxName);
  }

  // Add a new post
  static Future<void> addPost(PostModel post) async {
    await _postsBox?.put(post.id, post);
  }

  // Update an existing post
  static Future<void> updatePost(PostModel post) async {
    await _postsBox?.put(post.id, post);
  }

  // Get a post by id
  static PostModel? getPost(int id) {
    return _postsBox?.get(id);
  }

  // Get all posts
  static List<PostModel> getAllPosts() {
    return _postsBox?.values.toList() ?? [];
  }

  // Delete a post
  static Future<void> deletePost(int id) async {
    await _postsBox?.delete(id);
  }

  // Clear all posts
  static Future<void> clearAllPosts() async {
    await _postsBox?.clear();
  }

  // Close the box
  static Future<void> closeBox() async {
    await _postsBox?.close();
  }
}
