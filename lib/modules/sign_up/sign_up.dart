import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/sign_up/cubit/cubit.dart';
import 'package:shop_app/modules/sign_up/cubit/states.dart';
import 'package:shop_app/modules/sign_up/sign_up_reusable_widget.dart';
import '../../layout/layout.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/network/local/cach_helper.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contex) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccesState) {
            if (state.loginModel.status) {
              showToast(
                  message: state.loginModel.message!, state: ToastState.SUCCES);
              CacheHelper.savedData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                if (value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, LayoutScreen());
                }
              });
            } else {
              showToast(
                  message: state.loginModel.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          SignUpCubit cubit = SignUpCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.black87),
                          ),
                          Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: defaultColor,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: defaultColor.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      6, -5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: defaultColor.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(
                                        -7, -5), // changes position of shadow
                                  ),
                                ],
                                color: defaultColor,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100))
                                //shape: BoxShape.circle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    Form(
                      key: formKey,
                      child: singUPbuildFieldItem(
                        cubit: cubit,
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        phoneController: phoneController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (state is SignUpLoadingState)
                      const Padding(
                        padding:  EdgeInsets.only(left: 20.0, right: 20),
                        child: LinearProgressIndicator(),
                      ),
                    const SizedBox(height: 30),
                    buildSignUp(
                      context: context,
                      cubit: cubit,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      phoneController: phoneController,
                      fromKey: formKey,
                    ),
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: defaultColor.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(
                                        7, 5), // changes position of shadow
                                  ),
                                ],
                                color: defaultColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100))
                                //shape: BoxShape.circle,
                                ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: defaultColor,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: defaultColor.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      -6, 5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              navigateAndFinish(context, LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
