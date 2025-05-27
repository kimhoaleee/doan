// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../deatils/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _searchResults =
            demo_products
                .where(
                  (product) => product.title!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Search Products", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child:
                _isSearching
                    ? _buildLoadingIndicator()
                    : _searchResults.isEmpty &&
                        _searchController.text.isNotEmpty
                    ? _buildNoResultsFound()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        onChanged: _performSearch,
        decoration: InputDecoration(
          hintText: "Search for products...",
          prefixIcon: Icon(Icons.search, color: primaryColor),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch("");
                    },
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          SizedBox(height: defaultPadding),
          Text(
            "No results found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            "Try a different search term",
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return _searchController.text.isEmpty
        ? _buildRecentSearches()
        : ListView.builder(
          padding: EdgeInsets.all(defaultPadding),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return _buildSearchResultItem(_searchResults[index]);
          },
        );
  }

  Widget _buildRecentSearches() {
    // In a real app, you would store and retrieve recent searches
    List<String> recentSearches = ["Cabbage", "Carrot", "Broccoli"];

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Searches",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Clear recent searches
                },
                child: Text("Clear All", style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          ...recentSearches.map(
            (search) => ListTile(
              leading: Icon(Icons.history, color: Colors.grey),
              title: Text(search),
              trailing: Icon(Icons.north_west, size: 16, color: Colors.grey),
              onTap: () {
                _searchController.text = search;
                _performSearch(search);
              },
            ),
          ),
          SizedBox(height: defaultPadding),
          Text(
            "Popular Categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: defaultPadding / 2),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildCategoryChip("Vegetables"),
              _buildCategoryChip("Fruits"),
              _buildCategoryChip("Dairy"),
              _buildCategoryChip("Meat"),
              _buildCategoryChip("Bakery"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return InkWell(
      onTap: () {
        _searchController.text = category;
        _performSearch(category);
      },
      child: Chip(
        label: Text(category),
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade300),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildSearchResultItem(Product product) {
    return Card(
      margin: EdgeInsets.only(bottom: defaultPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(defaultPadding / 2),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(product.image!),
        ),
        title: Text(
          product.title!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Fruits • \$20.00/kg"),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
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
      ),
    );
  }
}
