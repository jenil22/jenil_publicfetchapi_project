import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/loader.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/cubit/posts_cubit.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/screens/post_details_screen.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search Here...',
                suffixIcon: IconButton(
                  onPressed: () {
                    context.read<PostsCubit>().filterPosts(searchText: '');
                    search.clear();
                  },
                  icon: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
              onSubmitted: (value) {
                context.read<PostsCubit>().filterPosts(searchText: value);
              },
            ),
          ),
          BlocConsumer<PostsCubit, PostsState>(
            listener: (context, state) {
              if (state is Posterror) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMsg)));
              }
            },
            builder: (context, state) {
              if (state is Postloading) {
                return const Expanded(child: Loader());
              } else if (state is Postloaded) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context.read<PostsCubit>().getAllPosts();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder:
                          (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => PostDetailsScreen(
                                        id: state.posts[index].id,
                                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.posts[index].title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            state.posts[index].isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                state.posts[index].isFavorite
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                          onPressed: () async {
                                            await context
                                                .read<PostsCubit>()
                                                .toggleFavorite(
                                                  state.posts[index].id,
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(state.posts[index].body),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 8),
                      itemCount: state.posts.length,
                    ),
                  ),
                );
              } else if (state is Posterror) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errMsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PostsCubit>().getAllPosts();
                            search.clear();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Expanded(child: SizedBox());
              }
            },
          ),
        ],
      ),
    );
  }
}
