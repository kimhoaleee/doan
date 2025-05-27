// ignore_for_file: use_super_parameters, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../controllers/auth_controller.dart';
import '../../models/User.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // In a real app, you would get this from your AuthController
  final User user = User(
    id: "1",
    name: "Lê Thị Kim Hoa",
    email: "kimhoa@example.com",
    profileImage: "assets/images/profile.png",
  );

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: "+84 123 456 789");
    _addressController = TextEditingController(
      text: "123 Nguyen Hue, Ho Chi Minh City",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would update the user profile in your backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile updated successfully"),
          backgroundColor: primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("My Profile", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [_buildProfileHeader(), _buildProfileForm()]),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(user.profileImage!),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    onPressed: () {
                      // Add image picker functionality
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Text(
            user.name!,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(user.email!, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Container(
      margin: EdgeInsets.all(defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: defaultPadding),
            _buildTextField(
              controller: _nameController,
              label: "Full Name",
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding),
            _buildTextField(
              controller: _emailController,
              label: "Email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                if (!value.contains('@')) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding),
            _buildTextField(
              controller: _phoneController,
              label: "Phone Number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your phone number";
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding),
            _buildTextField(
              controller: _addressController,
              label: "Address",
              icon: Icons.location_on,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your address";
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("Save Changes", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      validator: validator,
    );
  }
}
