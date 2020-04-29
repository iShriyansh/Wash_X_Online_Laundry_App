
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/Model/cartModel.dart';
import 'package:provider/provider.dart';
import 'package:wash_x/Pages/order_details.dart';


class CartItemBottomSheet extends StatefulWidget {
  @override
  _CartItemBottomSheetState createState() => _CartItemBottomSheetState();
}

class _CartItemBottomSheetState extends State<CartItemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(

        height: 500,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
            ),

          child: Column(
            children: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 150,right: 0,),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Wash Bucket" ,style: TextStyle(fontSize: 16,color: Colors.black54),),
                      ),
                    ),
                  ),
               
                  Container(
                    child: IconButton(icon: Icon(Icons.keyboard_arrow_down,size: 30,), onPressed: (){
                       Navigator.pop(context);

                    }),
                  ),
               

               
                ],
              ),

              Divider(
                thickness: 1,
              ),
              
              //========================Bottom cart Title=========================
              
              //=========================cart Item ListView ====================
              
              Expanded(
                child: Container(

                  color: Colors.grey[200],
                  child: ListView.builder(

                    itemCount: cartModel.foodItemsList.length,
                      itemBuilder: (con, index){
                      return cartItemBuilder(
                        cartItemIndex: index,
                        cartItemName: cartModel.foodItemsList[index]["name"],
                        cartItemPrice: cartModel.foodItemsList[index]["price"],
                         cartItemThumb: cartModel.foodItemsList[index]["thumb"],
                       
                      );


                  }),


                ),
              ),
              

             cartModel.foodItemsList.length != 0 ? Card(
                margin: EdgeInsets.all(0),
                elevation: 5,

                child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[


                                Container(
                                  child: Text("${cartModel.totalPrice} ₹",style: TextStyle(color: Colors.green,fontSize: 23),),
                                ),




                              ],
                            ),
                          ),
                        ),


                        FlatButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)
                            => OrderDetails()));
                          },

                          padding: EdgeInsets.all(0),
                          child: Container(
                            height: 70,
                            width: 150,
                            color: Colors.blue,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Place order",style: TextStyle(color:Colors.white,fontSize: 15),),
                                  ),

                               Icon(Icons.arrow_forward_ios,color: Colors.white,size: 14,)
                                ],
                              ),
                            ),

                          ),
                        )







                      ],
                    ),
                  ),


                  color: Colors.white38,
                ),
              ):

            Container(color:Colors.white,height:60,child:Center(child:Text("Cart is empty",style: TextStyle(fontSize: 17,color: Colors.black54),) ,) ,)
            ],
            
            
          ),


      ),
    );



  }
}

class cartItemBuilder extends StatefulWidget {
  
  final cartItemName ;
  final cartItemThumb;
  final cartItemPrice;
  final cartItemIndex;
  cartItemBuilder({this.cartItemName,this.cartItemIndex,this.cartItemPrice,this.cartItemThumb});
  
  
  _cartItemBuilderState createState() => _cartItemBuilderState();
}

class _cartItemBuilderState extends State<cartItemBuilder> {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    return Card(
      color: Colors.white,
      child: Container(
        height: 60,
        child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

          //===========================itemThumbConatiner=======
       Container(
        child: Row(
          children: <Widget>[

            Card(
              child: Container(
                width: 50,
                height:50,


             child: Padding(
               padding: const EdgeInsets.all(4),
               child: Image.network(widget.cartItemThumb,color: Colors.blue,),
             ),







              ),
            ),

            //==================FoodItemname===============

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(widget.cartItemName,style: TextStyle(fontSize: 16,color: Colors.black87),),
                    ),
                   Row(
                     children: <Widget>[
                       Text("${cartModel.foodItemsList[widget.cartItemIndex]["singleItemPrice"].toString()} ₹ ",style: TextStyle(color: Colors.green),),
                       Text("x "),
                       Text(cartModel.foodItemsList[widget.cartItemIndex]["itemQty"].toString())
                     ],
                    ),


                  ],
                ),
              ),
            ),




          ],
        ),
       ),

         IconButton(icon: Icon(Icons.remove_circle,color: Colors.blue[300],), onPressed: (){

           cartModel.removeItem(widget.cartItemIndex);
         })
         
         
          ],

        ),
      ),
    );
  }
}
