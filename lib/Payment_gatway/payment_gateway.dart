import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wash_x/Model/cartModel.dart';


class PaymentGateway extends StatefulWidget {
 final totalPrice;
 final phone;
 PaymentGateway({this.phone,this.totalPrice});


  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PaymentGateway> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  bool isPaymentSuccess;

  @override
  Widget build(BuildContext context) {
       final cartModel = Provider.of<CartModel>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wash X'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              RaisedButton(onPressed: openCheckout, child: Text('Open'))
            ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_vp8oqw4t6ev508',
      'amount': "200" ,
      'name': 'Wash X',
      'description': 'washing',
      'prefill': {'contact': "ds"},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
       isPaymentSuccess = true;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }
}

