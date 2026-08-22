import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

String apiKey = '';
String apiEndPoint = 'https://amazon-products1.p.rapidapi.com/product';

Future<void> getProducts() async {
  final response = await http.get(
    Uri.parse(apiEndPoint),
    headers: <String, String>{
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': 'amazon-products1.p.rapidapi.com',
    },
  );
  if (response.statusCode == 200) {
    log(response.body);
  } else {
    log(response.statusCode.toString());
  }
}

String generateOrderId() {
  const uuid = Uuid();
  return uuid.v4(); // Generate a random UUID
}

Color convertStringToColor(String colorStr) {
  if (colorStr.isEmpty) return Colors.grey;

  final cleanStr = colorStr.trim().toLowerCase();
  switch (cleanStr) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'navy':
    case 'navy blue':
      return const Color(0xFF000080);
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'gray':
    case 'grey':
      return Colors.grey;
    case 'dark gray':
    case 'dark grey':
      return const Color(0xFFA9A9A9);
    case 'charcoal':
      return const Color(0xFF36454F);
    case 'green':
      return Colors.green;
    case 'olive green':
    case 'olive':
      return const Color(0xFF808000);
    case 'khaki':
      return const Color(0xFFF0E68C);
    case 'yellow':
      return Colors.yellow;
    case 'brown':
      return Colors.brown;
    case 'tan':
      return const Color(0xFFD2B48C);
    case 'blue denim':
    case 'denim':
      return const Color(0xFF1560BD);
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'purple':
      return Colors.purple;
  }

  // Handle Hex formats: #RRGGBB, 0x..., etc.
  try {
    String hex = colorStr.replaceAll('#', '').replaceAll('0x', '').trim();
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    }
  } catch (_) {}

  return Colors.grey;
}
