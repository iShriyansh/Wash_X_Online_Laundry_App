import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'select_address.dart';

class AddAddress extends StatefulWidget {
    @override
    _AddAddressState createState() => _AddAddressState();
  }
  
  class _AddAddressState extends State<AddAddress> {
    @override

  final TextEditingController _phoneNumberController = TextEditingController();
   final TextEditingController _nameController = TextEditingController();
    final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _altPhoneController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();

 
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    var _formkey = GlobalKey<FormState>();
bool isDataSaved = false;




   saveDatatoFirebase() async{
   setState(() {
      isDataSaved =true;

   });
                               
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone  = prefs.getString("phone");

  await Firestore.instance
        .collection('washX_users').document(phone)
        .setData(
{ 'address': FieldValue.arrayUnion([
{
  'user_name': _nameController.text,
  'address_line' : _addressLineController.text,
  'phone_number' : _phoneNumberController.text,
  'alt_phone_number' : _altPhoneController.  text,
  'pin_code' : _pinCodeController.text,
  'land_mark' : _landMarkController.text
}

])

},
      merge: true

        )
.whenComplete(
        (){
          print("data saved");
            setState(() {
      isDataSaved =false;

   }
   
   
   );
         
            Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SelectAddress()),
  );


        }
    );


  
  }







    Widget build(BuildContext context) {
      return Scaffold(
        
        appBar: AppBar(
          title: Text("Enter your Address"),
        ),
       key: _scaffoldKey,
            
      backgroundColor: Colors.white.withOpacity(0.94),
      
      body: SingleChildScrollView(
              child: Container(
               
               
       
          
          child: Column(
          
            children: <Widget>[
               isDataSaved ?CircularProgressIndicator() : Container(),


              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  
                crossAxisAlignment: CrossAxisAlignment.start,
    
    children: <Widget>[
               
            

               

        
               Form(
                 key: _formkey,
                 child: Column(
              children: <Widget>[
                          Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                   
                              child: TextFormField(
                      validator : (value){
                       if(_nameController.text.isEmpty ){

                         return "Please Enter Username";
                       }
                        else{
                          return null;
                        }

                      },
                      keyboardType: TextInputType.multiline,
                       textInputAction: TextInputAction.newline,
              
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(27),
  ], 
                      
                      controller: _nameController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.account_box),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Full name",
                    
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),

                        
                      

                   Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                   
                              child: TextFormField(
                      validator : (value){
                       if(_addressLineController.text.isEmpty ){

                         return "Please Enter Addressline";
                       }
                       if(_addressLineController.text.length < 10 ){

                         return "Please Enter Complete Address";
                       }
                        else{
                          return null;
                        }

                      },


                      maxLines: 2,
                                minLines: 2,
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(70),
  ], 
                      
                      controller: _addressLineController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.location_city),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Address Line",
                      
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),





           Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                  
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                      validator : (value){
                       if(_phoneNumberController.text.isEmpty ){

                         return "Please Enter phone";
                       }
                       else if(_phoneNumberController.text.length <10){

                         return "Please Enter valid phone";
                       }
                        else{
                          return null;
                        }

                      },
                     
                     
              
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(10),
  ], 
                      
                      controller: _phoneNumberController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.phone_android),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Phone number ",
                    
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),


           Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                   
                              child: TextFormField(
                      validator : (value){
                       if(_altPhoneController.text.length !=10 ){

                         return "Please enter valid phone number";
                       }
                        else{
                          return null;
                        }

                      },
                     keyboardType: TextInputType.number,
                       textInputAction: TextInputAction.newline,
              
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(10),
  ], 
                      
                      controller: _altPhoneController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.phone_iphone),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Alternative phone (optional)",
                    
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),

                           Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                   
                              child: TextFormField(
                      validator : (value){
                       if(_pinCodeController.text.isEmpty ){

                         return "Please Enter Pincode";
                       }
                       else if(_pinCodeController.text.length !=6){
                         return "Enter valid pin number";
                       }
                        else{
                          return null;
                        }

                      },
                      keyboardType: TextInputType.number,
                       textInputAction: TextInputAction.newline,
              
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(6),
  ], 
                      
                      controller:_pinCodeController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.local_post_office),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Pin code",
                    
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),



                            Padding(
                     
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  child: Material(
                    
                    elevation: 1,
                    
                              child: TextFormField(
                    
                      keyboardType: TextInputType.multiline,
                       textInputAction: TextInputAction.newline,
              
                      
                      cursorColor: Colors.black54,
                      inputFormatters: [
                        
                   new LengthLimitingTextInputFormatter(12),
  ], 
                      
                      controller: _landMarkController,
                      style: TextStyle(fontSize: 17,color: Colors.black87),
                      decoration: const InputDecoration(
                        
                         prefixIcon: Icon(Icons.location_on),
                        
                       
   
                    
                     border: OutlineInputBorder(
                  borderSide: BorderSide(
                     color: Colors.red, 
                        width: 5.0),
    ),
  
                                
                     
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          
                       labelText: "Land Mark (optional)",
                    
                        hintStyle: TextStyle(
                         
                          fontSize: 15,
                          
                        ),

                          
                         ),
                      
                    ),
                  ),
                ),










               // ===============================Phone Number================================



                      

              ]
                   
                 ),
               ),

              






                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
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
                          color: Colors.blue,
                          
                          child: Container(width : double.infinity,child: Center(child: Text("Save Address",style: TextStyle(fontSize: 20,color: Colors.white),)),),
                          onPressed: (){

                            if (_formkey.currentState.validate()) {
                          saveDatatoFirebase();
                            
                            }
                          },
                        ),

                        ),
                    ),
                  ),
                ),
                



   
    ],
                ),
              ),
            ],
          ),
        ),
      ),
      );
      
    }
  }