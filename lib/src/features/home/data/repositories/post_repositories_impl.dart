import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/network.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/data/data_source/local/local_repositories.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/data/data_source/remote/remote_repositories.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart'
    show PostModel;
import 'package:jenil_publicfetchapi_project/src/features/home/domain/repositories/abstract_post_repositories.dart';

class PostRepositoriesImpl implements AbstractPostRepositories {
  PostRepositoriesImpl(this.remoteRepositories, this.localRepositories);
  late final RemoteRepositories remoteRepositories;
  late final LocalRepositories localRepositories;

  @override
  Future<AppResponse<List<PostModel>>> getAllPosts() async {
    final bool networkAvl = await Internet().isAvailable();
    if (networkAvl) {
      return await remoteRepositories.fetchAllPost();
    } else {
      return AppResponse(
        msg: 'Internet is not available',
        hasError: true,
        response: null,
      );
    }
  }

  @override
  Future<AppResponse<PostModel>> getPosts(int id) async {
    final bool networkAvl = await Internet().isAvailable();
    if (networkAvl) {
      return await remoteRepositories.fetchPost(id);
    } else {
      return AppResponse(
        msg: 'Internet is not available',
        hasError: true,
        response: null,
      );
    }
  }

  @override
  Future<AppResponse<bool>> addPostToFav(PostModel post) async {
    return await localRepositories.addPostToFav(post);
  }

  @override
  Future<AppResponse<bool>> removePostFromFav(int postId) async {
    return await localRepositories.removePostFromFav(postId);
  }

  @override
  Future<AppResponse<List<PostModel>>> fetchAllFavPost() async {
    return await localRepositories.fetchAllFavPost();
  }
}
