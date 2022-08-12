import 'package:flutter/material.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';



Padding buildDataShow(BuildContext context, IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: secondDefaultColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
        SizedBox(width: 50),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 20,
              ),
        ),
      ],
    ),
  );
}

Padding buildDesign(BuildContext context, LayoutCubit cubit) {
  return Padding(
    padding: const EdgeInsets.only(right: 18.0),
    child: Row(
      children: [
        Container(
          height: 100,
          width: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: defaultColor.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(7, 5), // changes position of shadow
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
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: defaultColor.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(-6, 5), // changes position of shadow
              ),
            ],
          ),
        ),
        Spacer(),
        ConditionalBuilder(
          condition: cubit.update,
          builder: (context) => buildUpdateButton(cubit),
          fallback: (context) => Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        )
      ],
    ),
  );
}

Widget buildUpdateButton(LayoutCubit cubit) {
  return defaultElevatedButton(
    color: secondDefaultColor,
    roundedRectangleBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
    ),
    size: Size(150, 50),
    onPressed: () {
      cubit.getUpdateProfileData();
    },
    child: Row(
      children: [
        Icon(Icons.refresh_outlined),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Up date',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}

SizedBox buildDrawerHeader(
  LayoutCubit cubit,
  BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
) {
  return SizedBox(
    height: 250,
    child: DrawerHeader(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: defaultColor,
                radius: 60,
                backgroundImage: NetworkImage(cubit.profileData!.data!.image),
              ),
              Positioned(
                top: 70,
                left: 80,
                child: IconButton(
                  onPressed: () {
                    cubit.changeEdit();
                    cubit.changeUpdateButton(false);
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                        color: secondDefaultColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            nameController.text,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            emailController.text,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.grey),
          )
        ],
      ),
    ),
  );
}

Padding buildShowCard(
  BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController phoneController,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      elevation: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildDataShow(context, Icons.person, nameController.text),
          Divider(),
          buildDataShow(context, Icons.email_outlined, emailController.text),
          Divider(),
          buildDataShow(context, Icons.phone, phoneController.text),
        ],
      ),
    ),
  );
}

/*Padding buildEditCard(
  LayoutCubit cubit,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      elevation: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            onChanged: (value) {
              cubit.changeUpdateButton(true);
            },
            controller: nameController,
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
            onChanged: (value) {
              cubit.changeUpdateButton(true);
            },
            controller: emailController,
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
          ),
          TextFormField(
            onChanged: (value) {
              cubit.changeUpdateButton(true);
            },
            controller: phoneController,
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
  );
}
*/