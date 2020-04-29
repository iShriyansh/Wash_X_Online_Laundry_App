import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wash_x/Pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  
  final verificationId;
  final userName;
  final password;
  final phoneNumber;

  OtpPage({this.verificationId,this.userName,this.phoneNumber,this.password});

  _OtpPageState createState() => _OtpPageState();
}



class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  String _message = " ";
  bool isDataSavedToDb = false;
  bool isSavingProgress = false;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: otpController.text,
      
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    setState(() {
      if (user != null) {
       
         saveDatatoFirebase();
        _message = 'Verified Successfully';

       
      //   'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }
 saveLoginDetailsInSf() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', widget.phoneNumber.toString());
    prefs.setString('password',widget.password.toString());
    

  }




saveDatatoFirebase(){
  var t =    {
//===========================personal detail of provider data =============================
      'providerProfile': {'name': widget.userName.toString(),
        'phone' : widget.phoneNumber,  
        'password' : widget.password,
    }};
  Firestore.instance
        .collection('washX_users').document("${widget.phoneNumber}")
        .setData(t).whenComplete(
        (){print("data saved");
                saveLoginDetailsInSf();
                 setState(() {
              isSavingProgress = false;
       });

            Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );


        }
    );


  
  
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     
    body: Stack(
      children: <Widget>[
   isSavingProgress ? Container( 
      height: MediaQuery.of(context).size.height,
      color: Colors.black87,

     child : Center(child: CircularProgressIndicator())):Container(height: 1,width: 1,),
           
        Container(
               height: MediaQuery.of(context).size.height,
                   
               decoration: BoxDecoration(
                 
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.lightBlueAccent.withOpacity(0.5), BlendMode.dstATop),
                image: AssetImage("assets/bgIcons.png"), fit: BoxFit.cover),
                
               ),

   child:  Padding(
         padding: const EdgeInsets.only(left: 8,right: 8,top: 200),
         child: Column(
           children: <Widget>[

           
                
                
             TextFormField(                    
                                cursorColor: Colors.black54,
                                
                                controller: otpController,
                                style: TextStyle(fontSize: 20,color: Colors.black54),
                                decoration: const InputDecoration(
                                 prefixIcon: Icon(Icons.vpn_key),

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
                                  
                                    
                                  hintText: "Enter verificatiion code",
                                  hintStyle: TextStyle(
                                    fontSize: 15
                                  )

                                    
                                   ),
                              
                              ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            
                            child: Material(
                              color: Colors.blueAccent,
                              elevation: 10,
                                                child: FlatButton(
                                
                                child: Text("Continue >",style: TextStyle(color: Colors.white,fontSize: 15),),
                                onPressed: (){
                                  setState(() {
                                     isSavingProgress = true;
                                  });
                                  
                                _signInWithPhoneNumber();

                                },
                              ),
                            ),
                          ),
                        )  , 
           
                        Text(_message,style: TextStyle(fontSize: 15,color: Colors.black54),)
           
           
           
             
           
          
           ],
         ),
   ),




        ),
      ],
    ),
      
    );
  }
}
  




  