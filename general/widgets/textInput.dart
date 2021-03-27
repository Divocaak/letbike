import 'package:flutter/material.dart';
import '../pallete.dart';

String regMail,
    regName,
    regPass,
    regPassConf,
    logMail,
    logPass,
    accFName,
    accLName,
    accPhone,
    accAddA,
    accAddB,
    accAddC,
    accPostal,
    changePassCurr,
    changePassNew,
    changePassConf,
    addName,
    addDesc,
    addPrice;

class TextInput extends StatelessWidget {
  const TextInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.identificator,
      this.inputType,
      this.inputAction,
      this.obscure})
      : super(key: key);

  final IconData icon;
  final String hint;
  final String identificator;
  final bool obscure;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 10 * 5.5,
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kSecondaryColor,
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(icon, size: 28, color: kWhite),
              ),
              hintText: hint,
              hintStyle: kTitleTextStyle,
            ),
            obscureText: obscure != null ? obscure : false,
            style: kTitleTextStyle,
            keyboardType: inputType,
            textInputAction: inputAction,
            validator: (String value) {
              if (value.isEmpty) {
                return "Zadejte " + hint;
              }

              if (identificator == "regMail" || identificator == "logMail") {
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return "Zadejte platný e-mail";
                }
              }

              if ((identificator == "regPass" && value.length < 8) ||
                  (identificator == "changePassNew" && value.length < 8)) {
                return "Heslo musí obsahovat minimálně 8 znaků";
              }

              if (identificator == "regPass" ||
                  identificator == "regPassConf") {
                if (regPass != regPassConf) {
                  return "Hesla se neshodují";
                }
              }

              if (identificator == "changePassNew" ||
                  identificator == "changePassConf") {
                if (changePassNew != changePassConf) {
                  return "Hesla se neshodují";
                }
              }
              return null;
            },
            onChanged: (String content) {
              setValue(identificator, content);
            },
          ),
        ),
      ),
    );
  }

  static String getValue(String identity) {
    switch (identity) {
      case "regMail":
        {
          return regMail;
        }
        break;
      case "regName":
        {
          return regName;
        }
        break;
      case "regPass":
        {
          return regPass;
        }
        break;
      case "regPassConf":
        {
          return regPassConf;
        }
        break;
      case "logMail":
        {
          return logMail;
        }
        break;
      case "logPass":
        {
          return logPass;
        }
        break;
      case "accFName":
        {
          return accFName;
        }
        break;
      case "accLName":
        {
          return accLName;
        }
        break;
      case "accPhone":
        {
          return accPhone;
        }
        break;
      case "accAddA":
        {
          return accAddA;
        }
        break;
      case "accAddB":
        {
          return accAddB;
        }
        break;
      case "accAddC":
        {
          return accAddC;
        }
        break;
      case "accPostal":
        {
          return accPostal;
        }
        break;
      case "changePassCurr":
        {
          return changePassCurr;
        }
        break;
      case "changePassNew":
        {
          return changePassNew;
        }
        break;
      case "changePassConf":
        {
          return changePassConf;
        }
        break;
      case "addName":
        {
          return addName;
        }
        break;
      case "addDesc":
        {
          return addDesc;
        }
        break;
      case "addPric":
        {
          return addPrice;
        }
        break;
    }
    return "";
  }

  static void setValue(String identificator, String content) {
    switch (identificator) {
      case "regMail":
        {
          regMail = content;
        }
        break;
      case "regName":
        {
          regName = content;
        }
        break;
      case "regPass":
        {
          regPass = content;
        }
        break;
      case "regPassConf":
        {
          regPassConf = content;
        }
        break;
      case "logMail":
        {
          logMail = content;
        }
        break;
      case "logPass":
        {
          logPass = content;
        }
        break;
      case "accFName":
        {
          accFName = content;
        }
        break;
      case "accLName":
        {
          accLName = content;
        }
        break;
      case "accPhone":
        {
          accPhone = content;
        }
        break;
      case "accAddA":
        {
          accAddA = content;
        }
        break;
      case "accAddB":
        {
          accAddB = content;
        }
        break;
      case "accAddC":
        {
          accAddC = content;
        }
        break;
      case "accPostal":
        {
          accPostal = content;
        }
        break;
      case "changePassCurr":
        {
          changePassCurr = content;
        }
        break;
      case "changePassNew":
        {
          changePassNew = content;
        }
        break;
      case "changePassConf":
        {
          changePassConf = content;
        }
        break;
      case "addName":
        {
          addName = content;
        }
        break;
      case "addDesc":
        {
          addDesc = content;
        }
        break;
      case "addPric":
        {
          addPrice = content;
        }
        break;
    }
  }
}
