import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/profile/profile_reusable_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if(state is LayoutUpdateProfileDataSuccesState){
          if(state.profileData.status){
            showToast(message: state.profileData.message!, state: ToastState.SUCCES);
          }else{
            showToast(message: state.profileData.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListView(
              children: [
                buildDrawerHeader(cubit, context,cubit.nameController,cubit.emailController),
                const SizedBox(height: 10),
                ConditionalBuilder(
                    condition: cubit.edit,
                    builder: (context)=>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Card(
                        elevation: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: cubit.nameController,
                              onTap: (){
                                cubit.changeUpdateButton(true);
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 25,
                                ),
                                label: Text(
                                  'Name',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: cubit.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 25,
                                ),
                                label: Text(
                                  'E_mail',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              onTap: (){
                                cubit.changeUpdateButton(true);
                              },

                            ),
                            TextFormField(
                              onTap: (){
                                cubit.changeUpdateButton(true);
                              },
                              controller: cubit.phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  size: 25,
                                ),
                                label: Text(
                                  'Phone',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    fallback: (context)=>buildShowCard(context,cubit.nameController,cubit.emailController,cubit.phoneController),
                ),
                const SizedBox(height: 30),
                buildDesign(context, cubit),
              ],
            ),
          ),
        );
      },
    );
  }
}
