import 'package:flutter/material.dart';
import 'package:wash_x/Authentication/phone_auth.dart';
import 'package:wash_x/Authentication/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_x/Authentication/signup.dart' as prefix0;
import 'package:wash_x/Pages/home_page.dart';
import 'package:wash_x/Authentication/signup.dart';
import 'package:wash_x/Pages/home_page.dart' as prefix1;

import 'package:provider/provider.dart';
import 'package:wash_x/Components/cartItemBottomSheet.dart';
import 'pages/home_page.dart';
import 'Model/cartModel.dart';
import 'pages/home_page.dart';
import 'package:wash_x/Payment_gatway/payment_gateway.dart';
import 'Pages/Address/select_address.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = prefs.getString('phone');
  var password = prefs.getString('password');

  runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => CartModel(0)),

              Provider(create: (context) => prefix1.HomePage()),
             
              Provider(create: (context) => CartItemBottomSheet()),
              Provider(create: (context) => prefix1.ClothCardBuilder()),
               Provider(create: (context) => PaymentGateway()),
               Provider(create: (context) => SelectAddress()),

            ],

            child: MaterialApp(home: phone == null && password==null ? SignUp() : prefix1.HomePage())
        ));
}



