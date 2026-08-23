import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../support_chat/support_chat.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
        title: const Text(
          'Get Help',
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline_rounded,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.support_agent,
                size: 80,
                color: kPrimaryColor,
              ),
            ),
          ),
          const Center(
            child: Text(
              'We are here to help so please get in touch with us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '+254 719 892 432',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 2.0,
              bottom: 2.0,
              left: 15,
              right: 15,
            ),
            child: Divider(
              thickness: 1,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              'E-mail address',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'austinaeden@gmail.com',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
