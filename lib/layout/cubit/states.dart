abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialChangeNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialStates {}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadLoadingState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialPostLikeSuccessState extends SocialStates {}

class SocialPostLikeErrorState extends SocialStates {
  final String error;

  SocialPostLikeErrorState(this.error);

}

class SocialGetLikesNumberSuccessState extends SocialStates {}

class SocialGetLikesNumberErrorState extends SocialStates {
  final String error;

  SocialGetLikesNumberErrorState(this.error);

}

class SocialPostMakeCommentSuccessState extends SocialStates {}

class SocialPostMakeCommentErrorState extends SocialStates {
  final String error;

  SocialPostMakeCommentErrorState(this.error);

}

class SocialPostGetCommentSuccessState extends SocialStates {}

class SocialPostGetCommentErrorState extends SocialStates {
  final String error;

  SocialPostGetCommentErrorState(this.error);

}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {}