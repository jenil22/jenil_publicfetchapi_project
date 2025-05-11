import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/loader.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/cubit/posts_cubit.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.id});
  final int id;
  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getPost(widget.id),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: 20),
          ),
          actions: [],
        ),
        body: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {
            if (state is Posterror) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errMsg)));
            }
          },
          builder: (context, state) {
            if (state is Postloading) {
              return Loader();
            } else if (state is SinglePostLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(state.post.title),
                    const SizedBox(height: 8),
                    Text(state.post.body),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
