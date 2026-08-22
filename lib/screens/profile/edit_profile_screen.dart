import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'components/profile_pic.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.setUserFromAuthProvider(authProvider.user);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context);

    final currentUser = authProvider.user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: [
          const ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                buildEditUsernameFormField(
                  authProvider,
                  profileProvider,
                  currentUser,
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                buildEditEmailFormField(
                  authProvider,
                  profileProvider,
                  currentUser,
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                buildEditNumberFormField(
                  authProvider,
                  profileProvider,
                  currentUser,
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                buildEditGenderFormField(
                  authProvider,
                  profileProvider,
                  currentUser,
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await profileProvider.updateProfile(currentUser.uid);
                await authProvider.refreshUser();
                if (!mounted) return;
                Navigator.pop(context);
              }
            },
            child: Container(
              width: double.infinity,
              height: getProportionateScreenHeight(55),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Done",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(14),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildEditUsernameFormField(
      AuthProvider authProvider, ProfileProvider profileProvider, User currentUser) {
    // Use email prefix as default username
    final emailPrefix = currentUser.email.contains('@')
        ? currentUser.email.split('@')[0]
        : currentUser.email;
    // Prefill controller if empty
    if (profileProvider.nameController.text.trim().isEmpty) {
      profileProvider.nameController.text = emailPrefix;
    }
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.nameController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.account_circle_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  TextFormField buildEditEmailFormField(AuthProvider authProvider, ProfileProvider profileProvider, User currentUser) {
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter an email";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: currentUser.email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  TextFormField buildEditNumberFormField(AuthProvider authProvider, ProfileProvider profileProvider, User currentUser) {
    return TextFormField(
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
      ),
      controller: profileProvider.numberController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget buildEditGenderFormField(AuthProvider authProvider, ProfileProvider profileProvider, User currentUser) {
    const genderOptions = ['Male', 'Female'];
    String currentGender = profileProvider.genderController.text.trim();
    if (!genderOptions.contains(currentGender)) {
      currentGender = 'Male';
      profileProvider.genderController.text = currentGender;
    }

    return DropdownButtonFormField<String>(
      value: currentGender,
      style: TextStyle(
        fontSize: getProportionateScreenHeight(14),
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: "Gender",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 1.0),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.all(16),
      ),
      items: genderOptions.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (String? newGender) {
        if (newGender != null) {
          profileProvider.genderController.text = newGender;
        }
      },
    );
  }
}
