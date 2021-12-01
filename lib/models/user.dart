import 'package:cloud_firestore/cloud_firestore.dart';

class User {
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

  User(this._UID, this._avatarLink, this._login, this._password,
      this._birthDayDate, this._address, this._postalCode, this._city);

  User.forUpdate(this._login, this._password, this._birthDayDate, this._address,
      this._postalCode, this._city, this._avatarLink);

  User.fromSnapshot(DocumentSnapshot snapshot) {
    _UID = snapshot[USER_UID];
    _avatarLink = snapshot[AVATAR_LINK];
    _login = snapshot[LOGIN];
    _password = snapshot[PASSWORD];
    _birthDayDate = snapshot[BIRTHDAY_DATE];
    _address = snapshot[ADDRESS];
    _postalCode = snapshot[POSTAL_CODE];
    _city = snapshot[CITY];
  }

  @override
  String toString() {
    return 'User{_UID: $_UID, _avatarLink: $_avatarLink, _login: $_login, _password: $_password, _birthDayDate: $_birthDayDate, _address: $_address, _postalCode: $_postalCode, _city: $_city}';
  }
}
