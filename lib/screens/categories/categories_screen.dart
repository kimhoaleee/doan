// ignore_for_file: use_super_parameters, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../deatils/details_screen.dart';

class Category {
  final String name;
  final String image;
  final int productCount;

  Category({
    required this.name,
    required this.image,
    required this.productCount,
  });
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Sample categories
  final List<Category> _categories = [
    Category(
      name: "Vegetables",
      image: "assets/images/img_1.png",
      productCount: 43,
    ),
    Category(
      name: "Fruits",
      image: "assets/images/img_2.png",
      productCount: 32,
    ),
    Category(name: "Dairy", image: "assets/images/img_3.png", productCount: 22),
    Category(name: "Meat", image: "assets/images/img_4.png", productCount: 15),
    Category(
      name: "Bakery",
      image: "assets/images/img_1.png",
      productCount: 28,
    ),
    Category(
      name: "Beverages",
      image: "assets/images/img_2.png",
      productCount: 36,
    ),
  ];

  String _selectedCategory = "Vegetables";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Categories", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Navigate to search screen
            },
          ),
        ],
      ),
      body: Row(
        children: [
          _buildCategorySidebar(),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }

  Widget _buildCategorySidebar() {
    return Container(
      width: 100,
      color: Colors.white,
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category.name == _selectedCategory;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = category.name;
              });
            },
            child: Container(
              height: 100,
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color:
                    isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                border: Border(
                  left: BorderSide(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? primaryColor.withOpacity(0.2)
                              : Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(category.image, height: 30, width: 30),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    // Filter products by selected category (in a real app)
    // For now, we'll just use the demo products
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: "Popular",
                underline: SizedBox(),
                icon: Icon(Icons.keyboard_arrow_down),
                items:
                    [
                      "Popular",
                      "Newest",
                      "Price: Low to High",
                      "Price: High to Low",
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  // Sort products
                },
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: defaultPadding,
                crossAxisSpacing: defaultPadding,
              ),
              itemCount: demo_products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(demo_products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    DetailsScreen(product: product, onProductAdd: () {}),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(product.image!, fit: BoxFit.contain),
              ),
            ),
            Text(product.title!, style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Fruits", style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$20.00/kg",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
