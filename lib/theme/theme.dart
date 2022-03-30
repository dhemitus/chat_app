import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double defaultPadding = 24;
double defaultMargin = 36;
double defaultRadius = 8.r;
double defaultBottom = 150;

Color kPrimaryColor = Color(0XFFFFEB00);
Color kBlackColor = Color(0XFF212121);
Color kRedColor = Color(0XFFFF0F0F);
Color kWhiteColor = Color(0XFFFFFFFF);
Color kGreyColor = Color(0XFFF6F6F6);
Color kDarkGreyColor = Color(0XFF909090);
Color kLigthGrayColor = Color(0XFFE4E4E4);
Color kLightYellowColor = Color(0XFFfffcdf);
Color kTransparent = Colors.transparent;

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

TextStyle darkGreyTextStyle = GoogleFonts.poppins(
  color: kDarkGreyColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);

TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

FontWeight light = FontWeight.w300;
FontWeight normal = FontWeight.w400;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

Icon libraryIcon = Icon(Icons.subject_sharp);
Icon editIcon = Icon(Icons.edit_outlined);