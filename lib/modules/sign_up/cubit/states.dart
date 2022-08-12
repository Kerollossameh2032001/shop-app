import 'package:shop_app/models/login_model.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccesState extends SignUpStates {
  final LoginModel loginModel;
  SignUpSuccesState(this.loginModel);
}

class SignUpErrorState extends SignUpStates {}

class SignUpChangeObscureState extends SignUpStates {}
