import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/cubit/posts_cubit.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/widget/favourite_screen_content.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/widget/home_screen_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getAllPosts(),
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [HomeScreenContent(), FavouriteScreenContent()],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TabBar(
            controller: _tabController,
            tabs: const [Tab(text: 'Home'), Tab(text: 'Favorites')],
          ),
        ),
      ),
    );
  }
}
