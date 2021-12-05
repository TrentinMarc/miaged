// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class MiagedUser {
  static const COLLECTION_NAME = "user";
  static const SUB_COLLECTION_CART_NAME = "cart";
  static const USER_UID = "UID";
  static const SUB_COLLECTION_CART_ID_PRODUCT = "idProduct";
  static const AVATAR_LINK = "avatarLink";
  static const ADDRESS = "address";
  static const LOGIN = "login";
  static const PASSWORD = "password";
  static const BIRTHDAY_DATE = "birthdayDate";
  static const POSTAL_CODE = "postalCode";
  static const CITY = "city";
  static const DEFAULT_AVATAR_LINK =
      "https://stickers-muraux-enfant.fr/12823/sticker-hublot-mario-waluigi.jpg";

  late String _UID;
  late String _avatarLink;
  late String _login;
  late String _password;
  late String _birthDayDate;
  late String _address;
  late String _postalCode;
  late String _city;

  String get UID => _UID;

  String get avatarLink => _avatarLink;

  String get login => _login;

  String get password => _password;

  String get birthDayDate => _birthDayDate;

  String get address => _address;

  String get postalCode => _postalCode;

  String get city => _city;

  void setUID(String UID) {
    _UID = UID;
  }

  MiagedUser(this._UID, this._avatarLink, this._login, this._password,
      this._birthDayDate, this._address, this._postalCode, this._city);

  MiagedUser.forUpdate(this._login, this._password, this._birthDayDate,
      this._address, this._postalCode, this._city, this._avatarLink);

  MiagedUser.forSignUp(this._login, this._password, this._birthDayDate,
      this._address, this._postalCode, this._city, this._avatarLink);

  MiagedUser.fromSnapshot(DocumentSnapshot snapshot) {
    _UID = snapshot[USER_UID];
    _avatarLink = snapshot[AVATAR_LINK];
    _login = snapshot[LOGIN];
    _password = snapshot[PASSWORD];
    _birthDayDate = snapshot[BIRTHDAY_DATE];
    _address = snapshot[ADDRESS];
    _postalCode = snapshot[POSTAL_CODE];
    _city = snapshot[CITY];
  }

  static Map<String, String> toJSON(MiagedUser user) {
    Map<String, String> json = {
      USER_UID: user.UID,
      LOGIN: user.login,
      PASSWORD: user.password,
      BIRTHDAY_DATE: user.birthDayDate,
      ADDRESS: user.address,
      POSTAL_CODE: user.postalCode,
      CITY: user.city,
      AVATAR_LINK: user._avatarLink
    };

    return json;
  }

  @override
  String toString() {
    return 'User{_UID: $_UID, _avatarLink: $_avatarLink, _login: $_login, _password: $_password, _birthDayDate: $_birthDayDate, _address: $_address, _postalCode: $_postalCode, _city: $_city}';
  }
}
