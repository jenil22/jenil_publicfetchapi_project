import 'package:jenil_publicfetchapi_project/src/core/constants/network_constants.dart';
import 'package:jenil_publicfetchapi_project/src/core/utils/app_response.dart';
import 'package:jenil_publicfetchapi_project/src/features/home/domain/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteRepositories {
  Future<AppResponse<List<PostModel>>> fetchAllPost();
  Future<AppResponse<PostModel>> fetchPost(int id);
}

class RemoteRepositoriesImpl implements RemoteRepositories {
  @override
  Future<AppResponse<List<PostModel>>> fetchAllPost() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(getPathAllPosts()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<PostModel> posts =
            jsonList
                .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
                .toList();
        return AppResponse(msg: 'success', response: posts);
      } else {
        return AppResponse(
          msg: 'Failed to fetch posts',
          hasError: true,
          response: null,
        );
      }
    } catch (e) {
      return AppResponse(
        msg: 'Error: ${e.toString()}',
        hasError: true,
        response: null,
      );
    }
  }

  @override
  Future<AppResponse<PostModel>> fetchPost(int id) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(getPathPost(id)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return AppResponse(
          msg: 'success',
          response: PostModel.fromJson(json.decode(response.body)),
        );
      } else {
        return AppResponse(
          msg: 'Failed to fetch posts',
          hasError: true,
          response: null,
        );
      }
    } catch (e) {
      return AppResponse(
        msg: 'Error: ${e.toString()}',
        hasError: true,
        response: null,
      );
    }
  }
}
