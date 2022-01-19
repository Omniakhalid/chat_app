import 'package:flutter/material.dart';
class Constants{
  static final decoration= const BoxDecoration(
  color: Colors.white,
  image: DecorationImage(image: AssetImage("assets/images/bkg.png"),fit: BoxFit.fill),
  );
  static final txtStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 24);
  static getCategoryImage(String category){
    return AssetImage('assets/images/${category=='Movies'? 'movies':category=='Sports'?'sports':category=='Music'?'music':null}.png');
  }
}