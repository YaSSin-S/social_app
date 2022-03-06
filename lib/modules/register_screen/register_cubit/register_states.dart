
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialLoadingRegisterState extends SocialRegisterStates {}

class SocialSuccessRegisterState extends SocialRegisterStates {}

class SocialErrorRegisterState extends SocialRegisterStates {
  final String error;
  SocialErrorRegisterState(
      this.error,
      );
}
class SocialSuccessCreateState extends SocialRegisterStates {
  final String uID;

  SocialSuccessCreateState(this.uID);
}

class SocialErrorCreateState extends SocialRegisterStates {
  final String error;
  SocialErrorCreateState(
      this.error,
      );
}