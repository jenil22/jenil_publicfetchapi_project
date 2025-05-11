import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/cubit/posts_cubit.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/screens/post_details_screen.dart';

class FavouriteScreenContent extends StatelessWidget {
  const FavouriteScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites Posts")),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is Postloaded) {
            final favoritePosts =
                state.posts.where((post) => post.isFavorite).toList();
            if (favoritePosts.isEmpty) {
              return const Center(child: Text('No favorite posts yet'));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  PostDetailsScreen(id: state.posts[index].id),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    favoritePosts[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await context
                                        .read<PostsCubit>()
                                        .toggleFavorite(
                                          favoritePosts[index].id,
                                        );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(favoritePosts[index].body),
                          ],
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: favoritePosts.length,
            );
          }
          return const Center(child: Text('No favorite posts yet'));
        },
      ),
    );
  }
}
