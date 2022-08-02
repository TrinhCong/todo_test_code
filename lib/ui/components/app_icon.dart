import 'package:flutter/material.dart';

class AppIcons {
  static const String account = "account";
  static const String ban = "ban";
  static const String bank = "bank";
  static const String bell = "bell";
  static const String back = "back";
  static const String bugReport = "bug-report";
  static const String biometricLogin = "biometric-login";
  static const String camera = "camera";
  static const String capitalMoney = "capital-money";
  static const String close = "close";
  static const String community = "community";
  static const String creditCard = "credit-card";
  static const String history = "history";
  static const String expandTime = "expand-time";
  static const String expiratedDate = "expirated-date";
  static const String info = "info";
  static const String key = "key";
  static const String logo = "logo";
  static const String logout = "logout";
  static const String money = "money";
  static const String moneyBarChart = "money-bar-chart";
  static const String pencil = "pencil";
  static const String plus = "plus";
  static const String potentialList = "potential-list";
  static const String organization = "organization";
  static const String recommendationList = "recommendation-list";
  static const String refresh = "refresh";
  static const String readMail = "read-mail";
  static const String priceTag = "price-tag";
  static const String privacy = "privacy";
  static const String question = "question";
  static const String todo = "todo";
  static const String save = "save";
  static const String settings = "settings";
  static const String smallLogo = "small_logo";
  static const String star = "star";
  static const String strategy = "strategy";
  static const String share = "share";
  static const String themeMode = "theme-mode";
  static const String transfer = "transfer";
  static const String trashCan = "trash-can";
  static const String useMoney = "use-money";
  static const String watchList = "watch-list";
  static const String wallet = "wallet";
}

class AppIcon extends StatelessWidget {
  final String data;
  final double size;
  const AppIcon(this.data, {Key? key, this.size = 24}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/icons/$data.png"),
          fit: BoxFit.contain
        ),
      ),
    );
  }
}
