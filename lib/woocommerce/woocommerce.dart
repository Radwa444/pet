/*
 * BSD 3-Clause License

    Copyright (c) 2020, RAY OKAAH - MailTo: ray@flutterengineer.com, Twitter: Rayscode
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 */

/// The WooCommerce SDK for Flutter. Bringing your ecommerce app to life easily with Flutter and Woo Commerce.

import "dart:collection";
import 'dart:convert';
import 'dart:io';
import "dart:math";
import "dart:core";
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';

// ignore: library_prefixes
import 'package:dio/dio.dart' as DioLib;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_shop/app/model/model_banner.dart';
import 'package:pet_shop/app/model/model_dummy_selected_add.dart';
import 'package:pet_shop/base/get/home_controller.dart';
import 'package:pet_shop/base/get/storage.dart';
import 'package:pet_shop/base/widget_utils.dart';
import 'package:pet_shop/woocommerce/model/model_shipping_zones.dart';
import 'package:pet_shop/woocommerce/model/model_tax.dart';
import 'package:pet_shop/woocommerce/model/woo_get_created_order.dart';

import '../app/model/order_create_model.dart';
import '../app/model/product_review.dart';
import '../app/model/retrieve_coupon.dart';
import '../app/model/woo_payment_gateway.dart';
import 'constants.dart';
import 'model/cart.dart';
import 'model/cart_item.dart';
import 'model/current_currency.dart';
import 'model/customer.dart';
import 'model/jwt_response.dart';
import 'model/model_reset_pass_request.dart';
import 'model/model_shipping_method.dart';
import 'model/product_category.dart';
import 'model/product_variation.dart';
import 'model/products.dart';
import 'model/user.dart';
import 'utils/local_db.dart';
import 'woocommerce_error.dart';

export 'woocommerce_error.dart' show WooCommerceError;

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

/// Create a new Instance of [WooCommerce] and pass in the necessary parameters into the constructor.
///
/// For example
/// ``` WooCommerce myApi = WooCommerce(
///   baseUrl: yourbaseUrl, // For example  http://mywebsite.com or https://mywebsite.com or http://cs.mywebsite.com
///   consumerKey: consumerKey,
///  consumerSecret: consumerSecret);
///  ```

class WooCommerce {
  /// Parameter, [baseUrl] is the base url of your site. For example, http://me.com or https://me.com.
  late String baseUrl;

  /// Parameter [consumerKey] is the consumer key provided by WooCommerce, e.g. `ck_12abc34n56j`.
  String? consumerKey;

  /// Parameter [consumerSecret] is the consumer secret provided by WooCommerce, e.g. `cs_1uab8h3s3op`.
  String? consumerSecret;

  /// Returns if the website is https or not based on the [baseUrl] parameter.
  bool? isHttps;

  /// Parameter(Optional) [apiPath], tells the SDK if there is a different path to your api installation.
  /// Useful if the websites woocommerce api path have been modified.
  late String apiPath;

  /// Parameter(Optional) [isDebug], tells the library if it should _printToLog debug logs.
  /// Useful if you are debuging or in development.
  late bool isDebug;

  WooCommerce({
    required String baseUrl,
    required String consumerKey,
    required String consumerSecret,
    String apiPath = DEFAULT_WC_API_PATH,
    bool isDebug = false,
  }) {
    // ignore: prefer_initializing_formals
    this.baseUrl = baseUrl;
    // ignore: prefer_initializing_formals
    this.consumerKey = consumerKey;
    // ignore: prefer_initializing_formals
    this.consumerSecret = consumerSecret;
    // ignore: prefer_initializing_formals
    this.apiPath = apiPath;
    // ignore: prefer_initializing_formals
    this.isDebug = isDebug;

    if (this.baseUrl.startsWith("https")) {
      isHttps = true;
    } else {
      isHttps = false;
    }
  }

  void _printToLog(String message) {
    if (isDebug) {
      debugPrint("WOOCOMMERCE LOG : $message");
    }
  }

  String? _authToken;

  String? get authToken => _authToken;

  Uri? queryUri;

  String get apiResourceUrl => queryUri.toString();

  // Header to be sent for JWT authourization
  final Map<String, String> _urlHeader = {'Authorization': ''};

  String get urlHeader => _urlHeader['Authorization'] = 'Bearer ${authToken!}';
  LocalDatabaseService localDbService = LocalDatabaseService();

