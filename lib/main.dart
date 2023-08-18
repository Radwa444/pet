import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_shop/app/cart/add_billing_add.dart';
import 'package:pet_shop/app/cart/buy_now.dart';
import 'package:pet_shop/app/cart/cart.dart';
import 'package:pet_shop/app/cart/check_out.dart';
import 'package:pet_shop/app/cart/check_out_complete.dart';
import 'package:pet_shop/app/cart/check_out_shipping_add.dart';
import 'package:pet_shop/app/detail/product_detail.dart';
import 'package:pet_shop/app/home/home_screen.dart';
import 'package:pet_shop/app/lists/blog_screen.dart';
import 'package:pet_shop/app/lists/category_screen.dart';
import 'package:pet_shop/app/intro/intro_screen.dart';
import 'package:pet_shop/app/lists/best_selling_list.dart';
import 'package:pet_shop/app/lists/new_arrival_list.dart';
import 'package:pet_shop/app/lists/popular_product_list.dart';
import 'package:pet_shop/app/login/forgot_pass_screen.dart';
import 'package:pet_shop/app/login/registration_screen.dart';
import 'package:pet_shop/app/login/reset_password_screen.dart';
import 'package:pet_shop/app/login/verification_screen.dart';
import 'package:pet_shop/app/order/my_order.dart';
import 'package:pet_shop/app/order/track_order.dart';
import 'package:pet_shop/app/payment_mtd/payment_method_screen.dart';
import 'package:pet_shop/app/profile/edit_profile.dart';
import 'package:pet_shop/app/profile/more_screen.dart';
import 'package:pet_shop/app/profile/my_favourite.dart';
import 'package:pet_shop/app/profile/my_profile_screen.dart';
import 'package:pet_shop/base/payment.dart';
import 'app/cart/order_confirm_screen.dart';
import 'app/intro/splash_screen.dart';
import 'app/lists/blog_datail.dart';
import 'app/lists/coupons_screen.dart';
import 'app/login/login_screen.dart';
import 'app/my_address/edit_address_screen.dart';
import 'app/my_address/my_address_screen.dart';
import 'base/get/bottom_selection_controller.dart';
import 'base/get/cart_contr/cart_controller.dart';
import 'base/get/cart_contr/shipping_add_controller.dart';
import 'base/get/home_controller.dart';
import 'base/get/image_controller.dart';
import 'base/get/login_data_controller.dart';

import 'base/get/payment_controller.dart';
import 'base/get/product_data.dart';
import 'base/get/register_data_controller.dart';
import 'base/get/route_key.dart';
import 'base/get/storage_controller.dart';
import 'base/get/store_binding.dart';
import 'base/my_custom_scroll_behavior.dart';
import 'generated/l10n.dart';

Future<void> init() async {
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ProductDataController());
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => PaymentController());

  Get.lazyPut(() => BottomItemSelectionController());
  Get.lazyPut(() => StorageController());
  Get.lazyPut(() => LoginDataController());
  Get.lazyPut(() => RegisterDataController());
  Get.lazyPut(() => ShippingAddressController());
  Get.lazyPut(() => SearchController());
  Get.lazyPut(() => ImageController());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  await GetStorage.init();
  Stripe.publishableKey = Payments.stripPublishKey;
  // Stripe.merchantIdentifier
  // Stripe.stripeAccountId
  Stripe.instance.applySettings();

  runApp(const MyApp());
}

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    configLoading(context);
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        S.delegate,
      ],
      title: 'Grocery',
      initialRoute: "/",
      builder: EasyLoading.init(),
      initialBinding: StoreBinding(),
      theme: controller.theme,
      routes: {
        "/": (context) => const SplashScreen(),
        splashRoute: (context) => const SplashScreen(),
        introRoute: (context) => IntroScreen(),
        loginRoute: (context) => const LoginScreen(),
        registrationRoute: (context) => const RegistrationScreen(),
        homeScreenRoute: (context) => HomeScreen(),
        myOrderScreenRoute: (context) => const MyOrder(),
        forgotPassScreenRoute: (context) => const ForgotPasswordScreen(),
        resetPassScreenRoute: (context) => const ResetPasswordScreen(),
        verificationScreenRoute: (context) => VerificationScreen('', false),
        newArrivalScreenList: (context) => const NewArrivalList(),
        bestSellingScreenList: (context) => const BestSellingList(),
        productDetailScreenRoute: (context) => const ProductDetailScreen(),
        buyNowScreenRoute: (context) => BuyNow(),
        myCartScreenRoute: (context) => const CartScreen(),
        checkoutScreenRoute: (context) => const CheckOut(),
        checkoutShippingScreenRoute: (context) => const CheckOutShippingAdd(),
        checkoutCompleteScreenRoute: (context) => const CheckOutComplete(),
        addBillingScreenRoute: (context) => const AddBillingAddress(),
        trackOrderScreenRoute: (context) => const TrackOrder(),
        editProfileRoute: (context) => const EditProfile(),
        myProfileRoute: (context) => const MyProfileScreen(),
        myFavouriteRoute: (context) => const MyFavourite(),
        categoryScreenRoute: (context) => const CategoryScreen(),
        blogScreenRoute: (context) => const BlogScreen(),
        blogDetailScreenRoute: (context) => const BlogDetailScreen(),
        popularProductScreenRoute: (context) => const PopularProductList(),
        couponsScreenRoute: (context) => const CouponsScreen(),
        orderConfirmScreenRoute: (context) => OrderConfirmScreen(),
        moreScreenRoute: (context) => const MoreScreen(),
        myAddressScreenRoute: (context) => const MyAddressScreen(),
        editAddressScreenRoute: (context) => EditAddressScreen(),
        paymentMethodScreenRoute: (context) => const PaymentMethodScreen(),
        // stripPaymentScreenRoute: (context) => NoWebhookPaymentScreen(),
      },
    );
  }
}
