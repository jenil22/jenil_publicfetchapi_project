import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/local_database_helper.dart';

abstract class LocalRepositories {
  Future<AppResponse<bool>> addPostToFav(PostModel post);
  Future<AppResponse<bool>> removePostFromFav(int postId);
  Future<AppResponse<List<PostModel>>> fetchAllFavPost();
}

class LocalRepositoriesImpl implements LocalRepositories {
  @override
  Future<AppResponse<bool>> addPostToFav(PostModel post) async {
    try {
      await LocalDatabaseHelper.addPost(post);
      return AppResponse(
        msg: 'Post added to favorites successfully',
        response: true,
      );
    } catch (e) {
      return AppResponse(
        msg: 'Failed to add post to favorites: ${e.toString()}',
        hasError: true,
        response: false,
      );
    }
  }

  @override
  Future<AppResponse<bool>> removePostFromFav(int postId) async {
    try {
      await LocalDatabaseHelper.deletePost(postId);
      return AppResponse(
        msg: 'Post removed from favorites successfully',
        response: true,
      );
    } catch (e) {
      return AppResponse(
        msg: 'Failed to remove post from favorites: ${e.toString()}',
        hasError: true,
        response: false,
      );
    }
  }

  @override
  Future<AppResponse<List<PostModel>>> fetchAllFavPost() async {
    try {
      final List<PostModel> posts = LocalDatabaseHelper.getAllPosts();
      return AppResponse(msg: 'success', response: posts);
    } catch (e) {
      return AppResponse<List<PostModel>>(
        msg: 'Failed to remove post from favorites: ${e.toString()}',
        hasError: true,
        response: [],
      );
    }
  }
}
