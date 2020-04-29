  import 'package:flutter/material.dart';
import 'package:wash_x/Pages/order_details.dart';
import 'package:wash_x/Pages/orderedPage.dart';
  import 'add_address.dart';
  import 'package:wash_x/Components/Address_manager.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:wash_x/Model/cartModel.dart';
  import 'package:provider/provider.dart';

  
  class SelectAddress extends StatefulWidget {


   
    
    @override
    _SelectAddressState createState() => _SelectAddressState();
  }
  
  class _SelectAddressState extends State<SelectAddress> {
    String name;
 String  addressLine;
 String pincode;
 String phone;
 String altPhone;
 String landmark;

 int group;
    bool isSelectAddressFromOrderDetailPage=false;
     
  @override
  var phonex;


getPhone() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
   setState(() {
     phonex  = prefs.getString("phone");
   });


  }

  void initState() {
    // TODO: implement initState

    getPhone();



    super.initState();
  }

    Widget build(BuildContext context) {
      final cartModel = Provider.of<CartModel>(context);
      return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(title: Text("Address"),),
              body: SafeArea(
                
                              child: Column(
                             
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: MaterialButton(
                      
                        padding: EdgeInsets.all(0),
                        
                        onPressed: (){
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>AddAddress(),
            ));

                        },
                                              child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(0),
                                                child: Container(
                                                  height: 50,
                            child: Row(
                           
                              
                              children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 20),
                     child: Icon(Icons.add,color:Colors.blue,size: 30,),
                   ),
                   Text("  Add new adress",style: TextStyle(fontSize: 15,color: Colors.blue),)
                            ],),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:10 ),
                                          child: Container(

                        child:  StreamBuilder(

              stream :  Firestore.instance.collection('washX_users').document(phonex).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){

                  return Center(child: Text("Loading"));
                }

                else if(snapshot.data['address'] ==null){
                  return Text("No Saved Address");
                }
                else  {
                  return ListView.builder(
                         itemCount: snapshot.data['address'].length,
                         itemBuilder: (BuildContext ,index){

                                    name =snapshot.data['address'][index]['user_name'];
                             addressLine = snapshot.data['address'][index]['address_line'];
                             pincode = snapshot.data['address'][index]['pin_code'];
                              phone = snapshot.data['address'][index]['phone_number'];
                                altPhone = snapshot.data['address'][index]['alt_phone_number'];
                                  landmark = snapshot.data['address'][index]['land_mark'];


                                   return Card(
                                                                        child: Container(

                                       
                                       width: double.infinity,
                                       child: Column(
                                         children: <Widget>[
                                     
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: <Widget>[
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: <Widget>[
                                           Radio( value: index,
                      groupValue: group,
                       onChanged: (value){
                       setState(() {
                        group =index;

                           name =snapshot.data['address'][group]['user_name'];
                             addressLine = snapshot.data['address'][group]['address_line'];
                             pincode = snapshot.data['address'][group]['pin_code'];
                              phone = snapshot.data['address'][group]['phone_number'];
                                altPhone = snapshot.data['address'][group]['alt_phone_number'];
                                  landmark = snapshot.data['address'][group]['land_mark'];
                                  
                      });
                     print(group);
                    
                     
                       }),
                                           Padding(
                                             padding: const EdgeInsets.only(top: 15),
                                             child: Text(name,style: TextStyle(fontSize: 15),),
                                           ),

                                         
                                           


                                           ],
                                         ),
                                   
                                 group == index ?  IconButton(icon: Icon(Icons.remove_circle,color: Colors.blue[700],), onPressed: (){
                               Firestore.instance.collection("washX_users").document(phonex).updateData(

                                {

                                  'address' : FieldValue.arrayRemove(

                                      [
                                        snapshot.data['address'][index]

                                      ]

                                  )

                                }

                            );



                                   },): Container()
                                   
                                   
                                   
                                   
                                       ],
                                     ),
                                         
                                       Padding(
                                         padding: const EdgeInsets.only(left: 10,bottom: 13),
                                         child: Text("$addressLine , pin code -$pincode $phone",style: TextStyle(fontSize: 16),),
                                       ),

                                         ],
                                       
                                       ),
                                     ),
                                   );

                         },
             
                        );
                }
              })
        ),
                                        ),
                    ),
                
              cartModel.foodItemsList.length!=0 ?  Container(
                  width: double.infinity,
                  height: 60,
                  child: FlatButton(
                    
                    color: Colors.blue,
                    child: Text("Pick Up From Here",style: TextStyle(color: Colors.white,fontSize: 19),),
                    onPressed: (){
   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OrderDetails(addressData: {'user_name':name,'address_line':addressLine,'pin_code' :pincode,'phone_number':phone,'land_mark':landmark,'alt_phone_number':altPhone}),
  ))
                  ;
                    },
                  ),
                ): cartModel.foodItemsList.length!=0 ?Container(height: 0,width: 0,):Container(height: 0,width: 0,)
                
                  ],
                ),
              ),
      );
    }
  }
  