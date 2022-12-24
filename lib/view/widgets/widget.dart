import 'package:flutter/material.dart';

InputDecoration customTextField(String labelText) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ));
}

InputDecoration customTextFieldChat(String text) {
  return InputDecoration(
    prefix: Text(text),
  );
}

TextStyle buttonText() {
  return TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
}

TextStyle customText() {
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

TextStyle customTextTile() {
  return TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}

TextStyle customTextTileEmail() {
  return TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 12,
  );
}

TextStyle customTextTitle() {
  return TextStyle(
      color: Colors.deepOrange, fontSize: 32, fontWeight: FontWeight.bold);
}

TextStyle textBtn() {
  return TextStyle(
    color: Colors.deepOrange,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
}
