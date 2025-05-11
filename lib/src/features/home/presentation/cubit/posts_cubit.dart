import 'package:bloc/bloc.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/data/data_source/local/local_repositories.dart';

import 'package:jenil_publicfetchapi_project/src/features/home/data/data_source/remote/remote_repositories.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/data/repositories/post_repositories_impl.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/usecases/posts_usecase.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostInitial()) {
    _postsUsecase = PostsUsecase(
      PostRepositoriesImpl(RemoteRepositoriesImpl(), LocalRepositoriesImpl()),
    );
  }
  late final PostsUsecase _postsUsecase;
  List<PostModel> _allPosts = [];

  Future<void> getAllPosts() async {
    emit(Postloading());
    final AppResponse<List<PostModel>> response =
        await _postsUsecase.getAllPosts();
    if (response.response?.isNotEmpty ?? false) {
      _allPosts = response.response ?? [];
      // Load favorite status from local storage
      final favPosts = await _postsUsecase.getFavoritePosts();
      for (var post in _allPosts) {
        post.isFavorite = favPosts.any((favPost) => favPost.id == post.id);
      }
      emit(Postloaded(posts: _allPosts));
    } else {
      emit(Posterror(errMsg: response.msg));
    }
  }

  Future<void> filterPosts({String? searchText}) async {
    if (_allPosts.isEmpty) {
      await getAllPosts();
    }

    if (searchText == null || searchText.isEmpty) {
      emit(Postloaded(posts: _allPosts));
      return;
    }

    final filteredPosts =
        _allPosts.where((post) {
          final titleMatch = post.title.toLowerCase().contains(
            searchText.toLowerCase(),
          );
          final bodyMatch = post.body.toLowerCase().contains(
            searchText.toLowerCase(),
          );
          return titleMatch || bodyMatch;
        }).toList();

    if (filteredPosts.isNotEmpty) {
      emit(Postloaded(posts: filteredPosts));
    } else {
      emit(Posterror(errMsg: 'No posts found matching your search'));
    }
  }

  Future<void> getPost(int id) async {
    emit(Postloading());
    final AppResponse<PostModel> response = await _postsUsecase.getPosts(id);
    if (response.response != null) {
      emit(SinglePostLoaded(post: response.response!));
    } else {
      emit(Posterror(errMsg: response.msg));
    }
  }

  Future<void> toggleFavorite(int postId) async {
    if (_allPosts.isEmpty) return;

    final postIndex = _allPosts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = _allPosts[postIndex];
      if (post.isFavorite) {
        await _postsUsecase.removeFromFavorites(postId);
      } else {
        await _postsUsecase.addToFavorites(post);
      }
      post.isFavorite = !post.isFavorite;
      emit(Postloaded(posts: _allPosts));
    }
  }

  Future<List<PostModel>> getFavoritePosts() async {
    return await _postsUsecase.getFavoritePosts();
  }
}
