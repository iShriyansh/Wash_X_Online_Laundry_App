import 'package:flutter/material.dart';

import 'package:wash_x/Pages/Address/add_address.dart';
import 'package:wash_x/Pages/Address/select_address.dart';


class Address_manager extends StatefulWidget {
 final addressData;
 final isShowPickUpFromHereBtn;
 Address_manager({this.addressData,this.isShowPickUpFromHereBtn});





  _Address_managerState createState() => _Address_managerState();
}

class _Address_managerState extends State<Address_manager> {
  int _counter = 0;
 List<Map<String,String>> address  = [{
    "name" : "Shriyansh raj",
    "address_line" : "268 b ,top floor,madan mahal ke pass",
    'pin_code' : "482001",
    'landmark' : "sbi bank",
    "phone" : '+919685962799'

  },
    {
      "name" : "Shriyansh raj",
      "address_line" : "268 b ,top floor,madan mahal ke pass",
      'pin_code' : "482001",
      'landmark' : "sbi bank",
      "phone" : '+919685962799'

    }

  ];
  final _formKey = GlobalKey<FormState>();
   final TextEditingController _addressLine = TextEditingController();
   final TextEditingController _name = TextEditingController();
   final TextEditingController _mobile = TextEditingController();
  final TextEditingController _altMobile = TextEditingController();
   final TextEditingController _pincode = TextEditingController();
  final TextEditingController _landmark = TextEditingController();


 String ADaddressLine;
 String ADpincode;
 String ADphone;
 String ADlandmark;
  String ADaltPhone;
  String ADUserName;

   @override
  void initState() {
    // TODO: implement initState



                

                               if(widget.addressData !=null){

                                 ADUserName = widget.addressData['user_name'];
                             ADaddressLine = widget.addressData['address_line'];
                             ADpincode = widget.addressData['pin_code'];
                              ADphone = widget.addressData['phone_number'];
                                 ADlandmark = widget.addressData['land_mark'];
                                 ADaltPhone  = widget.addressData['alt_phone_number'];
                               }
                               else{
                                 ADUserName=  "";
                                 ADaddressLine = "";
                                 ADpincode = "";
                                 ADphone = "";

                               }
                             

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(address);
    return 

  Container(
  
   
    child: Center(
      child: Padding( 
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
          Container(
              decoration: BoxDecoration(
                  
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            

              width: double.infinity,
            
            
            child: Column(
              children: <Widget>[
                
                 address != null ? Container(
                  
                    
                  
                      child :   Card(
                             
                                      child: Container(

                             child :Center(
                               child: Container(

                 
                          
                                  child:widget.addressData!=null?Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4),
                                          child: Text(
                                           ADUserName.toString(),style: TextStyle(fontSize: 16),

                                          ),
                                        ),

                                        Text('$ADaddressLine , $ADphone  , $ADaltPhone  , $ADpincode , $ADlandmark' ,  )

                                      ],
                                    ),
                                  ):Container(),
                               ),
                             )

                 
                  ),
                ),):
                Container(height: 1,),

            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 6),
              child: MaterialButton(
                color: Colors.blue[500],
                onPressed: (){
                   address==null ?
                   
                               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>AddAddress(),
  ))
                   
                   :
                   
                           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>SelectAddress(),
  ))
                   
                   ;
                },
                            child: Container(
                 
                 height: 50,
                 width: double.infinity,
                  
                  
                  child: Center(child: Text("Change or Add Address",style: TextStyle(fontSize: 15,color: Colors.white),))),
              ),
            )
            
            
              ],
            ),
            
            
            
            
            
            
            )
           
            
          ],
        ),
      ),
    

      ),
  );
    }


  



  
  
  }

  


  