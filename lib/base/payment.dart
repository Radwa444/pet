import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/model/woo_payment_gateway.dart';
import 'package:pet_shop/woocommerce/model/customer.dart';

import '../app/model/cart_other_info.dart';
import '../app/model/model_dummy_selected_add.dart';
import 'get/home_controller.dart';
import 'get/payment_controller.dart';

List<ModelItems> modelItemsFromJson(String str) =>
    List<ModelItems>.from(json.decode(str).map((x) => ModelItems.fromJson(x)));

String modelItemsToJson(List<ModelItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelItems {
  ModelItems({
    this.name,
    this.quantity,
    this.price,
    this.currency,
  });

  String? name;
  int? quantity;
  String? price;
  String? currency;

  factory ModelItems.fromJson(Map<String, dynamic> json) => ModelItems(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "currency": currency,
      };
}

//   item_list
//   String? name,price,currency;
//   int? quantity;
//
//   ModelItems(this.name, this.price, this.currency, this.quantity);
//
// // "name": "A demo product",
// // "quantity": 1,
// // "price": '10.12',
// // "currency": "USD"
// }
class Payments {
  static String stripPublishKey = "pk_test_N6NJ1Jxf7HPbb1yOcv1CWush";

  // static String stripPublishKey="pk_test_kGEVXq7ga94dcLBUZJbdQu9500lLQ5lcyQ";
  static String stripSecretKey = "sk_test_7egudPvPeeoRU8pdAp4DY2ty";

  // static String stripSecretKey="sk_test_utRGU4wkG19w3o3dCsu4N42b00hRPKIwiJ";

  static Future<dynamic> getResponse() async {
    var res = await rootBundle.loadString('assets/country.json');
    return jsonDecode(res);
  }

  static Future<String> getCountriesISO(String con) async {
    // List<String> _country=[];

    var countries = await getResponse() as List;
    for (int i = 0; i < countries.length; i++) {
      String name = countries[i]['name'];
      if (name == con) {
        // return "IN";
        return countries[i]['code'].toString().toUpperCase();
      }
    }
    // countries.forEach((data) {
    //   String name = data['name'];
    //   if(name==con)
    //     {
    //       return data['emoji'];
    //     }
    //   // var model = Country();
    //   // model.name = data['name'];
    //   // model.emoji = data['emoji'];
    //   // if (!mounted) return;
    //   // setState(() {
    //   //   widget.flagState == CountryFlag.ENABLE ||
    //   //       widget.flagState == CountryFlag.SHOW_IN_DROP_DOWN_ONLY
    //   //       ? _country.add(model.emoji! +
    //   //       "    " +
    //   //       model.name!) /* : _country.add(model.name)*/
    //   //       :
    //   //   _country.add(model.name!);
    //   // });
    // });
    // // _setDefaultCountry();
    return "";
  }

  static completePaymentProgress(
      BuildContext context,
      WooPaymentGateway paymentGateway,
      Function afterComplete,
      WooCustomer wooCustomer,
      String total,
      String subTotal,
      String tax,
      String shipping,
      List<CartOtherInfo> items,
      ModelDummySelectedAdd selectedAdd,
      ValueChanged<bool> notify) async {
    // String currency=Constant.getCurrency(context);
    HomeController homeController = Get.find<HomeController>();
    PaymentController controller = Get.find<PaymentController>();

    String currency = homeController.wooCurrentCurrency!.code!;
    List<ModelItems> list = [];
    String listCountry = await getCountriesISO(selectedAdd.country);
    items.forEach((element) {
      list.add(ModelItems(
          name: element.productName,
          price: element.productPrice.toString(),
          currency: currency,
          quantity: element.quantity));
    });
    print("addModel=--$listCountry=${jsonEncode(list)}");
    print("nam,e===--=${paymentGateway.id}");
    print("nam,e===--=$subTotal--$tax");
    switch (paymentGateway.id) {
      case "bacs":
        break;
      case "cod":
        /* cash on delivery */
        EasyLoading.dismiss();
        notify(false);
        afterComplete();

        break;
      case "stripe":
        EasyLoading.dismiss();
        // Constant.sendToNext(context, stripPaymentScreenRoute);
        controller.makePayment(
            amount: total,
            currency: currency,
            complete: afterComplete,
            notify: notify);
        // controller.makePayment(amount:"10.25", currency: currency,complete: afterComplete);

        /* stripe */

        break;
      case "ppec_paypal":
      case "ppcp-gateway":
        /*paypal*/
        //
        EasyLoading.dismiss();

        Future.delayed(
          Duration.zero,
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                    sandboxMode: true,
                    clientId:
                        "AR8K1cxjLTXNYbgsUicWPMD-UZknVed-j_sXKJk22tTN4POUbfqKP9aOYrGOLem1TPip0G8XAyReePMS",
                    secretKey:
                        "EBJdP53bc_bpJGGyCD66_Ik-b4SkMH_Ap3rFTSd31OM4i2osbvrAAjD1zSAfCFqqwUGbtKvLj5vez5lB",
                    // clientId:"AW_YxlMFehGPWh-5Ics8dlXW6Oys_FZM3IdcfllpyQfVeOkhmY_ThCuCJYwR7-AI8EXByXlf4SnqSY9o",
                    // secretKey: "EHMMtO_JVaOdtOpI_ebq6ipM2GbyNf3jyZbOqju74e7aOHMwL9peDQrvdQnEAu9vAeqmkes9Hp-6JxI3",
                    returnURL: "https://samplesite.com/return",
                    cancelURL: "https://samplesite.com/cancel",
                    transactions: [
                      {
                        "amount": {
                          "total": total,
                          "currency": currency,
                          "details": {
                            "subtotal": subTotal,
                            "tax": tax,
                            "shipping": shipping,
                          }
                        },
                        "description": "The WooWach Payment",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },

                        "item_list": {
                          "items": list
                          // jsonEncode(list)
                          // [
                          //   {
                          //     "name": "A demo product",
                          //     "quantity": 1,
                          //     "price": '10.12',
                          //     "currency": "USD"
                          //   }
                          // ]
                          ,

                          // shipping address is not required though
                          "shipping_address": {
                            "recipient_name":
                                "${selectedAdd.firstName} ${selectedAdd.lastName}",
                            "line1": selectedAdd.address1,
                            "line2": selectedAdd.address2,
                            "city": selectedAdd.city,
                            // "country": selectedAdd.country,
                            "country_code": listCountry,
                            "postal_code": selectedAdd.postcode,
                            "phone": wooCustomer.billing!.phone ?? "",
                            "state": selectedAdd.state
                          },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                      EasyLoading.dismiss();
                      afterComplete();
                    },
                    onError: (error) {
                      print("onError: $error");
                    },
                    onCancel: (params) {
                      EasyLoading.dismiss();
                      print('cancelled: $params');
                    }),
              ),
            );
          },
        );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => UsePaypal(
        //         sandboxMode: true,
        //         clientId:
        //             "AR8K1cxjLTXNYbgsUicWPMD-UZknVed-j_sXKJk22tTN4POUbfqKP9aOYrGOLem1TPip0G8XAyReePMS",
        //         secretKey:
        //             "EBJdP53bc_bpJGGyCD66_Ik-b4SkMH_Ap3rFTSd31OM4i2osbvrAAjD1zSAfCFqqwUGbtKvLj5vez5lB",
        //         // clientId:"AW_YxlMFehGPWh-5Ics8dlXW6Oys_FZM3IdcfllpyQfVeOkhmY_ThCuCJYwR7-AI8EXByXlf4SnqSY9o",
        //         // secretKey: "EHMMtO_JVaOdtOpI_ebq6ipM2GbyNf3jyZbOqju74e7aOHMwL9peDQrvdQnEAu9vAeqmkes9Hp-6JxI3",
        //         returnURL: "https://samplesite.com/return",
        //         cancelURL: "https://samplesite.com/cancel",
        //         transactions: [
        //           {
        //             "amount": {
        //               "total": total,
        //               "currency": currency,
        //               "details": {
        //                 "subtotal": subTotal,
        //
        //                 // "subtotal": '10.12',
        //                 "shipping": '0',
        //                 "shipping_discount": 0
        //               }
        //             },
        //             "description": "The WooWach Payment",
        //             // "payment_options": {
        //             //   "allowed_payment_method":
        //             //       "INSTANT_FUNDING_SOURCE"
        //             // },
        //
        //             "item_list": {
        //               "items": list
        //               // jsonEncode(list)
        //               // [
        //               //   {
        //               //     "name": "A demo product",
        //               //     "quantity": 1,
        //               //     "price": '10.12',
        //               //     "currency": "USD"
        //               //   }
        //               // ]
        //               ,
        //
        //               // shipping address is not required though
        //               "shipping_address": {
        //                 "recipient_name":
        //                     selectedAdd.firstName + " " + selectedAdd.lastName,
        //                 "line1": selectedAdd.address1,
        //                 "line2": selectedAdd.address2,
        //                 "city": selectedAdd.city,
        //                 // "country": selectedAdd.country,
        //                 "country_code": listCountry,
        //                 "postal_code": selectedAdd.postcode,
        //                 "phone": wooCustomer.billing!.phone ?? "",
        //                 "state": selectedAdd.state
        //               },
        //             }
        //           }
        //         ],
        //         note: "Contact us for any questions on your order.",
        //         onSuccess: (Map params) async {
        //           print("onSuccess: $params");
        //           EasyLoading.dismiss();
        //           afterComplete();
        //         },
        //         onError: (error) {
        //           print("onError: $error");
        //         },
        //         onCancel: (params) {
        //           EasyLoading.dismiss();
        //           print('cancelled: $params');
        //         }),
        //   ),
        // );
        break;
      case "ppcp-credit-card-gateway":
        break;
    }
  }
}
