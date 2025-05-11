part of 'posts_cubit.dart';

abstract class PostsState {}

class PostInitial extends PostsState {}

class Postloading extends PostsState {}

class Postloaded extends PostsState {
  Postloaded({required this.posts});
  final List<PostModel> posts;
}

class SinglePostLoaded extends PostsState {
  SinglePostLoaded({required this.post});
  final PostModel post;
}

class Posterror extends PostsState {
  Posterror({required this.errMsg});
  final String errMsg;
}
