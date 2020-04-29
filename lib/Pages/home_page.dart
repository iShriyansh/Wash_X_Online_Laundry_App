import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_x/Authentication/login.dart';
import 'package:provider/provider.dart';
import 'package:wash_x/Model/cartModel.dart';
import 'package:wash_x/Components/cartItemBottomSheet.dart';
import 'order_details.dart';
import 'package:wash_x/Pages/orderedPage.dart';
import 'dart:ui';
import 'Address/select_address.dart';
import 'package:wash_x/Pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



var memesCategory  =[
  {
    "title":"Shirt",
    "thumbnailAd" : "assets/clothsVectors/shirt.png",
    "price" : 4
  } ,
  {
    "title":"T-shirt",
    "thumbnailAd" : "assets/clothsVectors/tshirt.png",
    "price" : 10
  },
  {
    "title":"Jeans",
    "thumbnailAd" : "assets/clothsVectors/jeans.png",
    "price" : 15
  } ,
  {
    "title":"Shorts",
    "thumbnailAd" : "assets/clothsVectors/shorts.png",
    "price" : 10
  },
  {
    "title":"BedSheet",
    "thumbnailAd" : "assets/clothsVectors/bedsheet.png",
    "price" : 20
  },

  {
    "title":"Girls wear",
    "thumbnailAd" : "assets/clothsVectors/girldress.png",
    "price" : 25
  },

];

