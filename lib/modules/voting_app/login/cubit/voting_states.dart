
import 'package:store_app/models/voting_app/login_model.dart';

abstract class VotingLoginStates{}


class VotingLoginInitialState extends VotingLoginStates{}

class VotingLoginLoadingState extends VotingLoginStates{}

class VotingLoginSuccessState extends VotingLoginStates{

  final VotingLoginModel loginModel;


  VotingLoginSuccessState(this.loginModel);

}



class VotingLoginErrorState extends VotingLoginStates{
   final String error;

  VotingLoginErrorState(this.error);

}

class VotingChangePasswordVisibilityState extends VotingLoginStates{}





