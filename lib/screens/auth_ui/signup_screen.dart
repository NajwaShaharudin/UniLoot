import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:uni_loot/screens/auth_ui/signIn_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context , isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            title: Text(
              "SIGN UP",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),

          body: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text("Sign Up to enjoy our apps!", style: TextStyle(
                        color: AppConstant.appSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      )
                  ),

                  SizedBox(height: Get.height/20),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon: Icon(Icons.location_pin),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height/20,),

                  Material(
                    child: Container(
                      width: Get.width/ 2,
                      height: Get.height/18,
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondaryColor,
                          borderRadius:BorderRadius.circular((20.0),)
                      ),
                      child: TextButton(
                        child: Text("SIGN UP",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: (){},
                      ),
                    ),
                  ),

                  SizedBox(height:Get.height / 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: AppConstant.appSecondaryColor),
                      ),
                      
                      GestureDetector(
                        onTap: () => Get.to(() => SignInScreen()),
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: AppConstant.appSecondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],)
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
