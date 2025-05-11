import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/data/repositories/post_repositories_impl.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';

class PostsUsecase {
  PostsUsecase(this._postRepositoriesImpl);

  late final PostRepositoriesImpl _postRepositoriesImpl;

  Future<AppResponse<List<PostModel>>> getAllPosts() =>
      _postRepositoriesImpl.getAllPosts();

  Future<AppResponse<PostModel>> getPosts(int id) =>
      _postRepositoriesImpl.getPosts(id);

  Future<AppResponse<bool>> addToFavorites(PostModel post) =>
      _postRepositoriesImpl.addPostToFav(post);

  Future<AppResponse<bool>> removeFromFavorites(int postId) =>
      _postRepositoriesImpl.removePostFromFav(postId);

  Future<List<PostModel>> getFavoritePosts() async {
    final response = await _postRepositoriesImpl.fetchAllFavPost();
    return response.response ?? [];
  }
}
