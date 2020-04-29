import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Address/select_address.dart';
import 'package:wash_x/Pages/orderedPage.dart';
import 'package:wash_x/Authentication/login.dart';
class UserProfile extends StatefulWidget {
  

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

String phone;
 String name;
     String fSPhone;
      DocumentReference documentReference;
         var snapshot;
@override
     Future getUserData() async{

   SharedPreferences prefs = await SharedPreferences.getInstance();
     phone = prefs.getString('phone');
     documentReference =
    await Firestore.instance.collection("washX_users").document(phone);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data);
        snapshot = datasnapshot.data;
        setState(() {
           name = datasnapshot.data['providerProfile']['name'];  
           fSPhone = datasnapshot.data['providerProfile']['phone'];
        });
      }
      else{
        print("No such user");
       
      }});
     }


  void initState() {
       


    getUserData();

    // TODO: implement initState




 

    super.initState();
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text("Account"),
      ),


    body: Column(
      
      children: <Widget>[
        Container(
         color: Colors.blue,
              height: MediaQuery.of(context).size.height/3.5,
              width: double.infinity,
             
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.account_circle,size: 70,color: Colors.white,),
              ),
           
              
            
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: 
                snapshot != null ?
                Text(name,style: TextStyle(color: Colors.white,fontSize: 25),):Text("Loading..."),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: snapshot != null ? Text(phone,style: TextStyle(color: Colors.white,fontSize: 16),):Text("Loading..."),
              )
             


              ],
            ),



              ),
            ),
      
      
      Expanded(
        child: Container(
          
          width: double.infinity,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView(
                children: <Widget>[
                   accountDetailsCard(cardHeading: "My Orders",cardSubHeadLink: "VIEW ALL ORDERS",cardSubHeadLinkFun: (){
                         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>OrderedPage(),
  ));

                   }),
                   accountDetailsCard(cardHeading: "My Addresses",cardSubHeadLink: "VIEW ALL ADDRESS",cardSubHeadLinkFun: (){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>SelectAddress(),
  ));

                   }),
                    accountDetailsCard(cardHeading: "Customer Care",cardSubHeadLink: "CONTACT DETAILS",cardSubHeadLinkFun: (){

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) =>PaymentSuccess(),
  // ));
                }),

                   GestureDetector(
                     onTap: () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value){
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>LogIn()),
    );});



                     },
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20),
                       child: Container(width: double.infinity,height: 50,color: Colors.white,child: Row(
                         children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right:10 ),
                          child: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 20,),
                        ),


                        Text("Sign out",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black),)
                         ],
                       ),),
                     ),
                   )
                
                  
                  
               
                ],
              )
            ),
       
       
          )
      
      
      )
      
      
      
      ],
    ),

    );
  }

  Column accountDetailsCard({String cardHeading,String cardSubHeadLink,Function cardSubHeadLinkFun}) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Card(
  elevation: 8,
  child: Container(
    height: 100,
    width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 13,top: 8,bottom: 3),
        child: Text(cardHeading,style:TextStyle(fontSize:17),),
      ),
      Divider(thickness: 1,indent: 8,endIndent: 8,),
     
      Padding(
        padding: const EdgeInsets.only(left: 250,top: 15),
        child: GestureDetector(
          
          onTap: cardSubHeadLinkFun,
          child: Text(cardSubHeadLink,style: TextStyle(color: Colors.blue),)),
      )
   
   
    ]
    
    ,
  ),

  ),
)


],

            );
  }
}
