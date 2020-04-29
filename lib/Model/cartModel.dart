import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;


class CartModel with ChangeNotifier {


  int _counter;
 var foodItemsList = [];
  var _getItem ;
  int totalPrice = 0 ;
  int priceXqty;



  CartModel(_getItem);

  getCounter() => _counter;
  getItem() => _getItem;

  setCounter(int counter) => _counter = counter;
  setItem(var foodItem,var quantity){

    //    int priceXqty = int.parse(foodItem["price"])*quantity;
    // String name = foodItem["name"];
    // String thumb = foodItem["thumb"];

      priceXqty = int.parse(foodItem["price"])*quantity;
    String name = foodItem["name"];
    String thumb = foodItem["thumb"];

    print(priceXqty);
        

    _getItem = {
      "name" : name,
      "price": priceXqty.toString(),
      "thumb" : thumb,
      'itemQty': quantity,
      'singleItemPrice' : foodItem["price"],
      'totalPrice' : priceXqty
    };
    
    
    
    
  

  }

  int totalitems(){
    return foodItemsList.length;
  }

  void addFoodItems (){

    foodItemsList.add(getItem());

    //================================== add collection  price ==string== values=============

    totalPrice =  foodItemsList.map<int>((m) => int.parse(m["price"])).reduce((a,b )=>a+b);



    

    notifyListeners();

  }
TotalPrice(){
  return totalPrice;
}

  void UpdatecartPrice(){


    ChangeNotifier();
  }




  void removeItem(rIndex){
    int oneitemPrice = int.parse(foodItemsList[rIndex]["price"]);
    totalPrice = totalPrice - oneitemPrice;
    foodItemsList.removeAt(rIndex);

    notifyListeners();
  }



 getPhoneNumber() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone  = await prefs.getString("phone");
    return phone;

 }

Future saveDatatoFirebase() async{
  bool isDataSaved;

 DateTime now = DateTime.now();
 var currentTime = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone  = prefs.getString("phone");

  await Firestore.instance
        .collection('Orders').document(phone)
        .setData(

{

'orders':
{
 randomAlphaNumeric(
      10) : {
        'orders_item' : foodItemsList,
        'time' : currentTime,
        'address' : '288 , prem nagar madan mahal'
      }


}



}



        )
   
.whenComplete(
        (){
          print("data saved");
            isDataSaved = true;
  //           Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (context) => HomePage()),
  // );


        }
    );

if(isDataSaved==true){
  return true;
} else{
  return false;
}
  
  }








}
