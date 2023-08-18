import 'package:pet_shop/app/model_ui/model_best_selling_pro.dart';
import 'package:pet_shop/app/model_ui/model_blog.dart';
import 'package:pet_shop/app/model_ui/model_cart.dart';
import 'package:pet_shop/app/model_ui/model_category.dart';
import 'package:pet_shop/app/model_ui/model_coupons.dart';
import 'package:pet_shop/app/model_ui/model_favourite.dart';
import 'package:pet_shop/app/model_ui/model_payment_method.dart';
import '../app/model/model_bottom_nav.dart';
import '../app/model/model_intro.dart';
import '../app/model_ui/model_order.dart';
import '../app/model_ui/model_popular_product.dart';
import '../app/model_ui/model_sub_category.dart';

class DataFile {
  static List<ModelBottomNav> getAllBottomNavList() {
    List<ModelBottomNav> bottomList = [];

    bottomList.add(ModelBottomNav("Home", "home.svg", "home_selected.svg"));
    // bottomList.add(ModelBottomNav("Category", "home.svg", "home_selected.svg"));
    bottomList
        .add(ModelBottomNav("Search", "search.svg", "search_selected.svg"));
    bottomList.add(ModelBottomNav("Cart", "bag.svg", "bag_filled.svg"));
    bottomList.add(
        ModelBottomNav("Heart", "bottom_nav_fav.svg", "heart_selected.svg"));
    bottomList
        .add(ModelBottomNav("Profile", "profile.svg", "profile_selected.svg"));

    return bottomList;
  }

  static List<ModelIntro> getAllIntroList() {
    List<ModelIntro> list = [];
    list.add(ModelIntro(
        "Healthy & Tasty \nFood For Pets",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
        "intro1.png"));

    list.add(ModelIntro(
        "Upgrade Your Pets & \nMake It More Stylist",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
        "intro2.png"));

    list.add(ModelIntro(
        "Lorem ipsum dolor sit \namet, consectetur ",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
        "intro3.png"));

    list.add(ModelIntro(
        "Lorem ipsum dolor sit \namet, consectetur ",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
        "intro4.png"));

    return list;
  }

  static List<ModelPopularProduct> getAllPopularProductList() {
    List<ModelPopularProduct> list = [];

    list.add(ModelPopularProduct("popular1.png", "Pet Paw Cleaner", "\$26.00"));
    list.add(ModelPopularProduct("popular2.png", "Dry Food Mini", "\$30.00"));
    list.add(ModelPopularProduct("popular3.png", "Hand Brush", "\$26.00"));
    list.add(ModelPopularProduct("popular4.png", "Fur Care Glove", "\$30.00"));
    list.add(ModelPopularProduct("popular5.png", "Fur Care Glove", "\$19.00"));
    list.add(ModelPopularProduct("popular6.png", "Pets Grooming", "\$10.00"));
    return list;
  }

  static List<ModelCategory> getAllCategory() {
    List<ModelCategory> list = [];
    list.add(ModelCategory("cat1.png", "Cat"));
    list.add(ModelCategory("cat2.png", "Dog"));
    list.add(ModelCategory("cat3.png", "Perrot"));
    list.add(ModelCategory("cat4.png", "Rabbit"));
    list.add(ModelCategory("cat1.png", "Fish"));
    list.add(ModelCategory("cat1.png", "Turtle"));
    return list;
  }

  static List<ModelSubCategory> getAllSubCategory() {
    List<ModelSubCategory> list = [];
    list.add(ModelSubCategory("subCat_1.png", "Dry Food"));
    list.add(ModelSubCategory("subCat_2.png", "Treats"));
    list.add(ModelSubCategory("subCat_3.png", "Ring Toy"));
    list.add(ModelSubCategory("subCat_4.png", "COf Roll"));
    list.add(ModelSubCategory("subCat_5.png", "Glove"));
    list.add(ModelSubCategory("subCat_6.png", "Cleaner"));
    list.add(ModelSubCategory("subCat_7.png", "Brush"));
    list.add(ModelSubCategory("subCat_8.png", "Pedigree"));
    list.add(ModelSubCategory("subCat_9.png", "Fur Care"));
    list.add(ModelSubCategory("subCat_10.png", "F&T Collar"));
    return list;
  }

