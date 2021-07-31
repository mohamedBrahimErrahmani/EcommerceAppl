import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';
import 'package:intl/intl.dart';
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
var kInputFormat = DateFormat('dd/MM/yyyy');
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Entrer l'email' SVP";
const String kInvalidEmailError = "Entrer un email valide SVP";
const String kPassNullError = "Entrer le mot de passe SVP";
const String kShortPassError = "Le mot de passe est très court";
const String kMatchPassError = "Entrer un mot de passe valide SVP";
const String kNamelNullError = "Entrer votre nom SVP";
const String kPhoneNumberNullError = "Entrer votre numéro du téléphone SVP";
const String kAddressNullError = "Entrer votre adresse SVP";
const String kPriceNullError = "Entrer le prix SVP";
const String kTitleNullError = "Entrer le titre SVP";
const String kEnAttente = "enAttente";


final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
