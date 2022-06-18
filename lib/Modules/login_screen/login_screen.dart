import 'package:flutter/material.dart';


import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/login.png',
                    )),
              ]),
              Text(
                "Login Screen",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              defaultTextForm(
                  text: 'email',
                  controller: emailController,
                  iconPrefix: IconBroken.User,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'this field must not be empty ';
                    } else {
                      return null;
                    }
                  },
                  onChange: (String value) {
                    print(value);
                  }),
              SizedBox(
                height: 20,
              ),
              defaultTextForm(
                  text: 'password',
                  controller: passwordController,
                  iconPrefix: IconBroken.Lock,
                  obsecure: true,
                  suffixIcon: Icons.visibility,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'this field must not be empty ';
                    } else {
                      return null;
                    }
                  },
                  onChange: (String value) {
                    print(value);
                  }),
              SizedBox(
                height: 20,
              ),
              defaultButton(
                text: 'Login',
                onPressed: () {
                  print('Login Pressed');
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Don\'t have an account ?',
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  child: Text('Register'.toUpperCase()),
                  onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return RegisterScreen();}), (route) => false);
                },),
                // defaultTextButton(text: 'Register',
                //     onPressed: () {
                //         navigateAndFinish(context:context, widget:RegisterScreen());
                //     }),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
