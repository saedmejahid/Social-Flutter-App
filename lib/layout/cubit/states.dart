abstract class SocialStates{}
//////InitialState
class SocialInitialState extends SocialStates{}
////// NewPost
class SocialNewPostState extends SocialStates{}
////// ChangeNavBar
class SocialChangeNavBarState extends SocialStates{}
////// GetUser
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}
////// GetAllUser
class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}
////// GetPosts
class SocialGetPostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}
////// ProfilePick
class SocialProfilePickSuccessState extends SocialStates{}
class SocialProfilePickErrorState extends SocialStates{}
////// UploadProfile
class SocialUploadProfileSuccessState extends SocialStates{}
class SocialUploadProfileErrorState extends SocialStates {}
////// CoverPick
class SocialProfileCoverPickSuccessState extends SocialStates{}
class SocialProfileCoverPickErrorState extends SocialStates{}
////// UploadCover
class SocialUploadCoverSuccessState extends SocialStates{}
class SocialUploadCoverErrorState extends SocialStates{}
////// UserUpdateCover
class SocialUserUpdateCoverLoadingState extends SocialStates{}
////// UserUpdate
class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}
////// create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
////// upload post
class SocialUploadPostLoadingState extends SocialStates{}
class SocialUploadPostErrorState extends SocialStates{}
class SocialUploadPostSuccessState extends SocialStates{}
///// PickPost States
class SocialPostSuccessState extends SocialStates{}
class SocialPostErrorState extends SocialStates{}
///// remove image States
class SocialRemovePostImageState extends SocialStates{}
///// likePost
class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}
///// SendMessages
class SocialSendMessagesSuccessState extends SocialStates{}
class SocialSendMessagesErrorState extends SocialStates {
  final String error;

  SocialSendMessagesErrorState(this.error);
}
///// GetMessages
class SocialGetMessagesSuccessState extends SocialStates{}
class SocialGetMessagesErrorState extends SocialStates {
  final String error;

  SocialGetMessagesErrorState(this.error);
}

























