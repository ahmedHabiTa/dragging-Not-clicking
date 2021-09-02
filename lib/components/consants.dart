import 'package:flutter/material.dart';


class Constants {
  Future<void> customDialog(context, String title, Function function) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black,fontSize: 18),
                ),
                Spacer(),
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 15,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    function();
                    Navigator.of(context).pop();
                  },
                  child: Text('ok')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel')),
            ],
          );
        });
  }
}
class LoadingAlertDialog extends StatelessWidget {
  final String message;
  const LoadingAlertDialog({ this.message}) ;

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(message,style: TextStyle(color: Colors.black87),),
        ],
      ),
    );
  }
}
class ErrorAlertDialog extends StatelessWidget {
  final String message;

  const ErrorAlertDialog({ this.message}) ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(
        message,
        style: TextStyle(color: Colors.black87),
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blue[900],
          child: Center(
            child: Text("OK"),
          ),
        ),
      ],
    );
  }
}


// class CustomTextField extends StatelessWidget {
//   final String valueKeyText;
//
//   final String labelText;
//
//   final Function validator;
//
//
//   final Function onEditingComplete;
//
//   final TextInputAction textInputAction;
//
//   final FocusNode focusNode;
//
//   final TextInputType textInputType;
//   final IconData prefixIcon;
//
//   final bool obscureText;
//   final Widget suffixIcon;
//
//   final inputFormatters;
//
//   final TextEditingController controller;
//
//   const CustomTextField({
//     this.valueKeyText,
//     this.labelText,
//     this.validator,
//     this.textInputAction,
//     this.focusNode,
//     this.textInputType,
//     this.prefixIcon,
//     this.obscureText,
//     this.suffixIcon,
//     this.onEditingComplete,
//     this.inputFormatters,
//     this.controller
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var themeMode = Provider.of<DarkThemeProvider>(context);
//     var isDarkMode = themeMode.darkTheme;
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         color: isDarkMode ? Colors.white : Colors.deepPurple[400],
//         child: Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: isDarkMode ? Theme.of(context).canvasColor : Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             //padding: EdgeInsets.all(8),
//             child: TextFormField(
//               controller: controller,
//               inputFormatters: inputFormatters,
//               focusNode: focusNode,
//               key: ValueKey(valueKeyText),
//               validator: validator,
//               textInputAction: textInputAction,
//               onEditingComplete: onEditingComplete,
//               keyboardType: textInputType,
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   suffixIcon: suffixIcon,
//                   prefixIcon: Icon(
//                     prefixIcon,
//                     color: isDarkMode ? Colors.white : Colors.deepPurple[400],
//                   ),
//                   labelText: labelText,
//                   labelStyle: TextStyle(
//                     color: isDarkMode ? Colors.white : Colors.deepPurple[400],
//                   )),
//               obscureText: obscureText,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
