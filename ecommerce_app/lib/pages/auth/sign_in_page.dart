import 'package:ecommerce_app/base/custom_loader.dart';
import 'package:ecommerce_app/base/show_custom_snackbar.dart';
import 'package:ecommerce_app/controller/auth_controller.dart';
import 'package:ecommerce_app/models/signup_body_model.dart';
import 'package:ecommerce_app/pages/auth/sign_up_page.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_text_field.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        ShowCustomSnackBar("Type in your phone number", title: "Phone ");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //App logo
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/images/logo.png")),
                      ),
                    ),
                    //Welcome
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sign into your account",
                            style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500]
                                // fontWeight: FontWeight.bold
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your email
                    AppTextField(
                        hintText: "Phone",
                        textController: phoneController,
                        icon: Icons.phone),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // your password
                    AppTextField(
                      hintText: "Password",
                      textController: passwordController,
                      icon: Icons.password_sharp,
                      isObscure: true,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          // href
                          text: TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    // Sign in
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: "Sign in",
                            color: Colors.white,
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //sign up options
                    RichText(
                      // href
                      text: TextSpan(
                          text: "Don\'t have an account?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => SignUpPage(),
                                    transition: Transition.fade),
                              text: " Create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20,
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            : CustomLoader();
      }),
    );
  }
}
