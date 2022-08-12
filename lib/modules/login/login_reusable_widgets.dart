import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';

import '../../shared/constants/reusable_componants.dart';

Widget buildFieldItem({
  required LoginCubit cubit,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  return Card(
    margin: EdgeInsets.all(15),
    elevation: 25.0,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'The E-mail must not be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('E-mail'),
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'The Password must not be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              label: const Text('Password'),
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.changeObscurePassword();
                },
                icon: cubit.sufix,
              ),
            ),
            obscureText: cubit.isObscure,
            controller: passwordController,
          ),
        ],
      ),
    ),
  );
}

Padding buildLogin(
  BuildContext context,
  LoginCubit cubit,
  TextEditingController emailController,
  TextEditingController passwordController,
  GlobalKey<FormState> fromKey,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0),
    child: Row(
      children: [
        Text(
          'Login now to browse\n our hot offers',
          style: Theme.of(context).textTheme.headline6,
        ),
        Spacer(),
        defaultElevatedButton(
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                cubit.loginPostData(data: {
                  'email': emailController.text,
                  'password': passwordController.text,
                });
              }
            },
            child: Text('LOGIN'),
            size: Size(125, 25),
            roundedRectangleBorder: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )))
      ],
    ),
  );
}
