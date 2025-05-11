const String apiUrl = 'https://jsonplaceholder.typicode.com';

String getPathAllPosts() => '$apiUrl/posts';

String getPathPost(int id) => '$apiUrl/posts/$id';
