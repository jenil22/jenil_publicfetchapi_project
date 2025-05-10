import 'package:flutter/material.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/presentation/screens/post_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: ListView.separated(
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("Title"), Text("body")],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostDetailsScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward, size: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
    );
  }
}
