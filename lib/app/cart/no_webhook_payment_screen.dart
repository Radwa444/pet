// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'package:pet_shop/base/constant.dart';
// import 'package:pet_shop/base/get/payment_controller.dart';
//
// import '../../base/config.dart';
// import 'package:http/http.dart' as http;
//
// class NoWebhookPaymentScreen extends StatefulWidget {
//   @override
//   _NoWebhookPaymentScreenState createState() => _NoWebhookPaymentScreenState();
// }
//
// class _NoWebhookPaymentScreenState extends State<NoWebhookPaymentScreen> {
//   CardFieldInputDetails? _card;
//   PaymentController controller=Get.find<PaymentController>();
//
//   @override
//   Widget build(BuildContext context) {
//     Constant.setupSize(context);
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: CardField(
//               onCardChanged: (card) {
//                 setState(() {
//                   _card = card;
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: TextButton(
//               child: Text("PAY"),
//               onPressed: _handlePayPress,
//               // onPressed: _card?.complete == true ? _handlePayPress : null,
//             ),
//             // child:
//             // LoadingButton(
//             //   onPressed: _card?.complete == true ? _handlePayPress : null,
//             //   text: 'Pay',
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Future<void> _handlePayPress() async {
//   //   print("chkcard===$_card");
//   //   if (_card == null) {
//   //     return;
//   //   }
//   //
//   //   // 1. Gather customer billing information (ex. email)
//   //
//   //   final billingDetails = BillingDetails(
//   //     email: 'email@stripe.com',
//   //     phone: '+48888000888',
//   //     address: Address(
//   //       city: 'Houston',
//   //       country: 'US',
//   //       line1: '1459  Circle Drive',
//   //       line2: '',
//   //       state: 'Texas',
//   //       postalCode: '77063',
//   //     ),
//   //   ); // mocked data for tests
//   //
//   //   // 2. Create payment method
//   //   print("chkcard===$_card");
//   //
//   //   // final paymentMethod =
//   //   // await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(paymentMethodData: PaymentMethodData()));
//   //
//   //   final paymentMethod = await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
//   //     paymentMethodData: PaymentMethodData(
//   //         billingDetails: billingDetails), // billingDetails: billingDetails,
//   //   ));
//   //
//   //   // 3. call API to create PaymentIntent
//   //   final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
//   //     useStripeSdk: true,
//   //     paymentMethodId: paymentMethod.id,
//   //     currency: 'usd', // mocked data
//   //     items: [
//   //       {'id': 'id'}
//   //     ],
//   //   );
//   //
//   //   if (paymentIntentResult['error'] != null) {
//   //     // Error during creating or confirming Intent
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
//   //     return;
//   //   }
//   //
//   //   if (paymentIntentResult['clientSecret'] != null &&
//   //       paymentIntentResult['requiresAction'] == null) {
//   //     // Payment succedeed
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text('Success!: The payment was confirmed successfully!')));
//   //     return;
//   //   }
//   //
//   //   if (paymentIntentResult['clientSecret'] != null &&
//   //       paymentIntentResult['requiresAction'] == true) {
//   //     // 4. if payment requires action calling handleCardAction
//   //     final paymentIntent = await Stripe.instance
//   //         .handleNextAction(paymentIntentResult['clientSecret']);
//   //
//   //     // todo handle error
//   //     /*if (cardActionError) {
//   //       Alert.alert(
//   //       `Error code: ${cardActionError.code}`,
//   //       cardActionError.message
//   //       );
//   //     } else*/
//   //
//   //     if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
//   //       // 5. Call API to confirm intent
//   //       await confirmIntent(paymentIntent.id);
//   //     } else {
//   //       // Payment succedeed
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
//   //     }
//   //   }
//   // }
//   Future<void> _handlePayPress() async {
//
//     controller.makePayment(amount: "5", currency: "USD",);
//     // // final paymentMethod =
//     // // await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(paymentMethodData: PaymentMethodData()));
//     //
//     // if (_card == null) {
//     //   return;
//     // }
//     //
//     // // 1. fetch Intent Client Secret from backend
//     // print("fetch===first");
//     // final clientSecret = await fetchPaymentIntentClientSecret();
//     // print("fetch===second");
//     // // 2. Gather customer billing information (ex. email)
//     // final billingDetails = BillingDetails(
//     //   email: "demo123@gmail.com",
//     //   phone: '+48888000888',
//     //   address: Address(
//     //     city: 'Houston',
//     //     country: 'US',
//     //     line1: '1459  Circle Drive',
//     //     line2: '',
//     //     state: 'Texas',
//     //     postalCode: '77063',
//     //   ),
//     // ); // mo mocked data for tests
//     //
//     // // 3. Confirm payment with card details
//     // // The rest will be done automatically using webhooks
//     // // ignore: unused_local_variable
//     // final paymentIntent = await Stripe.instance.confirmPayment(
//     //   clientSecret['clientSecret'],
//     //   PaymentMethodParams.card(
//     //     paymentMethodData: PaymentMethodData(
//     //       billingDetails: billingDetails,
//     //     ),
//     //     options: PaymentMethodOptions(
//     //       setupFutureUsage: null,
//     //     ),
//     //   ),
//     // );
//     //
//     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //     content: Text('Success!: The payment was confirmed successfully!')));
//   }
//
//   Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
//     var response;
//     try {
//       final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
//       // final url = Uri.parse('$kApiUrl/create-payment-intent');
//        response = await http.post(
//             url,
//          headers: {
//            'Authorization': 'Bearer sk_test_utRGU4wkG19w3o3dCsu4N42b00hRPKIwiJ',
//            'Content-Type': 'application/x-www-form-urlencoded'
//          },
//             body: json.encode({
//               'email': "_demo123@gmail.com",
//               'currency': 'inr',
//               'items': [
//                 {'id': 'id'}
//               ],
//               'request_three_d_secure': 'any',
//             }),
//           );
//     } catch (e) {
//       print(e);
//       print("fetcherr===${e.toString()}");
//     }
//     print("fetcherrres===${response.body}");
//
//     return json.decode(response.body);
//   }
//
//
//   Future<void> confirmIntent(String paymentIntentId) async {
//     final result = await callNoWebhookPayEndpointIntentId(
//         paymentIntentId: paymentIntentId);
//     if (result['error'] != null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Success!: The payment was confirmed successfully!')));
//     }
//   }
//
//   Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
//     required String paymentIntentId,
//   }) async {
//     final url = Uri.parse('$kApiUrl/charge-card-off-session');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({'paymentIntentId': paymentIntentId}),
//     );
//     return json.decode(response.body);
//   }
//
//   Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
//     required bool useStripeSdk,
//     required String paymentMethodId,
//     required String currency,
//     List<Map<String, dynamic>>? items,
//   }) async {
//     final url = Uri.parse('$kApiUrl/charge-card-off-session');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'useStripeSdk': useStripeSdk,
//         'paymentMethodId': paymentMethodId,
//         'currency': currency,
//         'items': items
//       }),
//     );
//     return json.decode(response.body);
//   }
// }
