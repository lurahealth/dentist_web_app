import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// colours
final Color LURA_BLUE = Color(0xFF405280);
final Color LURA_LIGHT_BLUE = Color(0xFF26afde);
final Color LURA_ORANGE = Color(0xFFee4221);
final Color LURA_LIGHT_ORANGE = Color(0xFFf35e73);

// TextStyle
const TextStyle WHITE_TEXT = TextStyle(color: Colors.white);
const TextStyle ERROR_TEXT = TextStyle(color: Colors.redAccent, fontSize: 13);

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

