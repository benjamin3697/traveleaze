import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppHelperFunctions{

  static Color? getColor(String value){
    if (value == 'red') {
      return Colors.red;
    } else if (value == 'green') {
      return Colors.green;
    } else if (value == 'blue') {
      return Colors.blue;
    } else if (value == 'yellow') {
      return Colors.yellow;
    } else if (value == 'purple') {
      return Colors.purple;
    } else if (value == 'pink') {
      return Colors.pink;
    } else if (value == 'orange') {
      return Colors.orange;
    } else if (value == 'grey') {
      return Colors.grey;
    } else if (value == 'black') {
      return Colors.black;
    } else if (value == 'white') {
      return Colors.white;
    } else if (value == 'brown') {
      return Colors.brown;
    } else if (value == 'cyan') {
      return Colors.cyan;
    } else if (value == 'teal') {
      return Colors.teal;
    } else if (value == 'indigo') {
      return Colors.indigo;
    } else if (value == 'amber') {
      return Colors.amber;
    } else if (value == 'lime') {
      return Colors.lime;
    } else if (value == 'lightBlue') {
      return Colors.lightBlue;
    } else if (value == 'lightGreen') {
      return Colors.lightGreen;
    } else if (value == 'deepOrange') {
      return Colors.deepOrange;
    } else if (value == 'deepPurple') {
      return Colors.deepPurple;
    } else if (value == 'blueGrey') {
      return Colors.blueGrey;
    } else if (value == 'transparent') {
      return Colors.transparent;
    } else if (value == 'primary') {
      return Get.theme.primaryColor;
    } else if (value == 'accent') {
      return Get.theme.colorScheme.secondary;
    } else if (value == 'error') {
      return Get.theme.colorScheme.error;
    } else if (value == 'background') {
      return Get.theme.colorScheme.surface;
    } else if (value == 'surface') {
      return Get.theme.colorScheme.surface;
    } else if (value == 'onPrimary') {
      return Get.theme.colorScheme.onPrimary;
    } else if (value == 'onSecondary') {
      return Get.theme.colorScheme.onSecondary;
    } else if (value == 'onError') {
      return Get.theme.colorScheme.onError;
    } else if (value == 'onBackground') {
      return Get.theme.colorScheme.onSurface;
    } else if (value == 'onSurface') {
      return Get.theme.colorScheme.onSurface;
    } else if (value == 'brightnessLight') {
      return Get.theme.brightness == Brightness.light ? Colors.white : Colors.black;
    } else if (value == 'brightnessDark') {
      return Get.theme.brightness == Brightness.dark ? Colors.black : Colors.white;
    } else if (value == 'brightness') {
      return Get.theme.brightness == Brightness.light ? Colors.white : Colors.black;
    } else if (value == 'primaryColor') {
      return Get.theme.primaryColor;
    } else if (value == 'secondaryColor') {
      return Get.theme.colorScheme.secondary;
    } else if (value == 'primaryColorLight') {
      return Get.theme.primaryColorLight;
    } else if (value == 'primaryColorDark') {
      return Get.theme.primaryColorDark;
    } else {
      return null;
    }
}

    static void showSnackBar(String message) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }

    static void showAlert(String title,String message) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    static void navigateToScreen(BuildContext context,Widget screen) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    }

    static String truncateString(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

    static bool isDarkMode(BuildContext context) {
      return Theme.of(context).brightness == Brightness.dark;
    }

    static Size screenSize() {
      return MediaQuery.of(Get.context!).size;
    }

    static double screenWidth() {
      return MediaQuery.of(Get.context!).size.width;
    }
    static double screenHeight() {
      return MediaQuery.of(Get.context!).size.height;
    }
    static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
      return DateFormat(format).format(date);
    }

    static List<String> getDaysOfWeek() {
      return [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
      ];
    }

    static List<String> getMonthsOfYear() {
      return [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
    }

    static List<App> removeDuplicates<App>(List<App> list) {
      return list.toSet().toList();
    }

    static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
      final wrappedList = <Widget>[];
      for (var i=0; i < widgets.length; i += rowSize){
        final rowChildren=widgets.sublist(i, i +rowSize > widgets.length? widgets.length:i + rowSize);
        wrappedList.add(Row(children:rowChildren));
      }
      return wrappedList;
}
}
