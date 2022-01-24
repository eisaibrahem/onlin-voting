
import 'package:store_app/models/voting_app/login_model.dart';

abstract class VotingRegisterStates{}


class VotingRegisterInitialState extends VotingRegisterStates{}

class VotingRegisterLoadingState extends VotingRegisterStates{}

class VotingRegisterSuccessState extends VotingRegisterStates{

  final VotingLoginModel loginModel;


  VotingRegisterSuccessState(this.loginModel);

}



class VotingRegisterErrorState extends VotingRegisterStates{
   final String error;

  VotingRegisterErrorState(this.error);

}

class VotingRegisterChangePasswordVisibilityState extends VotingRegisterStates{}





