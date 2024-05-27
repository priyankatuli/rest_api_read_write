class ProductModel {
  String ? id;
  String ? productName;
  String ? productCode;
  String ? image;
  String ? unitPrice;
  String ? quantity;
  String ? totalPrice;

//json ke extract kore proti ta product r value bochoye dibo
  ProductModel.fromJson(Map<String, dynamic>json){
    id = json['_id'] ;
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    unitPrice = json['UnitPrice'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
  }
}