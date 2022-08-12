import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/sign_up/cubit/states.dart';
import 'package:shop_app/shared/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login_model.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  Icon sufix = Icon(Icons.visibility_outlined);
  bool isObscure = true;

  void changeObscurePassword() {
    isObscure = !isObscure;
    sufix = isObscure
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(SignUpChangeObscureState());
  }

  late LoginModel? loginModel;

  void signUpPostData({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: SIGN_UP, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(SignUpSuccesState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState());
    });
  }
}
