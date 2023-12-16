import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/controller/popular_product_controller.dart';
import 'package:ecommerce_app/controller/recommended_product_controller.dart';
import 'package:ecommerce_app/pages/auth/sign_in_page.dart';
import 'package:ecommerce_app/pages/auth/sign_up_page.dart';
import 'package:ecommerce_app/pages/cart/cart_page.dart';
import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
import 'package:ecommerce_app/pages/home/food_page_body.dart';
import 'package:ecommerce_app/pages/home/home_page.dart';
import 'package:ecommerce_app/pages/home/main_food_page.dart';
import 'package:ecommerce_app/pages/splash/splash_page.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