  /// Authenticates the user using WordPress JWT authentication and returns the access [_token] string.
  ///
  /// Associated endpoint : yourwebsite.com/wp-json/jwt-auth/v1/token
  Future authenticateViaJWT({String? username, String? password}) async {
    final body = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(
        baseUrl + URL_JWT_TOKEN,
      ),
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      WooJWTResponse authResponse =
          WooJWTResponse.fromJson(json.decode(response.body));
      _authToken = authResponse.data!.token ?? "";
      localDbService.updateSecurityToken(_authToken);
      _urlHeader['Authorization'] = 'Bearer $_authToken';
      // _urlHeader['Authorization'] = 'Bearer ${authResponse.token}';
      return _authToken;
    } else {
      showCustomToast(jsonDecode(response.body)["message"] ?? "");

      throw WooCommerceError.fromJson(json.decode(response.body));
    }
  }

  Future authentica1111({String? username, String? password}) async {
    String v =
        'https://public-api.wordpress.com/rest/v3/sites/devsite.clientdemoweb.com/users';

    // String url = "$v&consumer_key=${consumerKey!}&consumer_secret=${consumerSecret!}";
    String token = await localDbService.getSecurityToken();
    String bearerToken = "Bearer $token";
    _printToLog('this is the bearer token : $bearerToken');
    //
    Map<String, String> headers = HashMap();
    // headers ??= HashMap();
    // if (withAuth) {
    headers['Authorization'] = bearerToken;
    // }
    headers.putIfAbsent('Accept', () => 'application/json charset=utf-8');

    final response = await http.get(
        Uri.parse(
          v,
        ),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // WooJWTResponse authResponse =
      //     WooJWTResponse.fromJson(json.decode(response.body));
      // _authToken = authResponse.data!.token ?? "";
      // _localDbService.updateSecurityToken(_authToken);
      // _urlHeader['Authorization'] = 'Bearer $_authToken';
      // // _urlHeader['Authorization'] = 'Bearer ${authResponse.token}';
      return _authToken;
    } else {
      // showCustomToast(jsonDecode(response.body)["message"] ?? "");

      // throw WooCommerceError.fromJson(json.decode(response.body));
    }
  }

  /// Authenticates the user via JWT and returns a WooCommerce customer object of the current logged in customer.
  loginCustomer({
    required String username,
    required String password,
  }) async {
    WooCustomer? customer;
    try {
      var response =
          await authenticateViaJWT(username: username, password: password);
      _printToLog('attempted token : $response');
      if (response is String) {
        int? id = await fetchLoggedInUserId();
        customer = await getCustomerById(id: id);
      }

      return customer;
    } catch (e) {
      // if(response["success"]==false)
      //   {
      //
      //   }

      return e.toString();
    }
  }

  /// Confirm if a customer is logged in [true] or out [false].
  Future<bool> isCustomerLoggedIn() async {
    String sToken = await localDbService.getSecurityToken();
    if (sToken == '0') {
      return false;
    } else {
      return true;
    }
  }

  /// Fetches already authenticated user, using Jwt
  ///
  /// Associated endpoint : /wp-json/wp/v2/users/me
  Future<int?> fetchLoggedInUserId() async {
    _authToken = await localDbService.getSecurityToken();
    _urlHeader['Authorization'] = 'Bearer ${_authToken!}';
    final response =
        await http.get(Uri.parse(baseUrl + URL_USER_ME), headers: _urlHeader);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonStr = json.decode(response.body);
      if (jsonStr.length == 0) {
        throw WooCommerceError(
            code: 'wp_empty_user',
            message: "No user found or you dont have permission");
      }
      _printToLog('account user fetch : $jsonStr');
      return jsonStr['id'];
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }

  /// Log User out
  ///
  logUserOut() async {
    await localDbService.deleteSecurityToken();
  }

  /// Creates a new Wordpress user and returns whether action was sucessful or not using WP Rest User Wordpress plugin.
  ///
  /// Associated endpoint : /register .

  Future<bool> registerNewWpUser({required WooUser user}) async {
    String url = baseUrl + URL_REGISTER_ENDPOINT;

    http.Client client = http.Client();
    http.Request request = http.Request('POST', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.body = json.encode(user.toJson());
    String response =
        await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    _printToLog('registerNewUser response : $dataResponse');
    if (dataResponse['data'] == null) {
      return true;
    } else {
      throw Exception(WooCommerceError.fromJson(dataResponse).toString());
    }
  }

  Future<List<ModelBanner>> getBanner({WooUser? user}) async {
    String url = baseUrl + URL_GET_MEDIA;

    Map<String, String> map = {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
      HttpHeaders.cacheControlHeader: "no-cache"
    };
    http.Response response = await http.get(Uri.parse(url), headers: map);
    if (isValidResponse(response)) {
      List parseList = jsonDecode(response.body);
      List<ModelBanner> bannerList = [];
      parseList.map((e) {
        if (e["alt_text"] == "banner") {
          bannerList.add(ModelBanner.fromJson(e));
        }
      }).toList();
      return bannerList;
    } else {
      throw Exception(
          WooCommerceError.fromJson(json.decode(response.body)).toString());
    }
  }

  String getResetPassAuthURl(String url) {
    return "$url?consumer_key=${consumerKey!}&consumer_secret=${consumerSecret!}";
  }

  Future<dynamic> postForgetPass(String endPoint, Map data,
      {String? nonse, bool withAuthorization = false}) async {
    String url = endPoint;
    // String url = _getOAuthURL("POST", endPoint);
    _urlHeader[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    // if (nonse != null) {
    //   _urlHeader["Nonce"] = nonse;
    //   // _urlHeader["x-wc-store-api-nonce"] = nonse;
    // }

    // print("getnonce===${_urlHeader["Nonce"]}");
    if (withAuthorization) {
      _urlHeader['Authorization'] = 'Bearer $_authToken';
    }
    _urlHeader[HttpHeaders.cacheControlHeader] = "no-cache";

    DioLib.Response response = await Dio().post(url,
        options: DioLib.Options(headers: _urlHeader), data: json.encode(data));
    // http.Response response = await http.post(Uri.parse(url), headers: _urlHeader, body: json.encode(data));
    getNounceFromRes(response);

    try {
      var dataResponse = await json.decode(response.data.toString());
      return dataResponse;
    } catch (e) {
      _handleError(response);
    }
    // return null;
  }

  Future<ModelResetPassRequest?> resetPassApply(String email,
      {bool withAuthorization = false}) async {
    String url = getResetPassAuthURl("$baseUrl/$URL_RESET_PASS");

    Map<String, String> map = {"email": email};

    final response = await postForgetPass(url, map, withAuthorization: true);

    getNounceFromRes(response);

    if (isValidResponse(response)) {
      ModelResetPassRequest cus = ModelResetPassRequest.fromJson(response);
      return cus;
    } else {
      throw Exception(
          WooCommerceError.fromJson(json.decode(response.body)).toString());
    }
  }

  bool isValidResponse(http.Response response) {
    return response.statusCode == 200;
  }

  Future<bool> createCustomer(WooCustomer customer) async {
    _printToLog('Creating Customer With info : $customer');
    _setApiResourceUrl(path: 'customers');
    final response = await post(queryUri.toString(), customer.toJson());
    _printToLog('created customer : $response');
    try {
      // final cus = WooCustomer.fromJson(response);
      return true;
    } catch (e) {
      showCustomToast(Bidi.stripHtmlIfNeeded(response["message"] ?? ""));
    }
    return false;
  }

  /// Returns a list of all [WooCustomer], with filter options.
  ///
  /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#customers
  Future<List<WooCustomer>> getCustomers(
      {int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      //String email,
      String? role}) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page, 'per_page': perPage, 'search': search,

      'exclude': exclude, 'include': include, 'offset': offset,
      'order': order, 'orderby': orderBy, //'email': email,
      'role': role,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });

    List<WooCustomer> customers = [];
    _setApiResourceUrl(path: 'customers', queryParameters: payload);

    final response = await get(queryUri.toString());
    _printToLog('response gotten : $response');
    for (var c in response) {
      var customer = WooCustomer.fromJson(c);
      _printToLog('customers here : $customer');
      customers.add(customer);
    }
    return customers;
  }

  /// Returns a [WooCustomer], whoose [id] is specified.
  Future<WooCustomer> getCustomerById({required int? id}) async {
    WooCustomer customer;
    _setApiResourceUrl(
      path: 'customers/$id',
    );
    final response = await get(queryUri.toString());
    customer = WooCustomer.fromJson(response);
    return customer;
  }

  Future<List<WooPaymentGateway?>> getPaymentGateways() async {
    List<WooPaymentGateway?> gateways = [];
    _setApiResourceUrl(path: 'payment_gateways');
    String url = _getOAuthURL("GET", queryUri.toString());

    var res = await http.get(Uri.parse(url));
    if (isValidResponse(res)) {
      dynamic response = json.decode(res.body);
      for (var g in response) {
        var sMethod = WooPaymentGateway.fromJson(g);
        _printToLog('shipping zone locations gotten here : $sMethod');
        gateways.add(sMethod);
      }
    }
    return gateways;
  }

  Future<bool> createOrder(
      WooCustomer retrieveCustomer,
      List<LineItems> lineItems,
      String paymentName,
      bool setPaid,
      ModelDummySelectedAdd selectAdd,
      List<CouponLines> coupons,
      List<ShippingLines> shipping) async {
    _setApiResourceUrl(
      path: 'orders',
    );
    Map<String, dynamic> data = {
      'payment_method': paymentName,
      'payment_method_title': paymentName,
      'customer_id': retrieveCustomer.id,
      'set_paid': setPaid,
      'billing': {"phone": retrieveCustomer.billing!.phone},
      "shipping": {
        "first_name": selectAdd.firstName,
        "last_name": selectAdd.lastName,
        "address_1": selectAdd.address1,
        "address_2": selectAdd.address2,
        "city": selectAdd.city,
        "state": selectAdd.state,
        "postcode": selectAdd.postcode,
        "country": selectAdd.country
      },
      "tax_class": "zero-rate",
      "line_items": lineItems,
      "coupon_lines": coupons,
      "shipping_lines": shipping
    };
    final response = await post(queryUri.toString(), data);

    if (response != null) {
      try {
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<double> retrieveCoupon(String couponCode, double totalAmount) async {
    // RetrieveCoupon coupons = RetrieveCoupon();

    double amount = 0;
    _setApiResourceUrl(path: 'coupons', queryParameters: {"code": couponCode});

    final response1 = await get(
      queryUri.toString(),
    );
    try {
      List response = response1;
      List<RetrieveCoupon> couponList =
          response.map((e) => RetrieveCoupon.fromJson(e)).toList();

      if (couponList.isNotEmpty) {
        RetrieveCoupon coupons = couponList[0];
        if (coupons.discountType == 'percent') {
          amount =
              ((totalAmount * double.parse(coupons.amount.toString()) / 100));
        } else if (coupons.discountType == 'fixed_cart') {
          amount = double.parse(coupons.amount.toString());
        }
        return amount;
      } else {
        return amount;
      }
    } catch (e) {
      return amount;
    }
  }

  Future<WooCustomer> updateCustomer({required int id, Map? data}) async {
    _printToLog('Updating customer With customerId : $id');
    _setApiResourceUrl(
      path: 'customers/$id',
    );
    final response = await put(queryUri.toString(), data!);

    WooCustomer customer = WooCustomer.fromJson(response);
    setCurrentUser(customer);
    return customer;
  }

  Future<WooCustomer> updateCustomerWithImage(
      {required int id,
      Map<String, String>? data,
      required String imgPath}) async {
    _printToLog('Updating customer With customerId : $id');
    _setApiResourceUrl(
      path: 'customers/$id',
    );
    var multipartFile =
        await http.MultipartFile.fromPath('avatar_url', imgPath);
    final response =
        await putMultiPart(queryUri.toString(), data!, multipartFile);
    WooCustomer customer = WooCustomer.fromJson(response);
    setCurrentUser(customer);
    return customer;
  }

  Future<WooCustomer> updateCustomerShipping(
      {required int id, required Shipping data}) async {
    _printToLog('Updating customer With customerId : $id');
    _setApiResourceUrl(
      path: 'customers/$id',
    );
    final response = await put(queryUri.toString(), {
      "shipping": {
        "first_name": data.firstName ?? "",
        "last_name": data.lastName ?? "",
        "address_1": data.address1 ?? "",
        "address_2": data.address2 ?? "",
        "city": data.city ?? "",
        "state": data.state ?? "",
        "postcode": data.postcode ?? "",
        "country": data.country ?? ""
      }
    });

    WooCustomer customer = WooCustomer.fromJson(response);
    setCurrentUser(customer);
    return customer;
  }

//
//   /// Deletes an existing Customer and returns the [WooCustomer] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#customer-properties.
//
//   Future<WooCustomer> deleteCustomer(
//       {required int customerId, reassign}) async {
//     Map data = {
//       'force': true,
//     };
//     if (reassign != null) data['reassign'] = reassign;
//     _printToLog('Deleting customer With customerId : ' + customerId.toString());
//     _setApiResourceUrl(
//       path: 'customers/' + customerId.toString(),
//     );
//     final response = await delete(queryUri.toString(), data);
//     return WooCustomer.fromJson(response);
//   }
//
//   /// Returns a list of all [WooProduct], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#products.

  Future<WooGetCreatedOrder> updateOrderStatus(
      {required int id, required String status}) async {
    _printToLog('Updating orderId : $id');
    _setApiResourceUrl(
      path: 'orders/$id',
    );

    final response = await post(queryUri.toString(), {"status": status});

    WooGetCreatedOrder orders = WooGetCreatedOrder.fromJson(response);
    return orders;
  }

  Future<List<WooProduct>> getProducts(
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      String? order,
      String? orderBy,
      String? slug,
      String? status,
      String? type,
      String? sku,
      String? category,
      String? tag,
      String? shippingClass,
      String? attribute,
      String? attributeTerm,
      String? taxClass,
      String? minPrice,
      String? maxPrice,
      String? stockStatus,
      List<int>? exclude,
      List<int>? parentExclude,
      List<int>? include,
      List<int>? parent,
      int? offset,
      int? ratingCount,
      bool? featured,
      bool? onSale}) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': perPage,
      'search': search,
      'after': after,
      'before': before,
      'exclude': exclude,
      'include': include,
      'offset': offset,
      'rating_count': ratingCount,
      'order': order,
      'orderby': orderBy,
      'parent': parent,
      'parent_exclude': parentExclude,
      'slug': slug,
      'status': status,
      'type': type,
      'sku': sku,
      'featured': featured,
      'category': category,
      'tag': tag,
      'shipping_class': shippingClass,
      'attribute': attribute,
      'attribute_term': attributeTerm,
      'tax_class': taxClass,
      'on_sale': onSale,
      'min_price': minPrice,
      'max_price': maxPrice,
      'stock_status': stockStatus,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });

    _printToLog("Parameters: $payload");
    List<WooProduct> products = [];
    _setApiResourceUrl(path: 'products', queryParameters: payload);
    final response = await get(queryUri.toString());
    List parseRes = response;
    products = parseRes.map((e) => WooProduct.fromJson(e)).toList();
    return products;
  }

  Future<List<ModelShippingZone>> getAllShippingZone() async {
    List<ModelShippingZone> shippingZone = [];

    _setApiResourceUrl(path: "shipping/zones");
    final response = await get(queryUri.toString());

    List parseRes = response;

    shippingZone = parseRes.map((e) => ModelShippingZone.fromJson(e)).toList();

    return shippingZone;
  }

  Future<List<ModelShippingMethod>> getAllShippingMethods(String zone) async {
    List<ModelShippingMethod> shippingZone = [];

    _setApiResourceUrl(path: "shipping/zones/$zone/methods");
    final response = await get(queryUri.toString());

    List parseRes = response;
    if (parseRes.isNotEmpty) {
      shippingZone =
          parseRes.map((e) => ModelShippingMethod.fromJson(e)).toList();
    }

    return shippingZone;
  }

  Future<List<ModelTax>> getAllTax() async {
    List<ModelTax> shippingZone = [];

    _setApiResourceUrl(path: "taxes");
    final response = await get(queryUri.toString());

    List parseRes = response;
    if (parseRes.isNotEmpty) {
      shippingZone = parseRes.map((e) => ModelTax.fromJson(e)).toList();
    }

    return shippingZone;
  }

  Future<dynamic> getShippingZoneLocations(String id) async {
    _setApiResourceUrl(path: "shipping/zones/$id/locations");
    final response = await get(queryUri.toString());

    return response;
  }

  // Future<List<WooProduct>> getProductsSearch(
  //     {int? page,
  //     int? perPage,
  //     String? search,
  //     String? after,
  //     String? before,
  //     String? order,
  //     String? orderBy,
  //     String? slug,
  //     String? status,
  //     String? type,
  //     String? sku,
  //     String? category,
  //     String? tag,
  //     String? shippingClass,
  //     String? attribute,
  //     String? attributeTerm,
  //     String? taxClass,
  //     String? minPrice,
  //     String? maxPrice,
  //     String? stockStatus,
  //     List<int>? exclude,
  //     List<int>? parentExclude,
  //     List<int>? include,
  //     List<int>? parent,
  //     int? offset,
  //     int? ratingCount,
  //     bool? featured,
  //     bool? onSale}) async {
  //   Map<String, dynamic> payload = {};
  //
  //   ({
  //     'page': page,
  //     'per_page': perPage,
  //     'search': search,
  //     'after': after,
  //     'before': before,
  //     'exclude': exclude,
  //     'include': include,
  //     'offset': offset,
  //     'rating_count': ratingCount,
  //     'order': order,
  //     'orderby': orderBy,
  //     'parent': parent,
  //     'parent_exclude': parentExclude,
  //     'slug': slug,
  //     'status': status,
  //     'type': type,
  //     'sku': sku,
  //     'featured': featured,
  //     'category': category,
  //     'tag': tag,
  //     'shipping_class': shippingClass,
  //     'attribute': attribute,
  //     'attribute_term': attributeTerm,
  //     'tax_class': taxClass,
  //     'on_sale': onSale,
  //     'min_price': minPrice,
  //     'max_price': maxPrice,
  //     'stock_status': stockStatus,
  //   }).forEach((k, v) {
  //     if (v != null) payload[k] = v.toString();
  //   });
  //
  //   _printToLog("Parameters: " + payload.toString());
  //   List<WooProduct> products = [];
  //   _setApiResourceUrl(path: 'products', queryParameters: {"search":search});
  //   final response = await get(queryUri.toString());
  //   print("productss===${response.toString()}");
  //   List parseRes = response;
  //   products = parseRes.map((e) => WooProduct.fromJson(e)).toList();
  //   return products;
  // }

  Future<List<ModelReviewProduct>> getProductReviewByProductId(
      {required int productId}) async {
    List<ModelReviewProduct> productReview;
    _setApiResourceUrl(
        path: 'products/reviews',
        queryParameters: {"product_id": productId.toString()});
    // _setApiResourceUrl(path: 'products', queryParameters: payload);
    // final response = await get(queryUri.toString());
    final response = await get(
      queryUri.toString(),
    );
    _printToLog('response gotten review: $response');
    List listGet = response;
    productReview = listGet.map((e) => ModelReviewProduct.fromJson(e)).toList();
    return productReview;
  }

  //   /// Returns a list of all [WooProductReview], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-reviews
