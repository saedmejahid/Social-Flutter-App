class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? date;
  String? text;
  String? postImage;



  PostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.postImage,
    this.text,
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    date = json['date'];
    postImage = json['postImage'];
    text = json['text'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'date':date,
      'postImage':postImage,
      'text':text,
    };
  }
}