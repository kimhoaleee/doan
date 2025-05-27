// ignore_for_file: prefer_final_fields, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../deatils/details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // In a real app, you would get this from a state management solution
  List<Product> _favorites = [demo_products[0], demo_products[2]];

  void _removeFromFavorites(Product product) {
    setState(() {
      _favorites.removeWhere((item) => item.title == product.title);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.title} removed from favorites"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              _favorites.add(product);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("My Favorites", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _favorites.isEmpty ? _buildEmptyFavorites() : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          SizedBox(height: defaultPadding),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            "Start adding some products to your favorites",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Browse Products"),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding),
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        return _buildFavoriteItem(_favorites[index]);
      },
    );
  }

  Widget _buildFavoriteItem(Product product) {
    return Dismissible(
      key: Key(product.title!),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeFromFavorites(product);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: defaultPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
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
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(product.image!),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Fruits", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 5),
                      Text(
                        "\$20.00/kg",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _removeFromFavorites(product),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: primaryColor),
                  onPressed: () {
                    // Add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${product.title} added to cart")),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
