import 'package:ecommerce_app/base/custom_loader.dart';
import 'package:ecommerce_app/controller/auth_controller.dart';
import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/controller/user_controller.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/account_widget.dart';
import 'package:ecommerce_app/widgets/app_icon.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
            child: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //profile icon
                                AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize:
                                      Dimensions.height45 + Dimensions.height30,
                                  size: Dimensions.height15 * 10,
                                ),
                                SizedBox(
                                  height: Dimensions.height30,
                                ),
                                Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: const Color.fromARGB(
                                            255, 5, 211, 187),
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.name),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yelloColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.phone),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yelloColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel.email),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yelloColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Ca Mau City"),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //message
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Message"),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.toNamed(
                                              RouteHelper.getSigninPage());
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();

                                          Get.find<AuthController>()
                                              .clearSharedData();
                                        } else {
                                          print("you logged out");
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Logout"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const CustomLoader())
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 10,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                image: const DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        "assets/images/signintocontinue.png"))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSigninPage());
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              margin: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                child: BigText(
                                  text: "Sign In",
                                  color: Colors.white,
                                  size: Dimensions.font26,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
