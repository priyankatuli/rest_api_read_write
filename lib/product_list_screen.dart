
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_read_write/add_product.dart';
import 'package:rest_api_read_write/add_update_screen.dart';
import 'package:rest_api_read_write/product_model.dart';

class ProductListScreen extends StatefulWidget{
  const ProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductListScreenState();
  }

}

class  _ProductListScreenState extends State<ProductListScreen>{

  bool _getProductInProgress = false;
  List<ProductModel> productList = [];

  @override
  void initState(){
    super.initState();
    _getProductList();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Product List'),
       ),
       body: RefreshIndicator(
         onRefresh: () async {
           _getProductList();
         },
         child: Visibility(
           visible: _getProductInProgress == false,
           replacement: const Center(
             child: CircularProgressIndicator(

             ),
           ),
           child : ListView.separated(
             itemCount: productList.length,
             itemBuilder: (BuildContext context,int index){

               return _buildProductList(productList[index]);
             },
             separatorBuilder: (_, index) => const Divider(),
           ),
         ),),

       floatingActionButton: FloatingActionButton(
         onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen()),
           );
         },
         child: const Icon(Icons.add),

       ),

     );
  }

  Future<void> _getProductList() async{

    _getProductInProgress = true;
    setState(() {

    });

    productList.clear();

   const String getProductListUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
   Uri uri =Uri.parse(getProductListUrl);

   //request get type er
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){

      //decode to data
      final decodedData = jsonDecode(response.body);  //json akare niye ashse data
      //get/grab the list --data key theke data nibo
     // List<Map<String,dynamic>> jsonProductList = decodedData['data'];
      final jsonProductList =decodedData['data'];
      // loop over the list
      for(Map<String,dynamic> json in jsonProductList){
        ProductModel productModel = ProductModel.fromJson(json);
         productList.add(productModel);
      }
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('')))
      
    }else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Get product list failed')),);
    }

    _getProductInProgress =false;
    setState(() {

    });


  }

  Widget _buildProductList(ProductModel product) {
    return ListTile(
      leading: Image.network(product.image ?? 'UnSupported',
      height: 60,width: 60,),
      title:  Text(product.productName ?? 'Unknown'),
      subtitle:  Wrap(
        spacing: 16,
        children: [
          Text('Unit Price: ${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: ${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: () async{
            final result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUpdateScreen(product: product )),);
            if(result == true){
               _getProductList();
            }
            },
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: (){
            _showDeleteConfirmationDialog(product.id!);
          }, icon: const Icon(Icons.delete_outline_sharp)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String productId){
    showDialog(context: context, builder: (context){
      return AlertDialog(
          title: const Text('Delete'),
        content:const Text('Are u sure that you want to delete this product'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),
          TextButton(onPressed: (){
            _deleteproduct(productId);
            Navigator.pop(context);
          }, child: const Text('Yes, delete')),
        ],
      );
    });
  }

  Future<void> _deleteproduct(String productId) async{

    _getProductInProgress = true;
    setState(() {

    });
    String getdeleteProductUrl = 'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(getdeleteProductUrl);

    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
       _getProductList();
    }
    else{
      _getProductInProgress = false;
      setState(() {

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete product failed !! Try Again')));
    }


}








}

