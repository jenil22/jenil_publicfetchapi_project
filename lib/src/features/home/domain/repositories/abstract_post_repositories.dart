import 'package:jenil_publicfetchapi_project/src/models/post_model.dart';

abstract class AbstractPostRepositories {
  Future<List<Post>> fetchAllPosts();
}
