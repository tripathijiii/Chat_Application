

class PostList{
  final List<Post>? posts;
  PostList({this.posts});
  factory PostList.fromJson(List<dynamic> parsedjson){
    List<Post> posts = List.empty(growable: true);
    posts = parsedjson.map((e) => Post.fromJson(e)).toList();
    return new PostList(posts: posts);
  }
}


class Post{
  int? userId;
  int? id;
  String? title;
  String? body;
  Post({this.userId,this.id,this.title,this.body});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body']
    );
  }
}