import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_read_write/product_model.dart';

class AddUpdateScreen extends StatefulWidget{

  final ProductModel product;

const AddUpdateScreen({super.key,required this.product});

  @override
  State<StatefulWidget> createState() {
    return _AddUpdateScreenState();
  }

}

class _AddUpdateScreenState extends State<AddUpdateScreen>{

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _getUpdateProductInProgress = false;

  @override
  void initState(){
    super.initState();

    _nameTEController.text= widget.product.productName ?? '';
    _productCodeTEController.text = widget.product.productCode ?? '';
    _unitPriceTEController.text = widget.product.unitPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.image ?? '';
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Product'),
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
                        return null;

                      },
                    ),
                    const SizedBox(height: 16,),

                    TextFormField(
                      controller: _productCodeTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Product Code',
                        hintText: 'Product Code'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write your Product code';
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
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Image',
                        labelText: 'Image'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Enter your Image';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16,),
                    Visibility(
                        visible: _getUpdateProductInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child:  ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            updateProduct();
                          }
                        }, child: const Text("Update")))

                  ],
                )
            ),
          ),
        )
    );
  }

  Future<void> updateProduct () async{

    _getUpdateProductInProgress =true;
    setState(() {

    });
   String getUpdateProductUrl = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

  Map<String,String> InputData = {
    "Img": _imageTEController.text,
    "ProductCode": _productCodeTEController.text,
    "ProductName": _nameTEController.text,
    "Qty": _quantityTEController.text,
    "TotalPrice": _totalPriceTEController.text,
    "UnitPrice": _unitPriceTEController.text,
  };


   Uri uri =Uri.parse(getUpdateProductUrl);
   Response response = await post(uri,headers: {'content-type' : 'application/json'},
       body: jsonEncode(InputData));

   print(response.statusCode);
   print(response.body);

   if(response.statusCode == 200){

     //clear korar kichu nai
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Product has been Updated')),
     );
     Navigator.pop(context,true);
   }
   else{
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Update Product Failed')),
     );
   }


  }


  @override
  void dispose(){
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _productCodeTEController.dispose();
    super.dispose();


  }




}