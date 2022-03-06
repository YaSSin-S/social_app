class PostsModel {
  late String name;
  late String uID;
  late String image;
  late String postImage;
  late String dateTime;
  late String postText;
  // late PostsComments comment;

  PostsModel({
    required this.name,
    required this.dateTime,
    required this.postText,
    required this.uID,
    required this.postImage,
    required this.image,
  });

  PostsModel.fromJson(json) {
    name = json['name'];
    dateTime = json['date_time'];
    postText = json['post_text'];
    uID = json['uId'];
    postImage = json['post_image'];
    image = json['image'];
    // comment = json['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'post_text': postText,
      'uId': uID,
      'post_image': postImage,
      'date_time': dateTime,
      'image': image,
    };
  }
}

class PostsComments {
  late String comment;

  PostsComments({required this.comment});

  PostsComments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
  }
}
