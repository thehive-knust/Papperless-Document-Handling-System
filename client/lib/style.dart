import 'dart:ui';
import 'package:flutter/material.dart';

Color primary = Color(0xFF61B1F8);
Color primaryLight = Color(0xFFEFF7FF);
Color primaryDark = Color(0xFF2383D9);
Color green = Color(0xFF7CDC78);
Color red = Color(0xFFFF7E7E);
Color redLight = Colors.red.shade200;
Color yellow = Color(0xFFFFFFA8);
double desktopFontSize = 20;
double androidFontSize = 14;

const HOMEPAGE = "/";
const DETAILPAGE = "/detail_page";
const SENDPAGE = "/send_page";
const DESKTOPAUTHPAGE = "/desktop_auth_page";
const AUTHPAGE = "/auth_page";

InputDecoration authInputDecoration(String hint) => InputDecoration(
  filled: true,
  fillColor: primaryLight,
  hintText: hint,
  hoverColor: primary.withOpacity(.15),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(7), 
  borderSide: BorderSide(color: primary),
  )
            
);
