class LikeModel{
  bool like;
  LikeModel(this.like);
  LikeModel.fromJson(Map<String,dynamic>json){
    like=json['like'];
  }
  Map<String,dynamic>toMap(){
    return{
      'like':true
    };
  }
}