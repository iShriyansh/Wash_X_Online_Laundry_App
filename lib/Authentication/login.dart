import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:wash_x/Authentication/signup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wash_x/Pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LogIn extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final TextEditingController _phoneNumberController = TextEditingController();
    final TextEditingController _passwordCOntroller = TextEditingController();
  
 


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    var _formkey = GlobalKey<FormState>();

 

 saveLoginDetailsInSf() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', _phoneNumberController.text.toString());
    prefs.setString('password',_passwordCOntroller.text.toString());
    

  }

  void CheckSignInData() async{


    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 2), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Please wait...")
          ],
        ),
        ));


    DocumentReference documentReference =
    await Firestore.instance.collection("washX_users").document(_phoneNumberController.text);
    documentReference.get().then((datasnapshot) {


      if (datasnapshot.exists) {
        print(datasnapshot.data);
         String phone = datasnapshot.data['providerProfile']['phone'];
         String password = datasnapshot.data['providerProfile']['password'];

          print(phone);


        if(_phoneNumberController.text==phone&&_passwordCOntroller.text==password) {

          print("phone and password is corect ");
          saveLoginDetailsInSf();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );


        }
        else{

          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 4), content:
              new Row(
                children: <Widget>[

                  new Text("Authentication error")
                ],
              ),
              ));


        }

      }
      else{


      print("user not found in db");



      }});



  }












  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
            
      backgroundColor: Colors.lightBlueAccent,
      
      body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
               
           decoration: BoxDecoration(
             
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.blueAccent.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/bgIcons.png"), fit: BoxFit.cover),
            
           ),
          
          child: SafeArea(
            child: Column(
            
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    
                  crossAxisAlignment: CrossAxisAlignment.start,
    
    children: <Widget>[
                 
               Container(
               
                 alignment: Alignment.center,
                 child: Image.asset('assets/washXlogo (2).png',height:MediaQuery.of(context).size.height/10,color: Colors.white,)),
              
                 Row(
                  
                   mainAxisAlignment: MainAxisAlignment.center,
                  
                 
                   children: <Widget>[

                     Text("WASH",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/20,fontWeight: FontWeight.w700),),
                  Text("X",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height/12),),
                   ],
                 ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 15,bottom: 20,),
                    child: Container(
                      child: const Text("Log In",style: TextStyle(color: Colors.white,fontSize: 15),),
                     
                    ),
                  ),

        
                 Form(
                   key: _formkey,
                   child: Column(
                children: <Widget>[
                        
                          
                        

                   


                 // ===============================Phone Number================================

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    child: Material(
                      elevation: 15,
                      color: Colors.transparent,
                                child: TextFormField(

                     inputFormatters: [
                     new LengthLimitingTextInputFormatter(15),
  ],

                                   validator : (value){
                         if(_phoneNumberController.text.isEmpty ){

                           return "Please Enter phone Number";
                         }
                        //  else if(_phoneNumberController.text.length!=10){

                        //    return "Please Enter Valid Phone Number";
                        //  }
                          else{
                            return null;
                          }

                        },

                               
                        
                        
                        cursorColor: Colors.black54,
                        
                        controller: _phoneNumberController,
                        style: TextStyle(fontSize: 17,color: Colors.black87),
                        decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.phone,),
                          
                          
                           prefixStyle: TextStyle(
                            
                           ),
                          
                            border : InputBorder.none,
                     
   
                       contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 15.0, top: 15.0),
                       
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            filled: true,
                            
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                            fontSize: 15
                          ), 
                           ),
                       
                      ),
                    ),
                  ),

//===========================================Password =====================================================

Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    child: Material(
                      elevation: 15,
                      color: Colors.transparent,
                                child: TextFormField(


                                  obscureText: true,
                        
                        
                        cursorColor: Colors.black54,
                        
                        controller: _passwordCOntroller,
                        style: TextStyle(fontSize: 20,color: Colors.black54),
                        decoration: const InputDecoration(
                         prefixIcon: Icon(Icons.lock),

                            border :  InputBorder.none,
   
                       contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 15.0, top: 15.0),
                       
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            filled: true,
                            errorStyle: TextStyle(
                              color: Colors.redAccent
                            ),
                          
                            
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 15
                          )

                            
                           ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password can't be empty";
                          }
                          else{
                            return null;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),


                        

                ]
                     
                   ),
                 ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/30)),
                      child: Material(
                       
                        elevation: 10,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        
                                        
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40),
                                          
                                          
                                          )
                                        ),
                          
                          height: 50,
                         width: double.infinity,
                          
                          
                          child: FlatButton(
                            color: Colors.black87,
                            
                            child: Container(width : double.infinity,child: Center(child: Text("LogIn",style: TextStyle(fontSize: 20,color: Colors.white),)),),
                            onPressed: (){
                              CheckSignInData();
                              if (_formkey.currentState.validate()) {
                                print("true");
                                
                              }
                            },
                          ),

                          ),
                      ),
                    ),
                  ),
   
  Padding(
    padding: const EdgeInsets.only(left: 100,),
    child: Row(
        children: <Widget>[
             Text("Don't Have an Account ?",style :TextStyle(color: Colors.black54)),
     FlatButton(
       onPressed: (){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUp()),
  );


       },
       
       child: Text(" Register",style :TextStyle(color: Colors.white)))
        ],
    ),
  )
   
    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      );
  }

}