//   Future<List<WooProductReview>> getProductReviews(
//       {int? page,
//         int? perPage,
//         String? search,
//         String? after,
//         String? before,
//         //List<int> exclude,
//         //List<int> include,
//         int? offset,
//         String? order,
//         String? orderBy,
//         List<int>? reviewer,
//         //List<int> reviewerExclude,
//         //List<String> reviewerEmail,
//         List<int>? product,
//         String? status}) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'page': page, 'per_page': perPage, 'search': search,
//       'after': after, 'before': before,
//       //'exclude': exclude, 'include': include,
//       'offset': offset,
//       'order': order, 'orderby': orderBy,
//       'reviewer': reviewer,
//       //'reviewer_exclude': reviewerExclude, 'reviewer_email': reviewerEmail,
//       'product': product,
//       'status': status,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v;
//     });
//     String meQueryPath = 'products/reviews' + getQueryString(payload);
//     List<WooProductReview> productReviews = [];
//     //_setApiResourceUrl(path: 'products/reviews', queryParameters: payload);
//     final response = await get(meQueryPath);
//     _printToLog('response gotten : ' + response.toString());
//     for (var r in response) {
//       var rev = WooProductReview.fromJson(r);
//       _printToLog('reviews gotten here : ' + rev.toString());
//       productReviews.add(rev);
//     }
//     return productReviews;
//   }

//
//   /// Returns a [WooProduct], with the specified [id].
  Future<WooProduct> getProductById({required String id}) async {
    WooProduct product;
    _setApiResourceUrl(
      path: 'products/$id',
    );
    final response = await get(queryUri.toString());
    product = WooProduct.fromJson(response);
    return product;
  }

  Future<WooCurrentCurrency> getCurrentCurrency() async {
    WooCurrentCurrency currency;
    _setApiResourceUrl(path: "data/currencies/current");
    final response = await get(queryUri.toString());
    currency = WooCurrentCurrency.fromJson(response);
    return currency;
  }

//   /// Returns a list of all [WooProductVariation], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-variations
  Future<List<WooProductVariation>> getProductVariations(
      {required int productId,
      int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      List<int>? parent,
      List<int>? parentExclude,
      String? slug,
      String? status,
      String? sku,
      String? taxClass,
      bool? onSale,
      String? minPrice,
      String? maxPrice,
      String? stockStatus}) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': perPage,
      'search': search,
      'after': after,
      'before': before,
      'exclude': exclude,
      'include': include,
      'offset': offset,
      'order': order,
      'orderby': orderBy,
      'parent': parent,
      'parent_exclude': parentExclude,
      'slug': slug,
      'status': status,
      'sku': sku,
      'tax_class': taxClass,
      'on_sale': onSale,
      'min_price': minPrice,
      'max_price': maxPrice,
      'stock_status': stockStatus,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    List<WooProductVariation> productVariations = [];
    _setApiResourceUrl(
        path: 'products/$productId/variations', queryParameters: payload);
    final response = await get(queryUri.toString());
    _printToLog('prod gotten her111e : $response');
    List variable = response;
    productVariations =
        variable.map((e) => WooProductVariation.fromJson(e)).toList();

    return productVariations;
  }

  Future<WooProductVariation> getProductVariationById(
      {required int productId, variationId}) async {
    WooProductVariation productVariation;
    _setApiResourceUrl(
      path: 'products/$productId/variations/$variationId',
    );
    final response = await get(queryUri.toString());
    _printToLog('response gotten : $response');

    productVariation = WooProductVariation.fromJson(response);
    return productVariation;
  }

