import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDescription extends StatefulWidget {
  final orderData;
  OrderDescription({this.orderData});
  @override
  _OrderDescriptionState createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> {

 @override
  int dd;
  int mm;
  int yy;
  int orderStatus =0;
  String ADaddressLine ;
  String ADphone;
  String ADaltPhone;
  String ADpincode;
  String ADlandmark;
    int hh ;
  DateTime OrderDate;
  DateTime deliveryDate1;
  DateTime deliveryDate2;
  



String orderStatusText;
 void initState() {
    // TODO: implement initState

   Timestamp t = widget.orderData['time'];
    dd = t.toDate().day;
    mm = t.toDate().month;
    yy = t.toDate().year;
    hh = t.toDate().hour;
    
       OrderDate = DateTime(t.toDate().year,t.toDate().month,t.toDate().day);
//===============================if item ordered bedfore 3 am then two dates of delivery
      if(t.toDate().hour<15){
        deliveryDate1 = DateTime(t.toDate().year,t.toDate().month,t.toDate().day);
        deliveryDate2 = DateTime(t.toDate().year,t.toDate().month,t.toDate().day+1);
      }
      else{
        deliveryDate1 = DateTime(t.toDate().year,t.toDate().month,t.toDate().day+1);
        deliveryDate2 = DateTime(t.toDate().year,t.toDate().month,t.toDate().day+2);

      }





   orderStatus = widget.orderData['order_status'];
   if(orderStatus==1) orderStatusText = "Order Cancelled";
   else if(orderStatus==2) orderStatusText = "Picked up";
   else if(orderStatus==3) orderStatusText = "Washed";
   else if(orderStatus==4) orderStatusText = "out for delivery";
   else if(orderStatus==5) orderStatusText = "Delivered";
   else orderStatusText = "Order Placed";


   //=========================

ADaddressLine  = widget.orderData['address']['address_line'] ;
 ADphone   = widget.orderData['address']['phone_number'];
 ADaltPhone   = widget.orderData['address']['alt_phone_number'];
 ADpincode   = widget.orderData['address']['pin_code'];
 ADlandmark   = widget.orderData['address']['land_mark'];



 }
 bool isStatusPlaced = false;
 bool isStatusPicked = false;
 bool isStatusWashed = false;
 bool isStatusOutForDelivery = false;
 bool isStatusDeliverd =  false;

  @override

  bool showStatusText = false;
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 2028, allowFontScaling: false);
    return Scaffold(

     // backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        title: Text("Order details"),
      ),
      body: SafeArea(

        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.centerLeft,
              height: 40,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text("Order id : ${widget.orderData['order_id']}" ,style: TextStyle(color: Colors.black54,fontSize:  ScreenUtil().setSp(45)),),

                   Text(DateFormat.yMMMd().format(OrderDate),style: TextStyle(color: Colors.black54,fontSize:  ScreenUtil().setSp(45)),),
                 ],
               ),
             )
              ,
            ),

            Divider(),
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[



                    Container(
                          margin: EdgeInsets.only(left: 80,top: 10),


                       child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: <Widget>[

                            Expanded(
                              child: Container(

                                child: SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(),
                                    child: Column(
                                      children: <Widget>[

                                         Container(
                                           alignment : Alignment.centerLeft,
                                           child: Text("Order description",style: TextStyle(fontSize:ScreenUtil().setSp(50),color: Colors.black54),),
                                         ),
                                       Card(
                                         child: Container(
                                            color: Colors.white,
                                            child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: widget.orderData['orders_item'].length,
                                                itemBuilder: (BuildContext context, int itemIndex){

                                                  var itemPrice = widget.orderData['orders_item'][itemIndex]['singleItemPrice'].toString();
                                                  var itemQty =   widget.orderData['orders_item'][itemIndex]['itemQty'].toString();

                                                  var totalPrice = int.parse(itemPrice) * int.parse(itemQty);
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Column(

                                                      children: <Widget>[
                                                        Divider(),
                                                        Container(

                                                          child: Padding(
                                                            padding: const EdgeInsets.all(0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                              children: <Widget>[
                                                                Row(children: <Widget>[
                                                                  Image.asset(widget.orderData['orders_item'][itemIndex]['thumb'].toString(),height:  ScreenUtil().setHeight(80),color: Colors.blue,),
                                                                  SizedBox(width: 4,),
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[

                                                                      Container(
                                                                        child : Text(widget.orderData['orders_item'][itemIndex]['name'].toString(),style: TextStyle(fontSize: ScreenUtil().setSp(45)),),

                                                                      ),
                                                                      Row(children: <Widget>[

                                                                        Container(
                                                                          child : Text("Price : $itemPrice ₹",style: TextStyle(fontSize:  ScreenUtil().setSp(40),color: Colors.black87),),

                                                                        ),
                                                                        Text(" | ",style: TextStyle(color: Colors.blue),),
                                                                        Container(
                                                                          child : Text("quantity : $itemQty",style: TextStyle(fontSize:  ScreenUtil().setSp(40),color: Colors.black87),),

                                                                        ),


                                                                      ],)




                                                                    ],
                                                                  ),


                                                                ],),


                                                                Container(


                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(right: 8),
                                                                      child: Text("${totalPrice.toString()} ₹",style: TextStyle(fontSize:  ScreenUtil().setSp(45),color: Colors.green),),
                                                                    ))


                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(),
                                                      ],
                                                    ),
                                                  );}),
                                          ),
                                       ),

                                     Divider(),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment : Alignment.centerLeft,
                                                child: Text("Address",style: TextStyle(fontSize: 14,color: Colors.black54),),
                                              ),
                                            ),

                                     


                                            Card(
                                              child: Container(
                                                width: double.infinity,

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        widget.orderData['address']['user_name'].toString(),style: TextStyle(fontSize: 16),

                                                      ),

                                                      Text(' $ADaddressLine , $ADphone  , $ADaltPhone  , $ADpincode , $ADlandmark' ,  )

                                                    ],
                                                  ),
                                                ),

                                              ),
                                            )


                                          ],
                                        ),





                                        Divider(),

                                   Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment : Alignment.centerLeft,
                                                child: Text("Pick Up Time",style: TextStyle(fontSize:  ScreenUtil().setSp(50),color: Colors.black54),),
                                              ),
                                            ),

                                         Card(

                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                        Row(children: <Widget>[
                                       Text(DateFormat.yMMMd().format(deliveryDate1),style: TextStyle(fontSize:  ScreenUtil().setSp(45),color: Colors.black87),),
                                      Text(" To ",style: TextStyle(fontSize:  ScreenUtil().setSp(45),color: Colors.black87)),
                                      Text(DateFormat.yMMMd().format(deliveryDate2),style: TextStyle(fontSize:  ScreenUtil().setSp(45),color: Colors.black87),),

                                        ],),

                                        SizedBox(height: 10,),

                                     Text("Time : 4 Pm to 6 Pm ",style: TextStyle(fontSize:  ScreenUtil().setSp(45)),)
                                              ],

                                             ),
                                           ),



                                         ) 
                                          
                                          
                                          
                                          
                                          ]),


      Divider(),


                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment : Alignment.centerLeft,
                                                child: Text("Price Details",style: TextStyle(fontSize: 14,color: Colors.black54),),
                                              ),
                                            ),

                                            Card(
                                              child: Container(
                                                width: double.infinity,

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                           "Price : ${widget.orderData['totalOrderPrice']} ₹",style: TextStyle(color: Colors.black87,fontSize:  ScreenUtil().setSp(45)),

                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                            "Discount : 80%",style: TextStyle( fontSize : ScreenUtil().setSp(45)),
                                                        ),
                                                      ),


                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                            "Delivery-Pickup charges : 20 ₹",style: TextStyle(decoration: TextDecoration.lineThrough,fontSize:  ScreenUtil().setSp(45)),
                                                        ),
                                                      ),

                                                  Divider(thickness: 1.5,),


                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                            "Total Price: ${widget.orderData['totalOrderPrice']} ₹",style: TextStyle(fontSize:  ScreenUtil().setSp(55),color: Colors.green),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),

                                              ),
                                            )


                                          ],
                                        ),
                                       Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment : Alignment.centerLeft,
                                            child: Text("Payment mode",style: TextStyle(fontSize: 14,color: Colors.black54),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(widget.orderData['payment_mode'])
                                              ],
                                            ),
                                          ),
                                        ),


                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment : Alignment.centerLeft,
                                            child: Text("Order Status",style: TextStyle(fontSize: 14,color: Colors.black54),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                orderStatusText ,style: TextStyle(
                                                  color: orderStatus==1?Colors.red:Colors.black ,
                                                ),



                                                )
                                              ],
                                            ),
                                          ),
                                        )



                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),




                          ],
                        )
                      ),
                    ),



                    OrderStatusCol(orderStatus),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }




  Container OrderStatusCol(int order_status) {
    return Container(
        color: Colors.transparent,
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[





          Container(
            height: MediaQuery.of(context).size.height/1.3,

           width: 300,


            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(


                    children: <Widget>[

                      Container(
                       margin: EdgeInsets.symmetric(horizontal: 30),
                        width: 4,
                        color:   order_status==1?Colors.red : Colors.green
                        ,
                      ),

                      Row(
                        children: <Widget>[
                          Container(

                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isStatusPlaced ? isStatusPlaced=false:isStatusPlaced=true;
                                });


    },

                              child: Stack(
                                children: <Widget>[

                                  Positioned(

                                    child: Container(
                                      decoration: BoxDecoration(
                                        border:Border.all(width: 4,color:  order_status == 1 ? Colors.red:Colors.green),
                                        shape: BoxShape.circle,
                                        color:order_status == 1 ? Colors.red:Colors.green
                                      ),

                                      height: 60,
                                      width: 60,
                                    ),
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 8,left: 10),
                                      child: Image.asset('assets/deliveryAssets/orderPlaced.png',height: 40,color: Colors.white,))


                                ],
                              ),
                            ),
                          ),

                     Card(
                       color: order_status==1?Colors.red : Colors.green,
                         elevation: 7,
                         child: Container(child: isStatusPlaced? Padding(
                             padding: EdgeInsets.all(5),
                            child: order_status ==1 ?Text("Order Cacelled",style: TextStyle(fontSize: 10,color: Colors.white),):Text("Order Placed",style: TextStyle(fontSize: 10,color: Colors.white),

                            )
                         ):Container(height: 0,width: 0,)
                         )
                     )
                        ],
                      )

                    ],
                  ),
                ),




                Expanded(
                  child: Stack(


                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: 4,
                        color: order_status >= 2 ? Colors.green:Colors.blue
                        ,
                      ),

                      Container(

                        child: GestureDetector(
    onTap: (){
    setState(() {
    isStatusPicked ? isStatusPicked=false:isStatusPicked=true;
    });},
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[

                                  Positioned(

                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(width: 4,color:  order_status >= 2 ? Colors.green:Colors.blue[600]),
                                          shape: BoxShape.circle,
                                          color:  order_status >= 2 ? Colors.green:Colors.blue

                                      ),

                                      height: 60,
                                      width: 60,
                                    ),
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      child: Image.asset('assets/deliveryAssets/orderPick.png',height: 40,color: Colors.white,)),


                                ],
                              ),
                              Card(
                                  color: Colors.green,
                                  elevation: 7,
                                  child: Container(child: isStatusPicked? Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text("Order Picked",style: TextStyle(fontSize: 10,color: Colors.white),)):Container(height: 0,width: 0,)))


                            ],
                          ),
                        ),
                      )




                    ],
                  ),
                ),

                Expanded(
                  child: Stack(


                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: 4,
                        color: order_status >= 3 ? Colors.green:Colors.blue
                        ,
                      ),

                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isStatusWashed ? isStatusWashed=false:isStatusWashed=true;
                              });},
                            child: Container(

                              child: Stack(
                                children: <Widget>[

                                  Positioned(

                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(width: 4,color: order_status >= 3 ? Colors.green:Colors.blue[600]),
                                          shape: BoxShape.circle,
                                          color:  order_status >= 3 ? Colors.green:Colors.blue

                                      ),

                                      height: 60,
                                      width: 60,
                                    ),
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 11,left: 7),
                                      child: Image.asset('assets/deliveryAssets/washing.png',height: 39,color: Colors.white,))


                                ],
                              ),
                            ),
                          ),


                          Card(
                              color: Colors.green,
                              elevation: 7,
                              child: Container(child: isStatusWashed? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text("Order Washed",style: TextStyle(fontSize: 10,color: Colors.white),)):Container(height: 0,width: 0,)))






                        ],
                      )

                    ],
                  ),
                ),

                Expanded(
                  child: Stack(


                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        width: 4,
                        color: order_status >= 4 ? Colors.green:Colors.blue
                        ,
                      ),

                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isStatusOutForDelivery? isStatusOutForDelivery=false:isStatusOutForDelivery=true;
                              });},

                            child: Container(

                              child: Stack(
                                children: <Widget>[

                                  Positioned(

                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(width: 4,color: order_status >= 4 ? Colors.green:Colors.blue[600]),
                                          shape: BoxShape.circle,
                                          color:  order_status >= 4 ? Colors.green:Colors.blue

                                      ),

                                      height: 60,
                                      width: 60,
                                    ),
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      child: Image.asset('assets/deliveryAssets/orderdelivery.png',height: 40,color: Colors.white,))


                                ],
                              ),
                            ),
                          ),



                          Card(
                              color: Colors.green,
                              elevation: 7,
                              child: Container(child: isStatusOutForDelivery? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text("Out for delivery",style: TextStyle(fontSize: 10,color: Colors.white),)):Container(height: 0,width: 0,)))







                        ],
                      )

                    ],
                  ),
                ),


                Expanded(
                  child: Stack(


                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isStatusDeliverd? isStatusDeliverd=false:isStatusDeliverd=true;
                              });},

                            child: Container(

                              child: Stack(
                                children: <Widget>[

                                  Positioned(

                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(width: 4,color: order_status >= 5 ? Colors.green:Colors.blue[600]),
                                          shape: BoxShape.circle,
                                          color: order_status >= 5 ? Colors.green:Colors.blue

                                      ),

                                      height: 60,
                                      width: 60,
                                    ),
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 8,left: 10),
                                      child: Image.asset('assets/deliveryAssets/orderDelivered.png',height: 40,color: Colors.white,))


                                ],
                              ),
                            ),
                          ),

                          Card(
                              color: Colors.green,
                              elevation: 7,
                              child: Container(child: isStatusDeliverd? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text("Order Delivered",style: TextStyle(fontSize: 10,color: Colors.white),)):Container(height: 0,width: 0,)))



                        ],
                      )

                    ],
                  ),
                ),




              ],
            ),
          )











          ],
        ),
      );
  }
}
//widget.orderData.toString(),style: TextStyle(fontSize: 25)