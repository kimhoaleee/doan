// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:test_4/constants.dart';
import 'package:test_4/controllers/home_controller.dart';
import 'package:test_4/models/Product.dart';
import 'package:test_4/screens/categories/categories_screen.dart';
import 'package:test_4/screens/deatils/details_screen.dart';
import 'package:test_4/screens/favorites/favorites_screen.dart';
import 'package:test_4/screens/orders/order_history_screen.dart';
import 'package:test_4/screens/profile/profile_screen.dart';
import 'package:test_4/screens/search/search_screen.dart';
import 'package:test_4/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';
import 'components/header.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  final controller = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: panelTransition,
                        top:
                            controller.homeState == HomeState.normal
                                ? headerHeight
                                : -(constraints.maxHeight -
                                    cartBarHeight * 2 -
                                    headerHeight),
                        left: 0,
                        right: 0,
                        height:
                            constraints.maxHeight -
                            headerHeight -
                            cartBarHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(defaultPadding * 1.5),
                              bottomRight: Radius.circular(
                                defaultPadding * 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSearchBar(context),
                              _buildCategoryRow(context),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: demo_products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.75,
                                        mainAxisSpacing: defaultPadding,
                                        crossAxisSpacing: defaultPadding,
                                      ),
                                  itemBuilder:
                                      (context, index) => ProductCard(
                                        product: demo_products[index],
                                        press: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                    milliseconds: 500,
                                                  ),
                                              reverseTransitionDuration:
                                                  const Duration(
                                                    milliseconds: 500,
                                                  ),
                                              pageBuilder:
                                                  (
                                                    context,
                                                    animation,
                                                    secondaryAnimation,
                                                  ) => FadeTransition(
                                                    opacity: animation,
                                                    child: DetailsScreen(
                                                      product:
                                                          demo_products[index],
                                                      onProductAdd: () {
                                                        controller
                                                            .addProductToCart(
                                                              demo_products[index],
                                                            );
                                                      },
                                                    ),
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Card Panel
                      AnimatedPositioned(
                        duration: panelTransition,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height:
                            controller.homeState == HomeState.normal
                                ? cartBarHeight
                                : (constraints.maxHeight - cartBarHeight),
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            color: Color(0xFFEAEAEA),
                            alignment: Alignment.topLeft,
                            child: AnimatedSwitcher(
                              duration: panelTransition,
                              child:
                                  controller.homeState == HomeState.normal
                                      ? CardShortView(controller: controller)
                                      : CartDetailsView(controller: controller),
                            ),
                          ),
                        ),
                      ),
                      // Header
                      AnimatedPositioned(
                        duration: panelTransition,
                        top:
                            controller.homeState == HomeState.normal
                                ? 0
                                : -headerHeight,
                        right: 0,
                        left: 0,
                        height: headerHeight,
                        child: HomeHeader(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                SizedBox(height: defaultPadding / 2),
                Text(
                  "Lê Thị Kim Hoa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "kimhoa@example.com",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: "Home",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.category,
            title: "Categories",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.favorite,
            title: "Favorites",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag,
            title: "My Orders",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
              );
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.person,
            title: "My Profile",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.help,
            title: "Help & Support",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              Navigator.pop(context);
              // Show logout confirmation dialog
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: defaultPadding / 2),
            Text(
              "Search for products...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context) {
    final categories = ["All", "Vegetables", "Fruits", "Dairy", "Meat"];

    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: defaultPadding),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: defaultPadding),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              decoration: BoxDecoration(
                color: index == 0 ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border:
                    index == 0 ? null : Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: index == 0 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