//
//   /// Returns a List[WooProductVariation], with the specified [productId] only.
//
//   Future<List<WooProductVariation>> getProductVariationsByProductId(
//       {required int productId}) async {
//     List<WooProductVariation> productVariations = [];
//     _setApiResourceUrl(
//         path: 'products/' + productId.toString() + '/variations/');
//     final response = await get(queryUri.toString());
//
//     for (var v in response) {
//       var prodv = WooProductVariation.fromJson(v);
//       _printToLog('prod gotten here : ' + prodv.toString());
//       productVariations.add(prodv);
//     }
//     return productVariations;
//   }
//
//   /// Returns a list of all [WooProductAttribute].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-attributes
//
//   Future<List<WooProductAttribute>> getProductAttributes() async {
//     List<WooProductAttribute> productAttributes = [];
//     _setApiResourceUrl(
//       path: 'products/attributes',
//     );
//     final response = await get(queryUri.toString());
//     for (var a in response) {
//       var att = WooProductAttribute.fromJson(a);
//       _printToLog('prod gotten here : ' + att.toString());
//       productAttributes.add(att);
//     }
//     return productAttributes;
//   }
//
//   /// Returns a [WooProductAttribute], with the specified [attributeId].
//
//   Future<WooProductAttribute> getProductAttributeById(
//       {required int attributeId}) async {
//     WooProductAttribute productAttribute;
//     _setApiResourceUrl(
//       path: 'products/attributes/' + attributeId.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//
//     productAttribute = WooProductAttribute.fromJson(response);
//     return productAttribute;
//   }
//
//   /// Returns a list of all [WooProductAttributeTerm], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-attribute-terms
//   Future<List<WooProductAttributeTerm>> getProductAttributeTerms(
//       {required int attributeId,
//       int? page,
//       int? perPage,
//       String? search,
//       List<int>? exclude,
//       List<int>? include,
//       String? order,
//       String? orderBy,
//       bool? hideEmpty,
//       int? parent,
//       int? product,
//       String? slug}) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'page': page,
//       'per_page': perPage,
//       'search': search,
//       'exclude': exclude,
//       'include': include,
//       'order': order,
//       'orderby': orderBy,
//       'hide_empty': hideEmpty,
//       'parent': parent,
//       'product': product,
//       'slug': slug,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooProductAttributeTerm> productAttributeTerms = [];
//     _setApiResourceUrl(
//         path: 'products/attributes/' + attributeId.toString() + '/terms',
//         queryParameters: payload);
//     final response = await get(queryUri.toString());
//     for (var t in response) {
//       var term = WooProductAttributeTerm.fromJson(t);
//       _printToLog('term gotten here : ' + term.toString());
//       productAttributeTerms.add(term);
//     }
//     return productAttributeTerms;
//   }
//
//   /// Returns a [WooProductAttributeTerm], with the specified [attributeId] and [termId].
//
//   Future<WooProductAttributeTerm> getProductAttributeTermById(
//       {required int attributeId, termId}) async {
//     WooProductAttributeTerm productAttributeTerm;
//     _setApiResourceUrl(
//       path: 'products/attributes/' +
//           attributeId.toString() +
//           '/terms/' +
//           termId.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//
//     productAttributeTerm = WooProductAttributeTerm.fromJson(response);
//     return productAttributeTerm;
//   }
//
//   /// Returns a list of all [WooProductCategory], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-categories

  Future<List<WooProductCategory>> getProductCategories(
      {int? page,
      int? perPage,
      String? search,
      //List<int> exclude,
      //List<int> include,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? parent,
      int? product,
      String? slug}) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page, 'per_page': perPage, 'search': search,
      //'exclude': exclude, 'include': include,
      'order': order, 'orderby': orderBy, 'hide_empty': hideEmpty,
      'parent': parent,
      'product': product, 'slug': slug,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });

    List<WooProductCategory> productCategories = [];
    _printToLog('payload : $payload');
    _setApiResourceUrl(path: 'products/categories', queryParameters: payload);
    _printToLog('this is the path : $apiPath');
    final response = await get(queryUri.toString());
    for (var c in response) {
      var cat = WooProductCategory.fromJson(c);
      _printToLog('category gotten here : $cat');
      productCategories.add(cat);
    }
    return productCategories;
  }

  Future<List<WooGetCreatedOrder>> getMyOrder() async {
    // Map<String, dynamic> payload = {};
    //
    // ({
    //   'page': page, 'per_page': perPage, 'search': search,
    //   //'exclude': exclude, 'include': include,
    //   'order': order, 'orderby': orderBy, 'hide_empty': hideEmpty,
    //   'parent': parent,
    //   'product': product, 'slug': slug,
    // }).forEach((k, v) {
    //   if (v != null) payload[k] = v.toString();
    // });

    List<WooGetCreatedOrder> productCategories = [];
    // _printToLog('payload : ' + payload.toString());
    _setApiResourceUrl(
      path: 'orders',
    );
    // _setApiResourceUrl(path: 'products/categories', queryParameters: payload);
    final response = await get(queryUri.toString());
    for (var c in response) {
      var cat = WooGetCreatedOrder.fromJson(c);
      _printToLog('myorder gotten here : $cat');
      productCategories.add(cat);
    }
    return productCategories;
  }

