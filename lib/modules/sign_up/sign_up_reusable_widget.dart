import 'package:flutter/material.dart';
import 'package:shop_app/modules/sign_up/cubit/cubit.dart';
import '../../shared/constants/reusable_componants.dart';

Widget singUPbuildFieldItem({
  required SignUpCubit cubit,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required TextEditingController phoneController,
}) {
  return Card(
    margin: EdgeInsets.all(15),
    elevation: 25.0,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'The name must not be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Name'),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
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
                return 'The Password is to short';
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
          const SizedBox(height: 20),
          TextFormField(
            controller: confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty || value != passwordController.text) {
                return 'The two password are not match';
              }
              return null;
            },
            decoration: InputDecoration(
              label: const Text('Confirm password'),
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.changeObscurePassword();
                },
                icon: cubit.sufix,
              ),
            ),
            obscureText: cubit.isObscure,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'The Phone must not be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Phone'),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
        ],
      ),
    ),
  );
}

Padding buildSignUp({
  required BuildContext context,
  required SignUpCubit cubit,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required TextEditingController phoneController,
  required GlobalKey<FormState> fromKey,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0),
    child: Row(
      children: [
        Text(
          'Register now to browse\n our hot offers',
          style: Theme.of(context).textTheme.headline6,
        ),
        Spacer(),
        defaultElevatedButton(
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                cubit.signUpPostData(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phone: phoneController.text,
                );
              }
            },
            child: Text('SIGN UP'),
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
