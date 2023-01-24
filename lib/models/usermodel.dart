class SocialUserModel
{
   String? name;
   String? phone;
   String? email;
   String? uId;
   String? image;
   String? cover;
   String? bio;
   bool ? isEmailVerified;
  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
});

  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }
   Map<String,dynamic> toMap()
   {
     return {
       'name':name,
       'email':email,
       'phone':phone,
       'uId':uId,
       'image':image,
       'cover':cover,
       'bio':bio,
       'isEmailVerified':isEmailVerified,
     };
   }
}