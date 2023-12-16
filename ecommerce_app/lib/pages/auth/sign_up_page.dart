import 'package:ecommerce_app/base/custom_loader.dart';
import 'package:ecommerce_app/base/show_custom_snackbar.dart';
import 'package:ecommerce_app/controller/auth_controller.dart';
import 'package:ecommerce_app/models/signup_body_model.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_text_field.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        ShowCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        ShowCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        ShowCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Type in valid email address ",
            title: "Valid email address");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Succes registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
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
                        // your email
                        AppTextField(
                            hintText: "Email",
                            textController: emailController,
                            icon: Icons.email),
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
                        // your name
                        AppTextField(
                            hintText: "Name",
                            textController: nameController,
                            icon: Icons.person),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        // your phone
                        AppTextField(
                            hintText: "Phone",
                            textController: phoneController,
                            icon: Icons.phone),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            registration(authController);
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
                                text: "Sign up",
                                color: Colors.white,
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        RichText(
                          // href
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Have an account already?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
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
                            text: "Sign up using one of the following methods",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: Dimensions.radius30,
                                      backgroundImage: AssetImage(
                                          "assets/images/${signUpImages[index]}"),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
