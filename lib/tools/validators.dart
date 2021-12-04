class Validators {
  static String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.isNotEmpty) {
      if (value.length < 6) {
        return "Password should contain more than 5 characters";
      }
    } else {
      return "This field is required";
    }
    return null;
  }

  static String? dateValidator(String value) {
    String pattern =
        r"^(?:(?:31(\/)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$";
    RegExp regex = RegExp(pattern);
    if (value.isNotEmpty) {
      if (!regex.hasMatch(value)) {
        return 'Required field, The date must to fit DD/MM/YYYY format';
      }
    } else {
      return "This field is required";
    }
    return null;
  }

  static String? postalCodeValidator(String value) {
    String pattern = r"^((([0-8][0-9])|(9[0-5])|(2[AB]))[0-9]{3})|98000$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty) {
      return 'Postal code only can be composed of 5 digits';
    } else {
      return null;
    }
  }
}
