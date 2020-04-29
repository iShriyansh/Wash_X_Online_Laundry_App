import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'ordered_item_description.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OrderedPage extends StatefulWidget {
  @override
  _OrderedPageState createState() => _OrderedPageState();
}

class _OrderedPageState extends State<OrderedPage> {
  @override



  Firestore _firestore = Firestore.instance;
  String phone;
   
 GetPhoneNumber() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     phone =   prefs.getString('phone');
   });


      
}


 




  void initState() {
    super.initState();
    GetPhoneNumber();
  }
 





  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 1080, height: 2028, allowFontScaling: false);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(title: Text("Your Orders"),),
          body: Container(
            child:   StreamBuilder(

              stream :  Firestore.instance.collection('Orders').document(phone).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){

                  return Center(child: Text("Loading"));
                }
                else {

                  return Container(
                   
                    child: ListView.builder(

                        itemCount: snapshot.data['orders'].length,
                        itemBuilder: (BuildContext context, int index){
                          Timestamp
                           DateAndTime  =  snapshot.data['orders'][index]['time'];
                        

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 1,
                               child: Container(
                                 height: 120,

                                 child: Row(
                                   children: <Widget>[
                                     Expanded(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.only(left: 4),
                                                                            child: Container(
                                          color: Colors.white54,
                                         child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: <Widget>[
                                         Padding(
                                           padding: const EdgeInsets.only(left: 8,right:8,top: 4),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[

          Text("Order id : ${snapshot.data['orders'][index]['order_id']}",style: TextStyle(color :Colors.black54,fontSize:  ScreenUtil().setSp(40))),
                                             Text(new DateFormat.yMMMd().format(new DateTime(DateAndTime.toDate().year,DateAndTime.toDate().month,DateAndTime.toDate().day,)),style: TextStyle(color :Colors.black54,fontSize:  ScreenUtil().setSp(40))),
                                           ],),
                                         ),


                                         Expanded(
                                                                                    child: Container(





                                             child: ListView.builder(   itemCount: snapshot.data['orders'][index]['orders_item'].length,
                                             itemBuilder: (BuildContext context, int itemIndex){

                                               var itemPrice = snapshot.data['orders'][index]['orders_item'][itemIndex]['singleItemPrice'].toString();
                                               var itemQty =   snapshot.data['orders'][index]['orders_item'][itemIndex]['itemQty'].toString();

                                               var totalPrice = int.parse(itemPrice) * int.parse(itemQty);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
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
   Image.asset(snapshot.data['orders'][index]['orders_item'][itemIndex]['thumb'].toString(),height:  ScreenUtil().setHeight(160),color: Colors.blue,),
                SizedBox(width: 4,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      child : Text(snapshot.data['orders'][index]['orders_item'][itemIndex]['name'].toString(),style: TextStyle(fontSize: ScreenUtil().setSp(45)),),

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
                padding: const EdgeInsets.all(8),
                child: Text("${totalPrice.toString()} ₹",style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.green),),
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
                                         )


                                          ],
                              ),
                                       ),
                                                                          ),
                                     ),

                                  IconButton(icon: Icon(Icons.arrow_forward_ios,size:  ScreenUtil().setSp(60),),color:Colors.blue[300],onPressed: (){

                                 var orderData =  snapshot.data['orders'][index];

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OrderDescription(orderData: orderData,)),
                                    );
                                  },)



                                   ],
                                 ),
                               ),
                            ),
                          );



                        }


                    ),
                  );




                } })
        
      ),
    );
  }
}