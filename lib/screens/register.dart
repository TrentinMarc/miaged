import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/user_service.dart';
import 'package:miaged/tools/constant.dart';
import 'package:miaged/tools/validators.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:miaged/widgets/popup.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController bdDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();

  final UserService _userService = UserService();

  String countryValue = "France";
  String stateValue = "";
  String cityValue = "";

  final _formKey = GlobalKey<FormState>();
  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Miaged",
        popable: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 40, bottom: 0),
                child: Text(
                  "Sign up",
                  style: GoogleFonts.comfortaa(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                child: Center(
                  child: SizedBox(
                      width: 400,
                      height: 150,
                      child: Image.network(
                          'https://thumbs.dreamstime.com/b/happy-dog-sign-board-welcome-text-says-hello-welcome-we%C3%A2%E2%82%AC%E2%84%A2re-open-happy-dog-chalkboard-welcome-text-says-hello-135894667.jpg')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: emailController,
                  validator: (text) => Validators.validateEmail(text!),
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(),
                      labelText: 'Login',
                      hintText: 'abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  validator: (text) => Validators.validatePassword(text!),
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Type a secure password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: confirmPwdController,
                  obscureText: true,
                  validator: (text) =>
                      Validators.confirmPassword(text!, pwdController.text),
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: 'Confirm password',
                      hintText: 'Must match password above'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: bdDateController,
                  validator: (text) => Validators.dateValidator(text!),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now())
                        .then((date) {
                      if (date != null) {
                        bdDateController.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }
                    });
                  },
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.cake),
                      border: OutlineInputBorder(),
                      labelText: 'Birthday Date',
                      hintText: '01/01/1970'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: addressController,
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: '21 Park Lane Cir, Toronto ON M3B 1Z8, Canada'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: CSCPicker(
                  dropdownDecoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: const Border(
                          bottom: BorderSide(color: Colors.white))),
                  disabledDropdownDecoration: const BoxDecoration(
                      color: Colors.grey,
                      border: Border(bottom: BorderSide(color: Colors.white))),
                  disableCountry: true,
                  defaultCountry: DefaultCountry.values
                      .elementAt(DefaultCountry.France.index),
                  showStates: true,
                  showCities: true,
                  onCountryChanged: (value) {
                    setState(() {
                      if (value != null) {
                        countryValue = value;
                      }
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      if (value != null) {
                        stateValue = value;
                      }
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      if (value != null) {
                        cityValue = value;
                        cityController.text = cityValue;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: cityController,
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      hintText: 'Nice'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: postalCodeController,
                  validator: (text) => Validators.postalCodeValidator(text!),
                  style: GoogleFonts.comfortaa(fontSize: 16),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.local_post_office_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Postal Code',
                      hintText: '06000'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var email = emailController.text.trim();
                        var pwd = pwdController.text.trim();
                        var address = addressController.text.trim();
                        var birthdayDate = bdDateController.text.trim();
                        var postalCode = postalCodeController.text.trim();
                        var city = cityController.text.trim();
                        MiagedUser newUser = MiagedUser.forSignUp(
                            email,
                            pwd,
                            birthdayDate,
                            address,
                            postalCode,
                            city,
                            MiagedUser.DEFAULT_AVATAR_LINK);
                        var authenticationResponse =
                            await _authenticationService.newUser(newUser);

                        if (authenticationResponse["isCreated"]) {
                          newUser.setUID(
                              authenticationResponse["message"].toString());
                          Map<String, dynamic> userResponse =
                              await _userService.newUser(newUser);
                          if (userResponse["isCreated"]) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => const Popup(
                                popupName: "Success",
                                popupMessage: "User created, Welcome !",
                                popupStyle: popupWelcome,
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Popup(
                                popupName: "Error",
                                popupMessage:
                                    userResponse["message"].toString(),
                                popupStyle: popupError,
                              ),
                            );
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Popup(
                              popupName: "Error",
                              popupMessage:
                                  authenticationResponse["message"].toString(),
                              popupStyle: popupError,
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
