class AppValidator{
  //empty text validation
  static String? validateEmptyText(String? fieldName, String? value){
    if (value==null||value.isEmpty){
      return '$fieldName is required.';
    }
    return null;
  }
  static String? validateEmail(String? value){
    if (value== null || value.isEmpty){
      return 'Email is required.';
    }

    //replace expressionfor email validation
    final emailRegExp=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)){
      return 'Invalid email addresss.';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if (value==null|| value.isEmpty){
      return 'password is required.';
    }
    //check for minimum password length
  if (value.length<8){
    return 'password must contain at least 8 characters.';
  }

  //check for numbers
  if (!value.contains(RegExp(r'[0-9]'))){
    return 'password must contain atleast one number.';
  }

  //check for special characters
  if (!value.contains(RegExp(r'[!@#$%^&*():{}<>|]'))){
    return 'password must contain atleast one special character.';
  }
  return null;
  
  }

  static String? validatePhoneNumber(String? value){
    if (value==null||value.isEmpty){
      return 'phone number is reqired';
    }
    
    //Regular expression for phone number validation(assuming a 10-digit ug phone number format)
    final phoneRegExp=RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)){
      return 'Invalid phone number format (10 digits required).';
    }
    return null;
}


}
