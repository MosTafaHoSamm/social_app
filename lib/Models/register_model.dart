class RegisterModel{
    String name;
    String email;
    String phone;
    String uId;
    String image;
    String cover;
    bool isVerified;
    String bio;

  RegisterModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.image,
      this.cover,
      this.isVerified,
      this.bio});
  RegisterModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isVerified=json['isVerified'];

  }
  Map<String,dynamic>toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isVerified': isVerified,

    };

  }
}

