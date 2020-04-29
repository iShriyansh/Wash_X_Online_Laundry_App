import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'otp&&Db.dart';
import 'package:wash_x/Authentication/login.dart';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController _phoneNumberController = TextEditingController();
   final TextEditingController _nameController = TextEditingController();
    final TextEditingController _passwordCOntroller = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';
  String _verificationId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);



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
          
          child: Column(
          
            children: <Widget>[
              SafeArea(
                child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[

               Padding(
                 padding: const EdgeInsets.only(top:10.0),
                 child: Container(
                 
                   alignment: Alignment.center,
                   child: Image.asset('assets/washXlogo (2).png',height:MediaQuery.of(context).size.height/10,color: Colors.white,)),
               ),
              
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
                    child: const Text("Create An Account",style: TextStyle(color: Colors.white,fontSize: 15),),

                  ),
                ),


                 Form(
                 key: _formkey,
                 child: Column(
                children: <Widget>[




                   Padding(

                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Material(

                    elevation: 15,
                    color: Colors.transparent,
                              child: TextFormField(
                      validator : (value){
                       if(_nameController.text.isEmpty ){

                         return "Please Enter Username";
                       }
                        else{
                          return null;
                        }

                      },

                      cursorColor: Colors.black54,
                      inputFormatters: [
                   new LengthLimitingTextInputFormatter(27),
  ],

                      controller: _nameController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                         prefixIcon: Icon(Icons.account_box),

                        border : InputBorder.none,

                     contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 14,top: 15.0),

                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,

                        hintText: "Your Name",
                        hintStyle: TextStyle(

                          fontSize: 15,

                        ),


                         ),

                    ),
                  ),
                ),



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
                        )


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

                          child: Container(width : double.infinity,child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 20,color: Colors.white),)),),
                          onPressed: (){

                            if (_formkey.currentState.validate()) {
                              print("true");
                              SignUpButton();
                            }
                          },
                        ),

                        ),
                    ),
                  ),
                ),




  Container(

    child: Padding(
      padding: const EdgeInsets.only(left: 100,),
      child: Row(
          children: <Widget>[
             Text("Already have an Account ?",style :TextStyle(color: Colors.black54)),
       FlatButton(
         onPressed: (){
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
         },
         child: Text(" LogIn",style :TextStyle(color: Colors.white)))
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
      ),
      );
  }

  void SignUpButton() async{

    await _scaffoldKey.currentState.showSnackBar(
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
  print(phone);
  if(_phoneNumberController.text==phone) {

  print("User alreaday exits  ");

  _scaffoldKey.currentState.showSnackBar(
      new SnackBar(duration: new Duration(seconds: 2), content:
      new Row(
        children: <Widget>[

          new Text("Phone number already registered")
        ],
      ),
      ));






//  Navigator.pushReplacement(
//  context,
//  MaterialPageRoute(builder: (context) =>LogIn()),
//  );
  }
  }
  else{
    _verifyPhoneNumber();
 // print("user not found in db");



  }});



}

















  // Example code of how to verify phone number
  void _verifyPhoneNumber() async {

_scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 2), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Please wait...")
          ],
        ),
        ));


    
    setState(() {
      _message = '';
    });

    //############################## Auto verify phone number ############################################//

//    final PhoneVerificationCompleted verificationCompleted =
//        (AuthCredential phoneAuthCredential) {
//      _auth.signInWithCredential(phoneAuthCredential);
//      print("SDds");
//      setState(() {
//        _message = 'Received phone auth credential: ${phoneAuthCredential}';
//      });
//    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
     
      _verificationId = verificationId;
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OtpPage(verificationId: _verificationId,userName: _nameController.text,phoneNumber: _phoneNumberController.text,password: _passwordCOntroller.text,)),
  );
    
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      print("zoX");
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        //  verificationCompleted: PhoneVerificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    print("yoX");
  }

  // Example code of how to sign in with phone.
  // void _signInWithPhoneNumber() async {
  //   final AuthCredential credential = PhoneAuthProvider.getCredential(
  //     verificationId: _verificationId,
  //     smsCode: _smsController.text,
  //   );
  //   final FirebaseUser user =
  //       (await _auth.signInWithCredential(credential)).user;
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //   setState(() {
  //     if (user != null) {
  //       _message = 'Successfully signed in, uid: ' + user.uid;
  //     } else {
  //       _message = 'Sign in failed';
  //     }
  //   });
  // }
}