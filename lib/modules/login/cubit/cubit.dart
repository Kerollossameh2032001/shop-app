import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Icon sufix = Icon(Icons.visibility_outlined);
  bool isObscure = true;

  void changeObscurePassword() {
    isObscure = !isObscure;
    sufix = isObscure
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(LoginChangeObscureState());
  }

  late LoginModel? loginModel;

  void loginPostData({required Map<String, dynamic> data}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: data).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(LoginSuccesState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

}
