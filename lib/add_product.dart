import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget{
  const AddProductScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddProductScreenState();
  }


}

class _AddProductScreenState extends State<AddProductScreen>{

 final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewProductInProgress = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
              child: Column(
                children: [
                     TextFormField(
                       controller: _nameTEController,
                       keyboardType: TextInputType.text,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       decoration: const InputDecoration(
                             hintText: 'Name',
                             labelText: 'Name'
                       ),
                       validator: (String ? value){
                         if(value == null || value.trim().isEmpty){
                           return 'Write Your Name';
                         }
                         return null;},
                     ),

                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _productCodeTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Product Code',
                        labelText: 'Product Code'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Write Your Product Code';
                      }
                      return null;
                    },
                  ),


                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _unitPriceTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Unit Price',
                        labelText: 'Unit Price'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Write Your unit Price';
                      }
                      return null;

                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _quantityTEController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: 'Quantity',
                        labelText: 'Quantity'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Write Your Quantity';
                      }
                      return null;

                    },

                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _totalPriceTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Total Price',
                        labelText: 'Total Price'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Write Your Total Price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _imageTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Image',
                        labelText: 'Image'
                    ),
                    validator: (String ? value){
                      if(value == null || value.trim().isEmpty){
                        return 'Write Image';
                      }
                      return null;
                      },
                  ),

                  const SizedBox(height: 16,),

                  Visibility(
                    //child ti visible thakbe kina??
                    visible: _addNewProductInProgress == false,
                      replacement:  const Center(
                        child: CircularProgressIndicator(

                        ),
                      ),
                      child:  ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              _addProduct();
                              Navigator.pop(context);
                            }
                          }, child: const Text("Add"))
                  )
                ],
              )
          ),
        ),
    )
    );
  }

 Future <void> _addProduct() async{

    _addNewProductInProgress =true;

    setState(() {

    });

    String addNewProductUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';

    //to send data in body
    Map<String, dynamic> inputData=
      {
        "Img":_imageTEController.text.trim(),
        "ProductCode": _productCodeTEController.text,
        "ProductName": _nameTEController.text,
        "Qty": _quantityTEController.text,
        "TotalPrice": _totalPriceTEController.text,
        "UnitPrice": _unitPriceTEController.text
      };

    //parsr to uri
    Uri uri = Uri.parse(addNewProductUrl);
    //then request to post
    Response response = await post(uri, body: jsonEncode(inputData), headers: {
      'content-type': 'application/json'}
    );
    print(response.statusCode);
    print(response.headers);
    print(response.body);

    _addNewProductInProgress = false;
    setState(() {});

    if(response.statusCode == 200){
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _productCodeTEController.clear();
      _unitPriceTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
   _quantityTEController.clear();
      
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New Product Added')),);
      
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add New Product Failed')),);

    }

  }

  @override
  void dispose(){
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();


  }




}