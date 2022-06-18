class PostModel {
  String name;
  String image;
  String postImage;
  String uId;
  String date;
  String content;

  PostModel({this.name, this.image, this.uId, this.date, this.postImage,this.content});
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
    date = json['date'];
    postImage = json['postImage'];
    content = json['content'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'uId': uId,
      'image': image,
      'date': date,
      'postImage': postImage,
      'content': content,
    };
  }
}
