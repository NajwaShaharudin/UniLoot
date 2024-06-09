import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:uni_loot/controllers/signup_controller.dart';
import 'package:uni_loot/screens/auth_ui/signIn_screen.dart';
import 'package:uni_loot/utils/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context , isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConstant.appSecondaryColor,
            title: Text(
              "SIGN UP" ,
              style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),

          body: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width < 600 ? 20.0 : 100.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height / 20,
                    ),
                    Center(
                        child: Text("Sign up to explore our apps!", style: TextStyle(
                          color: AppConstant.appSecondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        )
                    ),

                    SizedBox(height: Get.height/20),

                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: Get.width < 600 ? Get.width : 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: userEmail,
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
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: Get.width < 600 ? Get.width : 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: username,
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
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: Get.width < 600 ? Get.width : 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: userPhone,
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
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: Get.width < 600 ? Get.width : 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: userCity,
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
                    ),


                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        width: Get.width < 600 ? Get.width : 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Obx(() => TextFormField(
                            controller: userPassword,
                            obscureText: signUpController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    signUpController.isPasswordVisible.toggle();
                                  },
                                  child: signUpController.isPasswordVisible.value
                                      ?  Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)
                              ),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),)
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height/20,),

                    Material(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width/ 5,
                            height: Get.height/18,
                            decoration: BoxDecoration(
                                color: AppConstant.appSecondaryColor,
                                borderRadius:BorderRadius.circular((20.0),)
                            ),
                            child: TextButton(
                              child: Text("SIGN UP",
                                style: TextStyle(color: AppConstant.appTextColor),
                              ),
                              onPressed: () async {
                                String name = username.text.trim();
                                String email = userEmail.text.trim();
                                String phone = userPhone.text.trim();
                                String city = userCity.text.trim();
                                String password = userPassword.text.trim();
                                String userDeviceToken = '';

                                if(name.isEmpty ||
                                    email.isEmpty ||
                                    phone.isEmpty ||
                                    city.isEmpty ||
                                    password.isEmpty)
                                  {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter all details",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppConstant.appSecondaryColor,
                                      colorText: AppConstant.appTextColor,
                                    );
                                  } else {
                                    UserCredential? userCredential =
                                        await signUpController.signUpMethod(
                                        name,
                                        email,
                                        phone,
                                        city,
                                        password,
                                        userDeviceToken,
                                    );

                                      if(userCredential != null){
                                        Get.snackbar(
                                            "Verification email sent.",
                                            "Please check your email.",
                                            snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: AppConstant.appTextColor,
                                        );

                                        FirebaseAuth.instance.signOut();
                                        Get.offAll(() => SignInScreen());
                                      }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height:Get.height / 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
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
          ),
        );
      },

    );
  }
}
