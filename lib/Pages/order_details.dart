import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wash_x/Model/cartModel.dart';
import 'package:wash_x/Pages/paymentSuccess.dart';

import 'package:wash_x/Components/Address_manager.dart';

class OrderDetails extends StatefulWidget {
 
 final ordersList;
 final phone;
 final addressData;
 final totalPrice;
 
 OrderDetails({this.ordersList,this.phone,this.addressData,this.totalPrice});


  _OrderDetailsState createState() => _OrderDetailsState();
}


class _OrderDetailsState extends State<OrderDetails> {
    static const platform = const MethodChannel("razorpay_flutter");
        Razorpay _razorpay;
  bool isPaymentSuccess;
 int group =2;
 bool isDataSaved=false;
 String phonex;
 var orderListx;
 int totalPricex;

    getPhone() async{
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      setState(() {
        phonex  = prefs.getString("phone");
      });


    }
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
     getPhone();
    
    
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
      String UpdateOrSetData;

     checkSchem()async{
      var isSchemaCreated = await Firestore.instance
           .collection('Orders').getDocuments().then((value){
             if(value.documents!=null){

             }
             else{
               UpdateOrSetData == "setData";
             }
      });
       return isSchemaCreated;
    }
 saveDatatoFirebase(String paymentId) async{

  setState(() {
    isDataSaved = true ;

  });


 DateTime now = DateTime.now();
 var currentTime = new DateTime(now.year, now.month, now.day, now.hour, now.minute);


  await Firestore.instance
        .collection('Orders').document(phonex).

        setData(
{
 'orders':FieldValue.arrayUnion([{
            'order_id' : randomAlphaNumeric(
      10),
      'totalOrderPrice' : totalPricex,
        'orders_item' :  orderListx,
        'time' : currentTime,
        'address' : widget.addressData,
        'prepaid' : true,
         'order_status' : 0,
        'payment_id' :  paymentId,
         'payment_mode' : "prepaid"
      },
          ] )},
    merge: true

        )
.whenComplete(



        (){

          setState(() {
            isDataSaved = false;

          });

          print("data saved");
            isDataSaved = true;
            Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>PaymentSuccess(),
  ));
        }




    );


  
  }


    saveDatatoFirebaseCod(var orderList,int totalPrice) async{
    setState(() {
       isDataSaved = true;
    });

      DateTime now = DateTime.now();
      var currentTime = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
      await Firestore.instance
          .collection('Orders').document(phonex)
          .setData(
          {
            'orders':FieldValue.arrayUnion([{
              'order_id' : randomAlphaNumeric(
                  10),
              'totalOrderPrice' : totalPrice,
              'orders_item' :  orderList,
              'time' : currentTime,
              'address' : widget.addressData,
              'prepaid' : true,
              'order_status' : 0,
              'payment_mode' : 'cod'

            }
            ] )},
          merge: true
      )
          .whenComplete(
              (){
            print("data saved");
            setState(() {
              isDataSaved =false;
            });

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>PaymentSuccess(),
                ));
          }
      );


    }












  void openCheckout({var phone, var price}) async {
 
    price = price*100;
 
    var options = {
      'key': 'rzp_live_vp8oqw4T6ev5O8',
      'amount': price.toString(),
      'name': 'Wash X',
      'description': 'washing',
      'prefill': {'contact': phone},
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

_handlePaymentSuccess(PaymentSuccessResponse response) {
   
    Fluttertoast.showToast(
    
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);

          print(saveDatatoFirebase(response.paymentId)) ;

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }


   void getOrderListData({var orderList,int totalPrice}){

      orderListx = orderList;
      totalPricex = totalPrice;
   }








    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

  
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(title: Text("Order Details",),),
        bottomNavigationBar: BottomAppBar(
           elevation: 10,
          color: Colors.blue,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[




              FlatButton(
                onPressed: () async{
               
                if(widget.addressData ==null){
                  _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(duration: new Duration(seconds: 2), content:
                      new Row(
                        children: <Widget>[

                          new Text("Please Select Address ..")
                        ],
                      ),
                      ));
                }

                else if(group==null){

                  _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(duration: new Duration(seconds: 2), content:
                      new Row(
                        children: <Widget>[

                          new Text("Please Select Payment Method..")
                        ],
                      ),
                      ));

                }


              else if(group==1){
                print("cod mode");
                await saveDatatoFirebaseCod(cartModel.foodItemsList,cartModel.totalPrice);
                
              }
               else if(group==2) {

                   await getOrderListData(orderList: cartModel.foodItemsList,totalPrice: cartModel.totalPrice);


                    openCheckout(phone: await cartModel.getPhoneNumber(),price:  await cartModel.TotalPrice());
                
              }

                },
                              child: Container(

                  height: 50,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text("Place Order  ",style: TextStyle(color: Colors.white,fontSize: 15),),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,)

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          
        ),
        body: Stack(
          children: <Widget>[

            Container(





              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Text("Your Items",style: TextStyle(fontSize: 17,color: Colors.black87),),
                         ),

                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(

                            child: Container(

                              decoration: BoxDecoration(
                                color: Colors.white70
//                      border: Border.all(style: BorderStyle.solid)
                              ),
                              child: Column(
                                children: <Widget>[

                                  Container(
                                    alignment:Alignment.centerLeft,
                                    child: Padding(

                                      padding: const EdgeInsets.all(8.0),

                                    ),
                                  ),


                                     Container(
                                       height: 150,

                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cartModel.foodItemsList.length,
                                          itemBuilder: (context,index){
                                            return Card(
                                              color: Colors.white,
                                              elevation: 3,
                                              child: ListTile(
                                              leading: Image.network(cartModel.foodItemsList[index]["thumb"],color: Colors.green,),
                                              title:Text(cartModel.foodItemsList[index]["name"]),
                                              subtitle: Text("${cartModel.foodItemsList[index]["price"]} ₹ "),
                                              trailing: Container(
                                                width: 100,

                                                child: Row(

                                                 mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[

                                             Text("${cartModel.foodItemsList[index]["singleItemPrice"].toString()} ₹ ",style: TextStyle(color: Colors.green),),
                                             Text("x "),
                                             Text(cartModel.foodItemsList[index]["itemQty"].toString())


                                                ],),
                                              ),



                                              ),
                                            );



                                          }),
                                    ),


     Divider(
       indent: 40,
       endIndent: 20,
       thickness: 2,
     ),
                                  Container(
                                    height: 95,
                                    alignment: Alignment.center,
                                    width: double.infinity,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Price: ${cartModel.totalPrice} ₹",style: TextStyle(fontSize:15,color: Colors.black87)),
                                          Row(
                                            children: <Widget>[

                                      Text("Delivery & Pickup Charges: ",style: TextStyle(fontSize:15,color: Colors.black87
                                             

                                              ),),
                                               
                                              Text(" 20 ₹",style: TextStyle(fontSize:15,color: Colors.black87
                                              ,decoration: TextDecoration.lineThrough,

                                              ),),
                                            ],
                                          ),
                                             Divider(),

                                          Text("Total Price: ${cartModel.totalPrice} ₹",style: TextStyle(fontSize:17,color: Colors.green)),
                                        ],
                                      ),
                                    ),
                                  )

                                ],


                              ),
                            ),
                          ),
                        ),
             Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Text("Address",style: TextStyle(fontSize: 17,color: Colors.black87),),
                         ),
                       Card(
                                        child: Container(

                           child: Address_manager(addressData: widget.addressData,isShowPickUpFromHereBtn: true,),
                         ),
                       ),
   Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Text("Payment mode",style: TextStyle(fontSize: 17,color: Colors.black87),),
                         ),

                      Card(
                                      child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[



                          ListTile(
                            leading: Radio(
                              value: 1,
                              groupValue: group,
                               onChanged: (value){
                               setState(() {
                                group =value;
                              });
                             print(value);
                            }),
                          title: Text("Cash on delivery",style: TextStyle(fontSize: 18),),

                          ),

                    Divider(),

                    ListTile(
                            leading: Radio(
                              value: 2,
                              groupValue: group,
                               onChanged: (value){
                              setState(() {
                                group =value;
                              });
                             print(value);
                            }),
                          title: Text("Online pay",style: TextStyle(fontSize: 18),),

                          )


                            ],
                          ),
                        ),
                      )


                      ],
                    ),
                  ),
                ],
              ),

            ),

           isDataSaved? Stack(
              children: <Widget>[

                Container(color: Colors.black54.withOpacity(.5),),

                Center(child: CircularProgressIndicator())

              ],
            ):Container()








          ],




        ),



      ),
    );
  }
}