class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String phone,fSPhone,name;
  var snapshot;
  var address;
  var cardData;
  var carosoleImageLinks;

  Future getUserData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
    DocumentReference documentReference =
    await Firestore.instance.collection("washX_users").document(phone);
    documentReference.get().then((datasnapshot) {


      if(datasnapshot.data.isEmpty){
        return Text("Waiting");
      }

      else if (datasnapshot.exists) {
        print(datasnapshot.data);
        snapshot = datasnapshot.data;

        setState(() {
          name = datasnapshot.data['providerProfile']['name'];
          fSPhone = datasnapshot.data['providerProfile']['phone'];
          address =  datasnapshot.data['address'][0];


        });
      }
      else{
        return Text("Waiting");

      }});
  }




  Future getCardData() async{
    DocumentReference documentReference =
    await Firestore.instance.collection("appData").document('card_data');
    documentReference.get().then((datasnapshot) {
      if(datasnapshot.data.isEmpty){
        return Text("Waiting");
      }
      else if (datasnapshot.exists) {
        ;
        setState(() {
          cardData = datasnapshot.data['cardData'];

          print(cardData);
        });
      }
      else{
        return Text("Waiting");
      }});
  }


  Future getCarosoleData() async{
    DocumentReference documentReference =
    await Firestore.instance.collection("appData").document('image_carousel');
    documentReference.get().then((datasnapshot) {
      if(datasnapshot.data.isEmpty){
        return Text("Waiting");
      }
      else if (datasnapshot.exists) {
        ;
        setState(() {
          carosoleImageLinks = datasnapshot.data;

          print(carosoleImageLinks['image1']);
        });
      }
      else{
        return Text("Waiting");
      }});
  }













  @override
  void initState() {
    // TODO: implement initState

    getUserData();
    getCardData();
    getCarosoleData();


  }

  @override

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

    ));
    ScreenUtil.init(context, width: 1080, height: 2028, allowFontScaling: false);


    final cartModel = Provider.of<CartModel>(context);

    return

      Scaffold(

        drawer: Drawer(

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(

                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[

                      Container(
                        child: SafeArea(child: Row(

                          children: <Widget>[
                            Icon(Icons.account_circle,size : 70,color :Colors.white),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                name!=null ? Text(name,style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(50)),):Text("Loading"),

                                Divider(height: 4,),
                                Row(
                                  children: <Widget>[
                                    //
                                    fSPhone!=null? Text('$fSPhone',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(40)),):Text("Loading  "),
                                  ],
                                ),
                              ],
                            )

                          ],
                        )),
                        height : 140,
                        color: Colors.blue,

                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)
                          => UserProfile() ));
                        },
                        child: Material(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.account_box,color: Colors.blue,size: 30,),
                            title: Text("Account",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                          ),
                        ),
                      ),

                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)
                          => OrderedPage() ));

                        },

                        child: Material(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.view_list,color: Colors.blue,size: 30,),
                            title: Text("Orders",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                          ),
                        ),
                      ),

                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)
                          => SelectAddress() ));
                        },
                        child: Material(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.location_city,color: Colors.blue,size: 30,),
                            title: Text("Addresses",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                          ),
                        ),
                      ),

                      Divider(),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Material(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.feedback,color: Colors.blue,size: 30,),
                            title: Text("Feedback",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                          ),
                        ),
                      ),


                      Divider(),
                      Material(
                        elevation: 3,
                        child: ListTile(
                          leading: Icon(Icons.help_outline,color: Colors.blue,size: 30,),
                          title: Text("Help",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                        ),
                      ),

                      Divider(),
                      Material(
                        elevation: 3,
                        child: ListTile(
                          leading: Icon(Icons.phone_android,color: Colors.blue,size: 30,),
                          title: Text("Contact us",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                        ),
                      ),

                      Divider(),
                      Material(
                        elevation: 3,
                        child: ListTile(
                          leading: Icon(Icons.info,color: Colors.blue,size: 30,),
                          title: Text("About",style: prefix0.TextStyle(color: Colors.black54,fontSize: 18,),),
                        ),
                      ),





                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 1,
                  child: Container(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios,size: 20,color: Colors.blue[300],),
                        Text("  Log Out",style: TextStyle(color : Colors.black54, fontSize: 18),),
                      ],
                    ),
                  ),
                  color: Colors.white,
                  height: 50,
                  minWidth: (50),
                  onPressed: ()async{


                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear().then((value){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>LogIn()),
                      );

                    }

                    );








                  },
                ),
              )





            ],
          ),
        ),



        bottomNavigationBar: cartModel.totalitems()!= 0 ? BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                // ==========================Buy Now Button ========================


                Row(children: <Widget>[
                  Container(
                    child:
                    Row(
                      children: <Widget>[
                        Container(

                          child: Text("${cartModel.totalPrice} ₹",
                            style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                        ),


                        MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){

                            showModalBottomSheet(context: context,backgroundColor: Colors.transparent, builder: (builder){

                              return  CartItemBottomSheet();


                            }

                            );


                          },
                          child: Stack(
                            children: <Widget>[


                              //===========================cartButton Listener ===========

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.shopping_cart,color: Colors.black54,size: 30,),
                              ),




                              Positioned(

                                  child: new Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left:20),
                                        child: new Icon(
                                            Icons.brightness_1,
                                            size: 23.0, color: Colors.blue),
                                      ),
                                      new Positioned(
                                          top: 5.0,
                                          right: 4.0,
                                          child: new Center(
                                            child: new Text(
                                              cartModel.foodItemsList.length.toString(),
                                              style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )),


                                    ],
                                  ))




                            ],


                          ),
                        ),


                      ],
                    ),
                  ),


                ],),


                MaterialButton(
                    height: 50
                    ,



                    color: Colors.blue,

                    child: Row(
                      children: <Widget>[
                        Text(
                          "Order Now ", style: TextStyle(color: Colors.white,fontSize: 16),),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18,)


                      ],
                    ),
                    onPressed: ()async{
                      var phone = await cartModel.getPhoneNumber();
                      var orderList = await cartModel.foodItemsList;
                      var totolOrderPrice = await cartModel.TotalPrice();

                      Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)
                      =>  OrderDetails(ordersList: orderList ,phone: phone,addressData: address,totalPrice: totolOrderPrice,)));
                    }),


              ],


            ),
          ),

        ):Container(height: 1,width: 1,),


        appBar: AppBar(

          title: Text("Wash X"),
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.help_outline,color: Colors.white,size: 25,),)
          ],

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,

          decoration: BoxDecoration(




          ),


          child: Stack(






            children: <Widget>[

              Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(


                      "assets/bgIcons.png",fit: BoxFit.cover,color :Colors.white)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  Container(
                      height: ScreenUtil().setHeight(450),
                      child: carosoleImageLinks !=null ? Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          CachedNetworkImage(imageUrl : carosoleImageLinks["image1"],

                            errorWidget: (context, url, error) => new Icon(Icons.error),
                           fit: BoxFit.cover,

                          ),
                          CachedNetworkImage(imageUrl : carosoleImageLinks["image2"],fit: BoxFit.cover,)




                        ],
                        autoplay: false,
                        indicatorBgPadding: 5,
                        dotSize: 4,
                        dotBgColor: Colors.transparent,
                      ):
                      Container(child: Center(child: Text("Loading...",style: prefix1.TextStyle(color: Colors.white),)),)



                  ),












                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Washing Category",style: TextStyle(color: Colors.black54,fontSize: 17),),
                  ),

                  Expanded(
                      child: Container(


                          child: cardData == null ?
                          Center(child:Text('loading...',style: prefix1.TextStyle(color: Colors.white),)):

                          GridView.builder(

                              itemCount : cardData.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (500/650),),
                              itemBuilder: (BuildContext,index){

                                return ClothCardBuilder(name:cardData[index]['name'],thumbAd: cardData[index]['thumb_url'],price:cardData[index]['price'],orignalPrice:cardData[index]['orignal_price'] ,

                                );
                              }


                          )







                      )),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

