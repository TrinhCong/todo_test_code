import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class StringHelper {
  static bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    var p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  static bool isPhoneNumber(String phoneNumber) {
    String patttern = r"^(?:[+0]9)?[0-9]{10,12}$";
    RegExp regExp = new RegExp(patttern);
    if (phoneNumber.length == 0) {
      return false;
    } else if (!regExp.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

  static String? parseDateToString(DateTime date, String format) {
    if (date != null) {
      var formatter = new DateFormat(format);
      return formatter.format(date);
    }
    return null;
  }

  static DateTime? parseStringToDate(String dateStr, String format) {
    if (dateStr != "" && dateStr != null) {
      var formatter = new DateFormat(format);
      return formatter.parse(dateStr);
    }
    return null;
  }

  static String? unixTimestampToString(int timestamp, String format) {
    return parseDateToString(
        DateTime.fromMillisecondsSinceEpoch(timestamp), format);
  }

  static AsciiCodec asciiCodec = AsciiCodec();

  ///
  /// Returns the given string or the default string if the given string is null
  ///
  static String defaultString(String str, {String defaultStr = ''}) {
    return str == null ? defaultStr : str;
  }

  ///
  /// Checks if the given String [s] is null or empty
  ///
  static bool isNullOrEmpty(String? s) =>
      (s == null || s.isEmpty || s.trim().isEmpty);

  ///
  /// Checks if the given String [s] is not null or empty
  ///
  static bool isNotNullOrEmpty(String? s) => !isNullOrEmpty(s);

  ///
  /// Transfers the given String [s] from camcelCase to upperCaseUnderscore
  /// Example : helloWorld => HELLO_WORLD
  ///
  static String camelCaseToUpperUnderscore(String s) {
    StringBuffer sb = StringBuffer();
    bool first = true;
    s.runes.forEach((int rune) {
      String char = String.fromCharCode(rune);
      if (isUpperCase(char) && !first) {
        sb.write("_");
        sb.write(char.toUpperCase());
      } else {
        first = false;
        sb.write(char.toUpperCase());
      }
    });
    return sb.toString();
  }

  ///
  /// Transfers the given String [s] from camcelCase to lowerCaseUnderscore
  /// Example : helloWorld => hello_world
  ///
  static String camelCaseToLowerUnderscore(String s) {
    StringBuffer sb = StringBuffer();
    bool first = true;
    s.runes.forEach((int rune) {
      String char = String.fromCharCode(rune);
      if (isUpperCase(char) && !first) {
        sb.write("_");
        sb.write(char.toLowerCase());
      } else {
        first = false;
        sb.write(char.toLowerCase());
      }
    });
    return sb.toString();
  }

  ///
  /// Checks if the given string [s] is lower case
  ///
  static bool isLowerCase(String s) {
    return s == s.toLowerCase();
  }

  ///
  /// Checks if the given string [s] is upper case
  ///
  static bool isUpperCase(String s) {
    return s == s.toUpperCase();
  }

  ///
  /// Checks if the given string [s] contains only ascii chars
  ///
  static bool isAscii(String s) {
    try {
      asciiCodec.decode(s.codeUnits);
    } catch (e) {
      return false;
    }
    return true;
  }

  ///
  /// Capitalize the given string [s]
  /// Example : world => World, WORLD => World
  ///
  static String capitalize(String s) {
    return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
  }

  ///
  /// Reverse the given string [s]
  /// Example : hello => olleh
  ///
  static String reverse(String s) {
    return String.fromCharCodes(s.runes.toList().reversed);
  }

  ///
  /// Counts how offen the given [char] apears in the given string [s].
  /// The value [caseSensitive] controlls whether it should only look for the given [char]
  /// or also the equivalent lower/upper case version.
  /// Example: Hello and char l => 2
  ///
  static int countChars(String s, String char, {bool caseSensitive = true}) {
    int count = 0;
    s.codeUnits.toList().forEach((i) {
      if (caseSensitive) {
        if (i == char.runes.first) {
          count++;
        }
      } else {
        if (i == char.toLowerCase().runes.first ||
            i == char.toUpperCase().runes.first) {
          count++;
        }
      }
    });
    return count;
  }

  ///
  /// Checks if the given string [s] is a digit.
  ///
  /// Will return false if the given string [s] is empty.
  ///
  static bool isDigit(String s) {
    if (s.isEmpty) {
      return false;
    }
    if (s.length > 1) {
      for (int r in s.runes) {
        if (r ^ 0x30 > 9) {
          return false;
        }
      }
      return true;
    } else {
      return s.runes.first ^ 0x30 <= 9;
    }
  }

  ///
  /// Compares the given strings [a] and [b].
  ///
  static bool equalsIgnoreCase(String a, String b) =>
      (a == null && b == null) ||
      (a != null && b != null && a.toLowerCase() == b.toLowerCase());

  ///
  /// Checks if the given [list] contains the string [s]
  ///
  static bool inList(String s, List<String> list, {bool ignoreCase = false}) {
    for (String l in list) {
      if (ignoreCase) {
        if (equalsIgnoreCase(s, l)) {
          return true;
        }
      } else {
        if (s == l) {
          return true;
        }
      }
    }
    return false;
  }

  ///
  /// Checks if the given string [s] is a palindrome
  /// Example :
  /// aha => true
  /// hello => false
  ///
  static bool isPalindrome(String s) {
    for (int i = 0; i < s.length / 2; i++) {
      if (s[i] != s[s.length - 1 - i]) return false;
    }
    return true;
  }

  ///
  /// Replaces chars of the given String [s] with [replace].
  ///
  /// The default value of [replace] is *.
  /// [begin] determines the start of the "replacing". If [begin] is null, it starts from index 0.
  /// [end] defines the end of the "replacing". If [end] is null, it ends at [s] length divided by 2.
  /// If [s] is empty or consists of only 1 char, the method returns null.
  ///
  /// Example :
  /// 1234567890 => *****67890
  /// 1234567890 with begin 2 and end 6 => 12****7890
  /// 1234567890 with begin 1 => 1****67890
  ///
  String? hidePartial(String s,
      {int begin = 0, int? end, String replace = "*"}) {
    StringBuffer buffer = StringBuffer();
    if (s.length <= 1) {
      return null;
    }
    if (end == null) {
      end = (s.length / 2).round();
    } else {
      if (end > s.length) {
        end = s.length;
      }
    }
    for (int i = 0; i < s.length; i++) {
      if (i >= end) {
        buffer.write(String.fromCharCode(s.runes.elementAt(i)));
        continue;
      }
      if (i >= begin) {
        buffer.write(replace);
        continue;
      }
      buffer.write(String.fromCharCode(s.runes.elementAt(i)));
    }
    return buffer.toString();
  }

  ///
  /// Add a [char] at a [position] with the given String [s].
  ///
  /// The boolean [repeat] defines whether to add the [char] at every [position].
  /// If [position] is greater than the length of [s], it will return [s].
  /// If [repeat] is true and [position] is 0, it will return [s].
  ///
  /// Example :
  /// 1234567890 , "-", 3 => 123-4567890
  /// 1234567890 , "-", 3, true => 123-456-789-0
  ///
  static String addCharAtPosition(String s, String char, int position,
      {bool repeat = false}) {
    if (!repeat) {
      if (s.length < position) {
        return s;
      }
      String before = s.substring(0, position);
      String after = s.substring(position, s.length);
      return before + char + after;
    } else {
      if (position == 0) {
        return s;
      }
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < s.length; i++) {
        if (i != 0 && i % position == 0) {
          buffer.write(char);
        }
        buffer.write(String.fromCharCode(s.runes.elementAt(i)));
      }
      return buffer.toString();
    }
  }

  ///
  /// Splits the given String [s] in chunks with the given [chunkSize].
  ///
  static List<String> chunk(String s, int chunkSize) {
    List<String> chunked = [];
    for (int i = 0; i < s.length; i += chunkSize) {
      int end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      chunked.add(s.substring(i, end));
    }
    return chunked;
  }

  static String toCurrency(int value) {
    return NumberFormat.simpleCurrency(locale: "vi").format(value);
  }

  static String toVnNumber(int value) {
    return NumberFormat.decimalPattern().format(value);
  }

  static String toVnDoubleNumber(double value) {
    return NumberFormat.decimalPattern().format(value);
  }

  static String shuffleString(int size) {
    return randomAlphaNumeric(size);
  }

  static String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String? Base64Encrypt(String text) {
    try {
      var encodedBytes = utf8.encode(text);
      var encodedText = base64.encode(encodedBytes);
      return encodedText;
    } catch (error) {}
    return null;
  }

  static String? Base64Decrypt(String base64Text) {
    try {
      var decodedBytes = base64.decode(base64Text);
      var decodedText = utf8.decode(decodedBytes);
      return decodedText;
    } catch (error) {}
    return null;
  }

  static String? CustomEncrypt(String text) {
    try {
      var encryptText = Base64Encrypt(text);
      var reversedText = (encryptText ?? "").split("").reversed.join();
      encryptText = Base64Encrypt(reversedText);
      return encryptText;
    } catch (error) {}
    return null;
  }

  static String? CustomDecrypt(String text) {
    try {
      var decryptText = Base64Decrypt(text);
      var reversedText = (decryptText ?? "").split("").reversed.join();
      decryptText = Base64Decrypt(reversedText);
      return decryptText;
    } catch (error) {}
    return null;
  }
}
