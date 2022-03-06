
abstract class SocialLoginStates {}

class SocialInitialState extends SocialLoginStates {}

class SocialLoadingState extends SocialLoginStates {}

class SocialSuccessState extends SocialLoginStates {
  final String uID;
  SocialSuccessState(
      this.uID,
      );
}

class SocialErrorState extends SocialLoginStates {
  final String error;
  SocialErrorState(
      this.error,
      );
}