class ClothCardBuilder extends StatefulWidget {
  final name;
  final thumbAd;
  final price;
  final orignalPrice;
  int foodItemCount = 0;
  ClothCardBuilder({this.name,this.thumbAd,this.price,this.orignalPrice});

  @override
  _ClothCardBuilderState createState() => _ClothCardBuilderState();
}

class _ClothCardBuilderState extends State<ClothCardBuilder> {


  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    return Padding(
      padding: const EdgeInsets.all(1),
      child: Card(

        elevation: 4,

        shape: RoundedRectangleBorder(

            borderRadius: const BorderRadius.all(
                Radius.circular(10)
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),


          child: GestureDetector(
            onTap: (){





            },
            child: Container(

              child: GridTile(

                footer : Container(
                    width: double.infinity,
                    height: 70,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.name,style: TextStyle(color: Colors.white,fontSize:ScreenUtil().setSp(40)),),
                            Text("${widget.price.toString()} ₹",style: TextStyle(color: Colors.white ,fontSize: ScreenUtil().setSp(45)),),
                            Text("${widget.orignalPrice.toString()} ₹",style: TextStyle(color: Colors.white70 ,fontSize:ScreenUtil().setSp(35) ,decoration: TextDecoration.lineThrough),),

                          ],
                        ),

                        Row(
                          children: <Widget>[

                            Row(
                              children: <Widget>[



                                InkWell(child: Icon(Icons.arrow_drop_down,size: 25,color:Colors.white70), onTap: () {
                                  setState(() {
                                    if(widget.foodItemCount>0)
                                      widget.foodItemCount--;
                                  });
                                },),
                                Text("${widget.foodItemCount}", style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.white),),
                                InkWell(child: Icon(Icons.arrow_drop_up,size: 25,color: Colors.white70,), onTap: () {
                                  setState(() {
                                    if(widget.foodItemCount<=5)
                                      widget.foodItemCount++;
                                  });
                                },),





                              ],
                            ),



                            IconButton(
                              icon: Icon(Icons.add_shopping_cart,color: Colors.white,size: ScreenUtil().setSp(60),), onPressed: () {


                              if(widget.foodItemCount!=0){
                                var itemData = {
                                  "name": widget.name,
                                  "price": widget.price.toString(),
                                  "thumb": widget.thumbAd,

                                };


                                // for(int i  = 0 ; i<=widget.foodItemCount-1;i++){
                                cartModel.setItem(itemData,widget.foodItemCount);
                                cartModel.addFoodItems();

                                print(cartModel.foodItemsList);
                              }


                              // }
                              else{
                                print("please add atleast one item");
                              }



                            },)
                          ],
                        )


                      ],
                    )),

                child: Padding(



                  padding: const EdgeInsets.only(bottom: 50,left: 30,right: 30),
                  child: Container(

                    child: Image.network(widget.thumbAd,color: Colors.blue,),



                  ),
                ),


              ),
            ),
          ),
        ),
      ),

    );
  }
}



//  Text(phone,style : TextStyle(fontSize: 40)),


// Container(

//          color: Colors.red,
//          child: FlatButton(

//            child: Text("Sign Out",style: TextStyle(color: Colors.black),),
//            onPressed: () async{
//



//            },
//          ),
//        )


//   String phone = "textx";

// Future<void> getDataSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//  setState(() {
//     phone = prefs.getString('phone');
//  });

//   var password = prefs.getString('password');


// }

//  void initState() {

//       getDataSF();

//     super.initState();
//   }
