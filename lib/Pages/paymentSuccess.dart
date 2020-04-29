
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'orderedPage.dart';


class PaymentSuccess extends StatefulWidget {
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
          body: Container( 
            width: double.infinity, 
               decoration: BoxDecoration(
             color: Colors.blue,
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.blueAccent.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/bgIcons.png"), fit: BoxFit.cover),
          
           ),
        child: Container(
       
          child: Column(
          
      
            children: <Widget>[
           SizedBox(height: MediaQuery.of(context).size.height/10 ,),
                 Icon(Icons.check_circle_outline,color: Colors.white,size: 100, ),
                  Text("Thank you ",style: TextStyle(color: Colors.white,fontSize: 30),),
                     Text("Your order has been  placed",style: TextStyle(color: Colors.white,fontSize: 17),
                  
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20 ,),
       
       Container(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal:30),
             child: Row(
           
             mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

               OutlineButton(
                 highlightedBorderColor: Colors.white,
                 disabledBorderColor: Colors.white,
                 autofocus: false,
                 
                  borderSide: BorderSide(color: Colors.white),
                 child: Text("View Your Orders",style: TextStyle(color: Colors.white),),
                onPressed: (){
              Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>OrderedPage(),
  ));


                },
               ),
            
            SizedBox(width: 10,),

OutlineButton(
  
                 highlightedBorderColor: Colors.white,
                 disabledBorderColor: Colors.white,
                 autofocus: false,
                borderSide: BorderSide(color: Colors.white),
                 
                
                 child: Text("Order Again",style: TextStyle(color: Colors.white),),
                onPressed: (){

                                  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>HomePage(),
  ));


                },
               )





               ],
             ),
           ),
       )
       
       
          ],),
        ),
      ),
    );
  }
}