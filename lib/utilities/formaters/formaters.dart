import 'package:intl/intl.dart';

class AppFormatters{

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();// If date is null, use current date
    return DateFormat('dd/MM/yyyy').format(date);// customise the date format as needed
  }

  static String formatCurrency(double? amount) {
    if (amount == null) return '0.00'; // Handle null case
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);// customise the currency format as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length==10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}'; // Format as (123) 456-7890
    } else if (phoneNumber.length==11 && phoneNumber.startsWith('0')) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}'; // Format as (123) 456-7890 for Ug numbers
    }
    //Add more custom phone number formating logic for different formats if needed
    return phoneNumber; // Return the original if it doesn't match known formats
  }

  static String internationalFormatPhoneNumber(String phoneNumber){
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    // Example: prepend country code if not present (Uganda +256)
    
    //Extract the country code from the digitsOnly
    String countryCode='+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);
    
     //Add thr remaining digits to the phone number with the proper format
     final formattedNumber=StringBuffer();
     formattedNumber.write('$countryCode ');

     int i = 0;
     while (i < digitsOnly.length) {
       int groupLength = 2;
       if (i == 0 && countryCode == '+256') {
         groupLength = 3; // For Uganda, the first group is 3 digits
       }

       int end = i + groupLength;
       if (end > digitsOnly.length) {
         end = digitsOnly.length;
       }
       formattedNumber.write(digitsOnly.substring(i, end));
       if (end < digitsOnly.length) {
         formattedNumber.write(' '); // Add space between groups
       }
       i = end;
     }
     return formattedNumber.toString();
}
}
