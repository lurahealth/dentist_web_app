import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// colours
const Color LURA_BLUE         = Color(0xFF405280);
const Color LURA_LIGHT_BLUE   = Color(0xFF26afde);
const Color LURA_ACCENT_BLUE  = Color(0xFF68CEEA);
const Color LURA_MINT_BLUE    =  Color(0xFF98DCD1);
const Color LURA_DARK_BLUE    = Color(0xFF526aa6);
const Color LURA_ORANGE       = Color(0xFFee4221);
const Color LURA_LIGHT_ORANGE = Color(0xFFf35e73);

// TextStyle
const TextStyle WHITE_TEXT = TextStyle(color: Colors.white);
const TextStyle GREEN_TEXT = TextStyle(color: Colors.green);
const TextStyle ERROR_TEXT = TextStyle(color: Colors.redAccent, fontSize: 13);
const TextStyle LURA_BLUE_TEXT = TextStyle(color: LURA_BLUE);
const TextStyle WHITE_TITLE = TextStyle(color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold);

const TextStyle WHITE_SUB_TITLE = TextStyle(color: Colors.white, fontSize: 15);

Column textField(String hint, String label, TextInputType inputType,
    Function onChangeListener, bool textValid, String errorText, IconData prefixIcon,
    {bool obscureText = false, IconButton suffixIcon}) {
  return Column(
    children: <Widget>[
      TextField(
          obscureText: obscureText,
          onChanged: onChangeListener,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon,
            hintText: hint,
            labelText: label,),
      ),
      Visibility(
          visible: !textValid,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  errorText,
                  style: ERROR_TEXT,
                ),
              ],
            ),
          ))
    ],
  );
}

