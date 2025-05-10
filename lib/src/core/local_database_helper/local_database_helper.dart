import 'package:hive_flutter/hive_flutter.dart';
import '../../models/post_model.dart';

class LocalDatabaseHelper {
  static const String _boxName = 'posts';
  static Box<Post>? _postsBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
    _postsBox = await Hive.openBox<Post>(_boxName);
  }

  // Add a new post
  static Future<void> addPost(Post post) async {
    await _postsBox?.put(post.id, post);
  }

  // Update an existing post
  static Future<void> updatePost(Post post) async {
    await _postsBox?.put(post.id, post);
  }

  // Get a post by id
  static Post? getPost(int id) {
    return _postsBox?.get(id);
  }

  // Get all posts
  static List<Post> getAllPosts() {
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
