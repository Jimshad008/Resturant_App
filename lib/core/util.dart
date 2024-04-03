
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(

      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(text,style: const TextStyle(color: Colors.white),),
      ),
    );
}