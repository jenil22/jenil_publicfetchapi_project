import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';

abstract class AbstractPostRepositories {
  Future<AppResponse<List<PostModel>>> getAllPosts();
  Future<AppResponse<PostModel>> getPosts(int id);
  Future<AppResponse<bool>> addPostToFav(PostModel post);
  Future<AppResponse<bool>> removePostFromFav(int postId);
  Future<AppResponse<List<PostModel>>> fetchAllFavPost();
}