//
//   /// Returns a [WooProductCategory], with the specified [categoryId].
//
//   Future<WooProductCategory> getProductCategoryById(
//       {required int categoryId}) async {
//     WooProductCategory productCategory;
//     _setApiResourceUrl(
//       path: 'products/categories/' + categoryId.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     productCategory = WooProductCategory.fromJson(response);
//     return productCategory;
//   }
//
//   /// Returns a list of all [WooProductShippingClass], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-shipping-classes
//   ///
//   Future<List<WooProductShippingClass>> getProductShippingClasses(
//       {int? page,
//       int? perPage,
//       String? search,
//       List<int>? exclude,
//       List<int>? include,
//       int? offset,
//       String? order,
//       String? orderBy,
//       bool? hideEmpty,
//       int? product,
//       String? slug}) async {
//     Map<String, dynamic> payload = {};
//     ({
//       'page': page,
//       'per_page': perPage,
//       'search': search,
//       'exclude': exclude,
//       'include': include,
//       'offset': offset,
//       'order': order,
//       'orderby': orderBy,
//       'hide_empty': hideEmpty,
//       'product': product,
//       'slug': slug,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooProductShippingClass> productShippingClasses = [];
//     _setApiResourceUrl(
//       path: 'products/shipping_classes',
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     for (var c in response) {
//       var sClass = WooProductShippingClass.fromJson(c);
//       _printToLog('prod gotten here : ' + sClass.toString());
//       productShippingClasses.add(sClass);
//     }
//     return productShippingClasses;
//   }
//
//   /// Returns a [WooProductShippingClass], with the specified [id].
//
//   Future<WooProductShippingClass> getProductShippingClassById(
//       {required int id}) async {
//     WooProductShippingClass productShippingClass;
//     _setApiResourceUrl(
//       path: 'products/shipping_classes/' + id.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     productShippingClass = WooProductShippingClass.fromJson(response);
//     return productShippingClass;
//   }
//
//   /// Returns a list of all [ProductTag], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-tags
//   Future<List<WooProductTag>> getProductTags(
//       {int? page,
//       int? perPage,
//       String? search,
//       //List<int> exclude,
//       //List<int> include,
//       int? offset,
//       String? order,
//       String? orderBy,
//       bool? hideEmpty,
//       int? product,
//       String? slug}) async {
//     Map<String, dynamic> payload = {};
//     ({
//       'page': page, 'per_page': perPage, 'search': search,
//       // 'exclude': exclude, 'include': include,
//       'offset': offset,
//       'order': order, 'orderby': orderBy, 'hide_empty': hideEmpty,
//       'product': product, 'slug': slug,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooProductTag> productTags = [];
//     _printToLog('making request with payload : ' + payload.toString());
//     _setApiResourceUrl(path: 'products/tags', queryParameters: payload);
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     for (var c in response) {
//       var tag = WooProductTag.fromJson(c);
//       _printToLog('prod gotten here : ' + tag.toString());
//       productTags.add(tag);
//     }
//     return productTags;
//   }
//
//   /// Returns a [WooProductTag], with the specified [id].
//
//   Future<WooProductTag> getProductTagById({required int id}) async {
//     WooProductTag productTag;
//     _setApiResourceUrl(
//       path: 'products/tags/' + id.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     productTag = WooProductTag.fromJson(response);
//     return productTag;
//   }
//
//   /// Returns a  [WooProductReview] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-reviews
//   Future<WooProductReview> createProductReview(
//       {required int productId,
//       int? status,
//       required String reviewer,
//       required String reviewerEmail,
//       required String review,
//       int? rating,
//       bool? verified}) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'product_id': productId,
//       'status': status,
//       'reviewer': reviewer,
//       'reviewer_email': reviewerEmail,
//       'review': review,
//       'rating': rating,
//       'verified': verified,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//
//     WooProductReview productReview;
//     _setApiResourceUrl(
//       path: 'products/reviews',
//     );
//     final response = await post(queryUri.toString(), payload);
//     _printToLog('response gotten : ' + response.toString());
//     productReview = WooProductReview.fromJson(response);
//     return productReview;
//   }
//

//
//   /// Returns a [WooProductReview], with the specified [reviewId].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-reviews
//
//   Future<ModelReviewProduct> getProductReviewById({required int reviewId}) async {
//     ModelReviewProduct productReview;
//     _setApiResourceUrl(
//       path: 'products/reviews/' + reviewId.toString(),
//     );
//     final response = await get(queryUri.toString());
//     _printToLog('response gotten : ' + response.toString());
//     productReview = ModelReviewProduct.fromJson(response);
//     return productReview;
//   }

  /// Updates an existing Product Review and returns the [WooProductReview] object.
  ///
  /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-reviews

  // Future<ModelReviewProduct> updateProductReview(
  //     {required ModelReviewProduct productReview}) async {
  //   _printToLog('Updating product review With reviewId : ' +
  //       productReview.id.toString());
  //   _setApiResourceUrl(
  //     path: 'products/reviews/' + productReview.id.toString(),
  //   );
  //   final response = await put(queryUri.toString(), productReview.toJson());
  //   return ModelReviewProduct.fromJson(response);
  // }

//   /// Deletes an existing Product Review and returns the [WooProductReview] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#product-reviews
//
//   Future<WooProductReview> deleteProductReview({required int reviewId}) async {
//     Map data = {
//       'force': true,
//     };
//     _printToLog(
//         'Deleting product review With reviewId : ' + reviewId.toString());
//     _setApiResourceUrl(
//       path: 'products/review/' + reviewId.toString(),
//     );
//     final response = await delete(queryUri.toString(), data);
//     return WooProductReview.fromJson(response);
//   }
//
//   /**
//   /// Accepts an int [id] of a product or product variation, int quantity, and an array of chosen variation attribute objects
//   /// Related endpoint : wc/store/cart/items

  Future<WooCartItem?> updateCartQuantity(
      String key, int quantity, String nonse, bool withAuth) async {
    Map<String, dynamic> data = {
      'quantity': quantity,
    };
    _setApiResourceUrl(path: 'cart/items/$key', isShop: true);
    final response =
        await put(queryUri.toString(), data, nonse: nonse, withAuth: withAuth);
    if (response != null) {
      try {
        return WooCartItem.fromJson(response);
      } catch (e) {
        _handleError(response);
      }
    } else {
      return null;
    }
    return null;
  }

  Future<WooCartItem?> addToCart(
      {required int itemId,
      required int quantity,
      required String nonse,
      List<WooProductVariation>? variations}) async {
    Map<String, dynamic> data = {
      'id': itemId,
      'quantity': quantity,
    };
    if (variations != null) data['variations'] = 383;
    // if (variations != null) data['variations'] = variations.toString();
    _setApiResourceUrl(path: 'cart/items', isShop: true);
    final response = await post(queryUri.toString(), data, nonse: nonse);

    if (response != null) {
      return WooCartItem.fromJson(response);
    } else {
      return null;
    }
  }

  Future<double> getCoupon(String couponCode, double totalAmount) async {
    RetrieveCoupon coupons = RetrieveCoupon();
    double amount = 0;

    Map<String, dynamic> data = {'code': couponCode};

    _setApiResourceUrl(path: 'coupons', queryParameters: data);
    final response = await get(queryUri.toString());

    if (response != null) {
      for (Map<String, dynamic> i in response) {
        coupons = RetrieveCoupon.fromJson(i);
      }
      if (coupons.discountType == 'percent') {
        amount =
            ((totalAmount * double.parse(coupons.amount.toString()) / 100));
      } else if (coupons.discountType == 'fixed_cart') {
        amount = double.parse(coupons.amount.toString());
      }
      return amount;
    } else {
      return amount;
    }
  }

  getNounceFromRes(DioLib.Response response) {
    String nounce = response.headers.value("nonce") ?? "";
    if (nounce.isNotEmpty) {
      HomeController homeController = Get.find<HomeController>();
      homeController.wooCommerceNonce = nounce;
    }
  }

  void getNonce(bool withAuthorization) async {
    _setApiResourceUrl(path: 'cart', isShop: true);
    await get(queryUri.toString(), withAuth: withAuthorization);
  }

//   */
//
//   /// Accepts an int [id] of a product or product variation, int quantity, and an array of chosen variation attribute objects
//   /// Related endpoint : wc/store/cart
//   ///
//
//   Future<WooCartItem> addToMyCart(
//       {required String itemId,
//       required String quantity,
//       List<WooProductVariation>? variations}) async {
//     Map<String, dynamic> data = {
//       'id': itemId,
//       'quantity': quantity,
//     };
//     if (variations != null) data['variations'] = variations.toString();
//     await getAuthTokenFromDb();
//     _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
//     // final response = await http.post(
//     final response = await http.post(
//         Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items'),
//         headers: _urlHeader,
//         body: data);
//
//     print("chkheader===$_urlHeader--${Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items')}");
//     print("chkheader111===$_authToken");
//
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final jsonStr = json.decode(response.body);
//
//       _printToLog('added to my cart : ' + jsonStr.toString());
//       return WooCartItem.fromJson(jsonStr);
//     } else {
//       WooCommerceError err =
//           WooCommerceError.fromJson(json.decode(response.body));
//       throw err;
//     }
//   }

//   /// Returns a list of all [WooCartItem].
//   ///
//   /// Related endpoint : wc/store/cart/items
//
//   Future<List<WooCartItem>> getMyCartItems() async {
//     await getAuthTokenFromDb();
//     _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
//     final response = await http.get(
//         Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items'),
//         headers: _urlHeader);
//
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final jsonStr = json.decode(response.body);
//       List<WooCartItem> cartItems = [];
//       _printToLog('response gotten : ' + response.toString());
//       for (var p in jsonStr) {
//         var prod = WooCartItem.fromJson(p);
//         _printToLog('prod gotten here : ' + prod.name.toString());
//         cartItems.add(prod);
//       }
//
//       _printToLog('account user fetch : ' + jsonStr.toString());
//       return cartItems;
//     } else {
//       _printToLog(' error : ' + response.body);
//       WooCommerceError err =
//           WooCommerceError.fromJson(json.decode(response.body));
//       throw err;
//     }
//   }
//
//   /// Returns the current user's [WooCart], information

  Future<WooCartItem?> addToMyCart(
      {required int itemId,
      required int quantity,
      required String nonse,
      List<WooProductVariation>? variations}) async {
    Map<String, dynamic> data = {
      'id': itemId,
      'quantity': quantity,
    };
    if (variations != null) data['variations'] = variations.toString();
    _setApiResourceUrl(path: 'cart/items', isShop: true);
    final response = await post(queryUri.toString(), data,
        nonse: nonse, withAuthorization: true);

    if (response != null) {
      try {
        return WooCartItem.fromJson(response);
      } catch (e) {
        _handleError(response);
      }
    } else {
      return null;
    }
    return null;
  }

  // Future<WooCart?> getMyCart() async {
  //   await getAuthTokenFromDb();
  //   _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
  //   WooCart cart;
  //   // final response = await http.get(
  //   //     Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart'),
  //   //     headers: _urlHeader);
  //   _setApiResourceUrl(path: 'cart',isShop: true,);
  //
  //   final response=get(queryUri.toString(),withAuth: true);
  //   _printToLog('response auth : ' + _authToken!);
  //   if (response != null) {
  //     cart = WooCart.fromJson(response);
  //     return cart;
  //   } else {
  //     return null;
  //   }
  //   // // _printToLog('response gotten : ' + response.body.toString());
  //   // if (response != null) {
  //   //   final jsonStr = json.decode(response.body);
  //   //   cart = WooCart.fromJson(jsonStr);
  //   //   return cart;
  //   // } else {
  //   //   _printToLog(' error : ' + response.body);
  //   //   WooCommerceError err =
  //   //       WooCommerceError.fromJson(json.decode(response.body));
  //   //   throw err;
  //   // }
  // }

  Future<WooCart?> getMyCart() async {
    await getAuthTokenFromDb();
    // _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
    _setApiResourceUrl(path: 'cart', isShop: true);

    WooCart cart;
    // final response = await http.get(
    //     Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart'),
    //     headers: _urlHeader);
    final response = await get(queryUri.toString(), withAuth: true);

    _printToLog('get all cart : $queryUri');
    _printToLog('response gotten : $response');
    if (response != null) {
      cart = WooCart.fromJson(response);
      return cart;
    } else {
      return null;
      // _printToLog(' error : ' + response.body);
      // WooCommerceError err =
      //     WooCommerceError.fromJson(json.decode(response.body));
      // throw err;
    }
  }

  Future<WooCart?> getCartWithoutLogin() async {
    await getAuthTokenFromDb();
    // _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
    _setApiResourceUrl(path: 'cart', isShop: true);

    WooCart cart;
    // final response = await http.get(
    //     Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart'),
    //     headers: _urlHeader);
    final response = await get(queryUri.toString());

    _printToLog('get all cart : $queryUri');
    _printToLog('response gotten : $response');
    if (response != null) {
      cart = WooCart.fromJson(response);
      return cart;
    } else {
      return null;
      // _printToLog(' error : ' + response.body);
      // WooCommerceError err =
      //     WooCommerceError.fromJson(json.decode(response.body));
      // throw err;
    }
  }

  Future deleteMyCartItem({required String key}) async {
    Map<String, dynamic> data = {
      'key': key,
    };
    _printToLog('Deleting CartItem With Payload : $data');
    await getAuthTokenFromDb();
    _urlHeader['Authorization'] = 'Bearer ${_authToken!}';

    final http.Response response = await http.delete(
      Uri.parse('$baseUrl${URL_STORE_API_PATH}cart/items/$key'),
      headers: _urlHeader,
    );
    _printToLog('response of delete cart  : ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _printToLog('response of delete cart oooo   : ${response.body}');
      //final jsonStr = json.decode(response.body);

      //_printToLog('added to my cart : '+jsonStr.toString());
      //return WooCartItem.fromJson(jsonStr);
      return response.body;
    } else {
      WooCommerceError err =
          WooCommerceError.fromJson(json.decode(response.body));
      throw err;
    }
  }

//
//   Future deleteAllMyCartItems() async {
//     await getAuthTokenFromDb();
//     _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
//
//     final http.Response response = await http.delete(
//       Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items/'),
//       headers: _urlHeader,
//     );
//     _printToLog('response of delete cart  : ' + response.body.toString());
//
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return response.body;
//     } else {
//       WooCommerceError err =
//           WooCommerceError.fromJson(json.decode(response.body));
//       throw err;
//     }
//   }
//
//   /// Returns a [WooCartItem], with the specified [key].
//
//   Future<WooCartItem> getMyCartItemByKey(String key) async {
//     await getAuthTokenFromDb();
//     _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
//     WooCartItem cartItem;
//     final response = await http.get(
//         Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items/' + key),
//         headers: _urlHeader);
//     _printToLog('response gotten : ' + response.toString());
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final jsonStr = json.decode(response.body);
//       cartItem = WooCartItem.fromJson(jsonStr);
//       return cartItem;
//     } else {
//       _printToLog('error : ' + response.body);
//       WooCommerceError err =
//           WooCommerceError.fromJson(json.decode(response.body));
//       throw err;
//     }
//   }
//
//   Future<WooCartItem> updateMyCartItemByKey(
//       {required String key,
//       required int id,
//       required int quantity,
//       List<WooProductVariation>? variations}) async {
//     Map<String, dynamic> data = {
//       'key': key,
//       'id': id.toString(),
//       'quantity': quantity.toString(),
//     };
//     if (variations != null) data['variations'] = variations;
//     await getAuthTokenFromDb();
//     _urlHeader['Authorization'] = 'Bearer ' + _authToken!;
//     final response = await http.put(
//         Uri.parse(this.baseUrl + URL_STORE_API_PATH + 'cart/items/' + key),
//         headers: _urlHeader,
//         body: data);
//
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final jsonStr = json.decode(response.body);
//
//       _printToLog('added to my cart : ' + jsonStr.toString());
//       return WooCartItem.fromJson(jsonStr);
//     } else {
//       WooCommerceError err =
//           WooCommerceError.fromJson(json.decode(response.body));
//       throw err;
//     }
//   }
//
//   /// Creates an order and returns the [WooOrder] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders.
//   Future<WooOrder> createOrder(WooOrderPayload orderPayload) async {
//     _printToLog('Creating Order With Payload : ' + orderPayload.toString());
//     _setApiResourceUrl(
//       path: 'orders',
//     );
//     final response = await post(queryUri.toString(), orderPayload.toJson());
//     return WooOrder.fromJson(response);
//   }
//
//   /// Returns a list of all [Order], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders
//   Future<List<WooOrder>> getOrders(
//       {int? page,
//       int? perPage,
//       String? search,
//       String? after,
//       String? before,
//       List<int>? exclude,
//       List<int>? include,
//       int? offset,
//       String? order,
//       String? orderBy,
//       List<int>? parent,
//       List<int>? parentExclude,
//       List<String>?
//           status, // Options: any, pending, processing, on-hold, completed, cancelled, refunded, failed and trash. Default is any.
//       int? customer,
//       int? product,
//       int? dp}) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'page': page,
//       'per_page': perPage,
//       'search': search,
//       'after': after,
//       'before': before,
//       'exclude': exclude,
//       'include': include,
//       'offset': offset,
//       'order': order,
//       'orderby': orderBy,
//       'parent': parent,
//       'parent_exclude': parentExclude,
//       'status': status,
//       'customer': customer,
//       'product': product,
//       'dp': dp,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooOrder> orders = [];
//     _printToLog('Getting Order With Payload : ' + payload.toString());
//     _setApiResourceUrl(path: 'orders', queryParameters: payload);
//     final response = await get(queryUri.toString());
//     for (var o in response) {
//       var order = WooOrder.fromJson(o);
//       _printToLog('order gotten here : ' + order.toString());
//       orders.add(order);
//     }
//     return orders;
//   }
//
//   /// Returns a [WooOrder] object that matches the provided [id].
//
//   Future<WooOrder> getOrderById(int id, {String? dp}) async {
//     Map<String, dynamic> payload = {};
//     if (dp != null) payload["dp"] = dp;
//     _setApiResourceUrl(
//         path: 'orders/' + id.toString(), queryParameters: payload);
//     final response = await get(queryUri.toString());
//     return WooOrder.fromJson(response);
//   }
//
//   /// Updates an existing order and returns the [WooOrder] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders.
//
//   Future<WooOrder> oldUpdateOrder(WooOrder order) async {
//     _printToLog('Updating Order With Payload : ' + order.toString());
//     _setApiResourceUrl(
//       path: 'orders/' + order.id.toString(),
//     );
//     final response = await put(queryUri.toString(), order.toJson());
//     return WooOrder.fromJson(response);
//   }
//
//   Future<WooOrder> updateOrder({Map? orderMap, int? id}) async {
//     _printToLog('Updating Order With Payload : ' + orderMap.toString());
//     _setApiResourceUrl(
//       path: 'orders/' + id.toString(),
//     );
//     final response = await put(queryUri.toString(), orderMap);
//     return WooOrder.fromJson(response);
//   }
//
//   /// Deletes an existing order and returns the [WooOrder] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders.
//
//   Future<WooOrder> deleteOrder({required int orderId}) async {
//     Map data = {
//       'force': true,
//     };
//     _printToLog('Deleting Order With Id : ' + orderId.toString());
//     _setApiResourceUrl(
//       path: 'orders/' + orderId.toString(),
//     );
//     final response = await delete(queryUri.toString(), data);
//     return WooOrder.fromJson(response);
//   }
//
//   /// Creates an coupon and returns the [WooCoupon] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#coupons.
//   Future<WooCoupon> createCoupon({
//     String? code,
//     String? discountType,
//     String? amount,
//     bool? individualUse,
//     bool? excludeSaleItems,
//     String? minimumAmount,
//   }) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'code': code,
//       'discount_type': discountType,
//       'amount': amount,
//       'individual_use': individualUse,
//       'exclude_sale_items': excludeSaleItems,
//       'minimum_amount': minimumAmount,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     WooCoupon coupon;
//     _setApiResourceUrl(
//       path: 'coupons',
//     );
//     final response = await post(queryUri.toString(), payload);
//     _printToLog('response gotten : ' + response.toString());
//     coupon = WooCoupon.fromJson(response);
//     return coupon;
//   }
//
//   /// Returns a list of all [WooCoupon], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#coupons
//   Future<List<WooCoupon>?> getCoupons({
//     int? page,
//     int? perPage,
//     String? search,
//     String? after,
//     String? before,
//     //List<int> exclude,
//     //List<int> include,
//     int? offset,
//     String? order,
//     String? orderBy,
//     String? code,
//   }) async {
//     Map<String, dynamic> payload = {};
//     ({
//       'page': page, 'per_page': perPage, 'search': search,
//       'after': after, 'before': before,
//       //'exclude': exclude, 'include': include,
//       'offset': offset,
//       'order': order, 'orderby': orderBy, 'code': code,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooCoupon>? coupons;
//     _printToLog('Getting Coupons With Payload : ' + payload.toString());
//     _setApiResourceUrl(path: 'coupons', queryParameters: payload);
//     final response = await get(queryUri.toString());
//     for (var c in response) {
//       var coupon = WooCoupon.fromJson(c);
//       _printToLog('prod gotten here : ' + order.toString());
//       coupons!.add(coupon);
//     }
//     return coupons;
//   }
//
//   /// Returns a [WooCoupon] object with the specified [id].
//   Future<WooCoupon> getCouponById(int id) async {
//     _setApiResourceUrl(path: 'coupons/' + id.toString());
//     final response = await get(queryUri.toString());
//     return WooCoupon.fromJson(response);
//   }
//
//   /// Returns a list of all [WooTaxRate], with filter options.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#tax-rates.
//   Future<List<WooTaxRate>> getTaxRates(
//       {int? page,
//       int? perPage,
//       int? offset,
//       String? order,
//       String? orderBy,
//       String? taxClass}) async {
//     Map<String, dynamic> payload = {};
//
//     ({
//       'page': page,
//       'per_page': perPage,
//       'offset': offset,
//       'order': order,
//       'orderby': orderBy,
//       'class': taxClass,
//     }).forEach((k, v) {
//       if (v != null) payload[k] = v.toString();
//     });
//     List<WooTaxRate> taxRates = [];
//     _printToLog('Getting Taxrates With Payload : ' + payload.toString());
//     _setApiResourceUrl(path: 'taxes', queryParameters: payload);
//     final response = await get(queryUri.toString());
//     for (var t in response) {
//       var tax = WooTaxRate.fromJson(t);
//       _printToLog('prod gotten here : ' + order.toString());
//       taxRates.add(tax);
//     }
//     return taxRates;
//   }
//
//   /// Returns a [WooTaxRate] object matching the specified [id].
//
//   Future<WooTaxRate> getTaxRateById(int id) async {
//     _setApiResourceUrl(path: 'taxes/' + id.toString());
//     final response = await get(queryUri.toString());
//     return WooTaxRate.fromJson(response);
//   }
//
//   /// Returns a list of all [WooTaxClass].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#tax-classes.
//   Future<List<WooTaxClass>> getTaxClasses() async {
//     List<WooTaxClass> taxClasses = [];
//     _setApiResourceUrl(path: 'taxes/classes');
//     final response = await get(queryUri.toString());
//     for (var t in response) {
//       var tClass = WooTaxClass.fromJson(t);
//       _printToLog('tax class gotten here : ' + tClass.toString());
//       taxClasses.add(tClass);
//     }
//     return taxClasses;
//   }
//
//   /// Returns a list of all [WooShippingZone].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#shipping-zones.
//   Future<List<WooShippingZone>> getShippingZones() async {
//     List<WooShippingZone> shippingZones = [];
//     _setApiResourceUrl(path: 'shipping/zones');
//     final response = await get(queryUri.toString());
//     for (var z in response) {
//       var sZone = WooShippingZone.fromJson(z);
//       _printToLog('shipping zones gotten here : ' + sZone.toString());
//       shippingZones.add(sZone);
//     }
//     return shippingZones;
//   }
//
//   /// Returns a [WooShippingZone] object with the specified [id].
//
//   Future<WooShippingZone> getShippingZoneById(int id) async {
//     WooShippingZone shippingZone;
//     _setApiResourceUrl(path: 'shipping/zones/' + id.toString());
//     final response = await get(queryUri.toString());
//     shippingZone = WooShippingZone.fromJson(response);
//     return shippingZone;
//   }
//
//   /// Returns a list of all [WooShippingMethod].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#shipping-methods.
//   Future<List<WooShippingMethod>> getShippingMethods() async {
//     List<WooShippingMethod> shippingMethods = [];
//     _setApiResourceUrl(path: 'shipping_methods');
//     final response = await get(queryUri.toString());
//     for (var z in response) {
//       var sMethod = WooShippingMethod.fromJson(z);
//       _printToLog('shipping methods gotten here : ' + sMethod.toString());
//       shippingMethods.add(sMethod);
//     }
//     return shippingMethods;
//   }
//
//   /// Returns a [WooShippingMethod] object with the specified [id].
//
//   Future<WooShippingMethod> getShippingMethodById(int id) async {
//     WooShippingMethod shippingMethod;
//     _setApiResourceUrl(path: 'shipping_methods/' + id.toString());
//     final response = await get(queryUri.toString());
//     shippingMethod = WooShippingMethod.fromJson(response);
//     return shippingMethod;
//   }
//
//   /// Returns a list of all [WooShippingZoneMethod] associated with a shipping zone.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#shipping-zone-locations.
//   Future<List<WooShippingZoneMethod>> getAllShippingZoneMethods(
//       {required int shippingZoneId}) async {
//     List<WooShippingZoneMethod> shippingZoneMethods = [];
//     _setApiResourceUrl(
//         path: 'shipping/zones/' + shippingZoneId.toString() + '/methods');
//     final response = await get(queryUri.toString());
//     for (var l in response) {
//       var sMethod = WooShippingZoneMethod.fromJson(l);
//       _printToLog(
//           'shipping zone locations gotten here : ' + sMethod.toString());
//       shippingZoneMethods.add(sMethod);
//     }
//     return shippingZoneMethods;
//   }
//
//   /// Returns a [WooShippingZoneMethod] object from the specified [zoneId] and [methodId].
//
//   Future<WooShippingZoneMethod> getAShippingMethodFromZone(
//       {required int zoneId, required int methodId}) async {
//     WooShippingZoneMethod shippingZoneMethod;
//     _setApiResourceUrl(
//         path: 'shipping/zones/' +
//             zoneId.toString() +
//             'methods/' +
//             methodId.toString());
//     final response = await get(queryUri.toString());
//     shippingZoneMethod = WooShippingZoneMethod.fromJson(response);
//     return shippingZoneMethod;
//   }
//
//   /// Deletes an existing shipping zone method and returns the [WooShippingZoneMethod] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders.
//
//   Future<WooShippingZoneMethod> deleteShippingZoneMethod(
//       {required int zoneId, required int methodId}) async {
//     Map data = {
//       'force': true,
//     };
//     _printToLog(
//         'Deleting shipping zone method with zoneId : ' + zoneId.toString());
//     _setApiResourceUrl(
//         path: 'shipping/zones/' +
//             zoneId.toString() +
//             'methods/' +
//             methodId.toString());
//     final response = await delete(queryUri.toString(), data);
//     return WooShippingZoneMethod.fromJson(response);
//   }
//
//   /// Returns a list of all [WooShippingZoneLocation].
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#shipping-zone-locations.
//   Future<List<WooShippingZoneLocation>> getShippingZoneLocations(
//       {required int shippingZoneId}) async {
//     List<WooShippingZoneLocation> shippingZoneLocations = [];
//     _setApiResourceUrl(
//         path: 'shipping/zones/' + shippingZoneId.toString() + '/locations');
//     final response = await get(queryUri.toString());
//     for (var l in response) {
//       var sZoneLocation = WooShippingZoneLocation.fromJson(l);
//       _printToLog(
//           'shipping zone locations gotten here : ' + sZoneLocation.toString());
//       shippingZoneLocations.add(sZoneLocation);
//     }
//     return shippingZoneLocations;
//   }
//
//   /// Returns a list of all [WooPaymentGateway] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-payment-gateways.

//   /// Returns a [WooPaymentGateway] object from the specified [id].
//
//   Future<WooPaymentGateway> getPaymentGatewayById(int id) async {
//     WooPaymentGateway paymentGateway;
//     _setApiResourceUrl(path: 'payment_gateways/' + id.toString());
//     final response = await get(queryUri.toString());
//     paymentGateway = WooPaymentGateway.fromJson(response);
//     return paymentGateway;
//   }
//
//   /// Updates an existing order and returns the [WooPaymentGateway] object.
//   ///
//   /// Related endpoint: https://woocommerce.github.io/woocommerce-rest-api-docs/#orders.
//
//   Future<WooPaymentGateway> updatePaymentGateway(
//       WooPaymentGateway gateway) async {
//     _printToLog(
//         'Updating Payment Gateway With Payload : ' + gateway.toString());
//     _setApiResourceUrl(
//       path: 'payment_gateways/' + gateway.id!,
//     );
//     final response = await put(queryUri.toString(), gateway.toJson());
//     return WooPaymentGateway.fromJson(response);
//   }
//
//   /// This Generates a valid OAuth 1.0 URL
//   ///
//   /// if [isHttps] is true we just return the URL with
//   /// [consumerKey] and [consumerSecret] as query parameters
  String _getOAuthURL(String requestMethod, String endpoint) {
    String? consumerKey = this.consumerKey;
    String? consumerSecret = this.consumerSecret;

    String token = "";
    _printToLog('oauth token = : $token');
    String url = baseUrl + apiPath + endpoint;
    bool containsQueryParams = url.contains("?");

    if (isHttps == true) {
      return url +
          (containsQueryParams == true
              ? "&consumer_key=${this.consumerKey!}&consumer_secret=${this.consumerSecret!}"
              : "?consumer_key=${this.consumerKey!}&consumer_secret=${this.consumerSecret!}");
    }

    Random rand = Random();
    List<int> codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    /// Random string uniquely generated to identify each signed request
    String nonce = String.fromCharCodes(codeUnits);

    /// The timestamp allows the Service Provider to only keep nonce values for a limited time
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    String parameters =
        "oauth_consumer_key=${consumerKey!}&oauth_nonce=$nonce&oauth_signature_method=HMAC-SHA1&oauth_timestamp=$timestamp&oauth_token=$token&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString =
          // ignore: prefer_interpolation_to_compose_strings
          "${"$parameterString${Uri.encodeQueryComponent(key)}=" + treeMap[key]}&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    String method = requestMethod;
    String baseString =
        "$method&${Uri.encodeQueryComponent(containsQueryParams == true ? url.split("?")[0] : url)}&${Uri.encodeQueryComponent(parameterString)}";

    String signingKey = "${consumerSecret!}&$token";
    crypto.Hmac hmacSha1 =
        crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1

    /// The Signature is used by the server to verify the
    /// authenticity of the request and prevent unauthorized access.
    /// Here we use HMAC-SHA1 method.
    crypto.Digest signature = hmacSha1.convert(utf8.encode(baseString));

    String finalSignature = base64Encode(signature.bytes);

    String requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl =
          "${url.split("?")[0]}?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    } else {
      requestUrl =
          "$url?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    }
    return requestUrl;
  }

  _handleError(dynamic response) {
    if (response['message'] == null) {
      return response;
    } else {
      throw Exception(WooCommerceError.fromJson(response).toString());
    }
  }

  // Exception _handleHttpError(http.Response response) {
  Exception _handleHttpError(DioLib.Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 404:
      case 500:
        throw Exception(
            WooCommerceError.fromJson(json.decode(response.data.toString()))
                .toString());
      default:
        throw Exception(
            "An error occurred, status code: ${response.statusCode}");
    }
  }

  // Get the auth token from db.

  getAuthTokenFromDb() async {
    _authToken = await localDbService.getSecurityToken();
    return _authToken;
  }

  // Sets the Uri for an endpoint.
  String _setApiResourceUrl({
    required String path,
    String? host,
    port,
    queryParameters,
    bool isShop = false,
  }) {
    apiPath = DEFAULT_WC_API_PATH;
    if (isShop) {
      apiPath = URL_STORE_API_PATH;
    } else {
      apiPath = DEFAULT_WC_API_PATH;
    }
    //List<Map>param = [];
    // queryParameters.forEach((k, v) => param.add({k : v})); print(param.toString());
    getAuthTokenFromDb();
    queryUri = Uri(
        path: path, queryParameters: queryParameters, port: port, host: host);

    _printToLog('Query : $queryUri');
    //queryUri = new Uri.http( path, param);
    return queryUri.toString();
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';

    params.forEach((key, value) {
      if (inRecursion) {
        key = '[$key]';
      }

      //if (value is String || value is int || value is double || value is bool) {
      query += '$prefix$key=$value';
      //} else if (value is List || value is Map) {
      // if (value is List) value = value.asMap();
      // value.forEach((k, v) {
      //  query += getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
      //});
      // }
    });

    return query;
  }

  /// Make a custom get request to a Woocommerce endpoint, using WooCommerce SDK.

  Future<dynamic> get(String endPoint, {bool withAuth = false}) async {
    // Future<dynamic> get(String endPoint, {bool withAuth = false,Map<String, String>? headers}) async {
    String url = _getOAuthURL("GET", endPoint);
    String token = await localDbService.getSecurityToken();
    String bearerToken = "Bearer $token";
    _printToLog('this is the bearer token : $bearerToken');
    //
    Map<String, String> headers = HashMap();

    // headers ??= HashMap();
    if (withAuth) {
      headers['Authorization'] = bearerToken;
    }
    headers.putIfAbsent('Accept', () => 'application/json charset=utf-8');
    // 'Authorization': _bearerToken,
    try {
      var dio = Dio();
      DioLib.Response response =
          await dio.get(url, options: DioLib.Options(headers: headers));

      // final http.Response response = await http.get(Uri.parse(url), headers: headers);
      getNounceFromRes(response);
      // response.headers[""];
      if (response.statusCode == 200) {
        return response.data;
        // return json.decode(response.data.toString());
      }
      _handleHttpError(response);
    } on SocketException {
      throw Exception('No Internet connection.');
    }
  }

  // Future<dynamic> getHttpRes(String endPoint) async {
  //   String url = _getOAuthURL("GET", endPoint);
  //   String _token = await _localDbService.getSecurityToken();
  //   String _bearerToken = "Bearer $_token";
  //   _printToLog('this is the bearer token : $_bearerToken');
  //   Map<String, String> headers = new HashMap();
  //   print("geturl==$url");
  //   headers.putIfAbsent('Accept', () => 'application/json charset=utf-8');
  //   // 'Authorization': _bearerToken,
  //   try {
  //     final http.Response response = await http.get(Uri.parse(url));
  //     // response.headers[""];
  //     if (response.statusCode == 200) {
  //       return response;
  //     }
  //     _handleHttpError(response);
  //   } on SocketException {}
  // }

  Future<dynamic> oldget(String endPoint) async {
    String url = _getOAuthURL("GET", endPoint);

    http.Client client = http.Client();
    http.Request request = http.Request('GET', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    //request.headers[HttpHeaders.authorizationHeader] = _token;
    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    String response =
        await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    _handleError(dataResponse);
    return dataResponse;
  }

  /// Make a custom post request to Woocommerce, using WooCommerce SDK.

  Future<dynamic> post(String endPoint, Map<String, dynamic> data,
      {String? nonse, bool withAuthorization = false}) async {
    String url = _getOAuthURL("POST", endPoint);
    _urlHeader[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    if (nonse != null) {
      _urlHeader["Nonce"] = nonse;
      // _urlHeader["x-wc-store-api-nonce"] = nonse;
    }

    if (withAuthorization) {
      _urlHeader['Authorization'] = 'Bearer $_authToken';
    }
    _urlHeader[HttpHeaders.cacheControlHeader] = "no-cache";
    // final response = await http.post(Uri.parse(url),
    //     headers: _urlHeader, body: json.encode(data));

    DioLib.Response response = await Dio().post(url,
        data: json.encode(data), options: DioLib.Options(headers: _urlHeader));
    // DioLib.Response  response=await Dio().post(url,data: DioLib.FormData.fromMap(data),options: DioLib.Options(headers: _urlHeader) );
    getNounceFromRes(response);

    try {
      return response.data;
    } catch (e) {
      _handleError(response);
    }
    // return null;
  }

  Future<dynamic> putMultiPart(
      String endPoint, Map<String, String> data, http.MultipartFile file,
      {String? nonse, bool withAuth = false}) async {
    String url = _getOAuthURL("POST", endPoint);

    // http.Client client = http.Client();
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));
    // http.MultipartRequest('PUT', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    if (nonse != null) {
      request.headers["x-wc-store-api-nonce"] = nonse;
    }
    if (withAuth) {
      String token = await localDbService.getSecurityToken();
      String bearerToken = "Bearer $token";
      request.headers[HttpHeaders.authorizationHeader] = bearerToken;
    }

    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.fields.addAll(data);
    request.files.add(file);
    // request.body = json.encode(data);
    // print('sendbodt==${request.body}');

    http.StreamedResponse response11 = await request.send();

    final response = await response11.stream.bytesToString();

    // String response =
    //     await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    _handleError(dataResponse);
    return dataResponse;
  }

  Future<dynamic> put(String endPoint, Map data,
      {String? nonse, bool withAuth = false}) async {
    String url = _getOAuthURL("PUT", endPoint);

    http.Client client = http.Client();
    http.Request request = http.Request('PUT', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    if (nonse != null) {
      request.headers["x-wc-store-api-nonce"] = nonse;
    }
    if (withAuth) {
      String token = await localDbService.getSecurityToken();
      String bearerToken = "Bearer $token";
      request.headers[HttpHeaders.authorizationHeader] = bearerToken;
    }

    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.body = json.encode(data);

    String response =
        await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    _handleError(dataResponse);
    return dataResponse;
  }

  /// Make a custom put request to Woocommerce, using WooCommerce SDK.

  // Future<dynamic> put(String endPoint, Map? data) async {
  //   String url = _getOAuthURL("PUT", endPoint);
  //
  //   http.Client client = http.Client();
  //   http.Request request = http.Request('PUT', Uri.parse(url));
  //   request.headers[HttpHeaders.contentTypeHeader] =
  //       'application/json; charset=utf-8';
  //   request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
  //   request.body = json.encode(data);
  //   String response =
  //       await client.send(request).then((res) => res.stream.bytesToString());
  //   var dataResponse = await json.decode(response);
  //   _handleError(dataResponse);
  //   return dataResponse;
  // }

  /// Make a custom delete request to Woocommerce, using WooCommerce SDK.

  Future<dynamic> oldelete(String endPoint, Map data) async {
    String url = _getOAuthURL("DELETE", endPoint);

    http.Client client = http.Client();
    http.Request request = http.Request('DELETE', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    //request.headers[HttpHeaders.authorizationHeader] = _urlHeader['Authorization'];
    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.body = json.encode(data);
    final response =
        await client.send(request).then((res) => res.stream.bytesToString());
    _printToLog("this is the delete's response : $response");
    var dataResponse = await json.decode(response);
    _handleHttpError(dataResponse);
    return dataResponse;
  }

  Future<dynamic> delete(String endPoint, Map data, {String? aUrl}) async {
    String realUrl;
    final url = _getOAuthURL("DELETE", endPoint);
    if (aUrl == null) {
      realUrl = url;
    } else {
      realUrl = url;
    }
    // final url = Uri.parse(baseUrl + "notes/delete");
    final request = http.Request("DELETE", Uri.parse(realUrl));
    request.headers.addAll(<String, String>{
      "Accept": "application/json",
    });
    request.body = jsonEncode(data);
    final response = await request.send();
    if (response.statusCode > 300) {
      return Future.error(
          "error: status code ${response.statusCode} ${response.reasonPhrase}");
    }
    final deleteResponse = await response.stream.bytesToString();
    _printToLog("delete response : $deleteResponse");
    return deleteResponse;
  }
}

//
class QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    RegExp search = RegExp('([^&=]+)=?([^&]*)');
    Map result = {};

    // Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

    // A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1)!)] = decode(match.group(2)!);
    }

    return result;
  }
}
