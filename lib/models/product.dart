class Product {
  final String? productName;
  final String? description;
  final String? price;
  final String? image;

  Product({
    this.productName,
    this.description,
    this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json['ProductName']?.toString(),
        description: json['Description']?.toString(),
        price: json['Price']?.toString(),
        image: json['Image']?.toString(),
      );
} 