  static List<ModelBlog> getAllBlog() {
    List<ModelBlog> list = [];
    list.add(ModelBlog("Lbendum est ultricies integer quis auctor.",
        "blog1.png", "28 Sep,2022"));
    list.add(ModelBlog(
        "Non enim praesent elementum facilisis.", "blog2.png", "26 Sep,2022"));
    list.add(ModelBlog("Ut venenatis tellus in metus vulputate eu scelerisque.",
        "blog3.png", "20 Sep,2022"));
    list.add(ModelBlog("Arcu vitae elementum curabitur vitae nunc ",
        "blog4.png", "20 Sep,2022"));
    return list;
  }

  static List<ModelBestSellingProduct> getAllBestSellProduct() {
    List<ModelBestSellingProduct> list = [];
    list.add(ModelBestSellingProduct(
        "best_sell_1.png", "Healthy Treats", "\$12.00"));
    list.add(ModelBestSellingProduct(
        "best_sell_2.png", "Pedigree Nutritions", "\$30.00"));
    list.add(ModelBestSellingProduct(
        "best_sell_4.png", "Rope Leash For Dog", "\$40.00"));
    list.add(
        ModelBestSellingProduct("best_sell_3.png", "Dry Food Mini", "\$30.00"));
    list.add(
        ModelBestSellingProduct("best_sell_5.png", "Pet Ring Toy", "\$80.00"));
    list.add(ModelBestSellingProduct(
        "best_sell_6.png", "Chiken & COD Roll", "\$20.00"));
    return list;
  }

  static List<ModelCart> getAllCartList() {
    List<ModelCart> list = [];
    list.add(ModelCart('best_sell_4.png', "Dog Rope Leash", "\$30.00", "3",
        attribute: {"color": "Blue", "size": "5 Feet"}));
    list.add(ModelCart('best_sell_1.png', "Healthy Treats", "\$20.00", "3"));
    list.add(ModelCart('best_sell_3.png', "Dry Food", "\$30.00", "3"));
    return list;
  }

  static List<ModelCoupons> getAllCouponsList() {
    List<ModelCoupons> list = [];
    list.add(ModelCoupons(
        "10% Off",
        "Mauris nunc congue nisi vitae suscipit tellus mauris a",
        "12 Oct,2022",
        "QWE874"));
    list.add(ModelCoupons(
        "15% Off",
        "Ac tincidunt vitae semper quis. Pellentesque adipiscing com ",
        "18 Oct,2022",
        "BAC7414"));
    list.add(ModelCoupons(
        "20% Off",
        "Ac tincidunt vitae semper quis. Pellentesque adipiscing com ",
        "18 Oct,2022",
        "PWQ589"));
    return list;
  }

  static List<ModelPaymentMtd> getAllPaymentMthList() {
    List<ModelPaymentMtd> list = [];
    list.add(
        ModelPaymentMtd("paypal.svg", "Paypal", num: "XXXX XXXX XXXX 2563"));
    list.add(ModelPaymentMtd(
      "money.svg",
      "Cash On Delivery",
    ));
    list.add(ModelPaymentMtd(
      "Stripe.svg",
      "Stripe",
    ));
    return list;
  }

  static List<ModelOrder> getAllOrderList() {
    List<ModelOrder> list = [];
    list.add(ModelOrder("74123698", "1", "8 July,2022", "\$60.00", "Pending"));
    list.add(ModelOrder("5231874", "3", "8 July,2022", "\$20.00", "cancelled"));
    list.add(
        ModelOrder("74123698", "1", "8 July,2022", "\$60.00", "Delivered"));
    list.add(
        ModelOrder("87456932", "2", "11 July,2022", "\$40.00", "Delivered"));
    return list;
  }

  static List<ModelFavourite> getAllFavList() {
    List<ModelFavourite> list = [];
    list.add(ModelFavourite("best_sell_5.png", "Pet Ring Toy", "\$80.00"));
    list.add(ModelFavourite("best_sell_6.png", "Chiken & COD Roll", "\$20.00"));
    list.add(ModelFavourite("popular6.png", "Pets Grooming", "\$80.00"));
    list.add(ModelFavourite("subCat_10.png", "F&T Collar Dog", "\$80.00"));
    list.add(ModelFavourite("best_sell_3.png", "Dry Food", "\$80.00"));
    list.add(
        ModelFavourite("best_sell_4.png", "Rope Leash For Dog", "\$80.00"));
    return list;
  }
}
