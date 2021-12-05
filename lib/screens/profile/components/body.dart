import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/user_service.dart';
import 'package:miaged/tools/constant.dart';
import 'package:miaged/tools/validators.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';
import 'package:miaged/widgets/popup.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody(
      {Key? key, required this.currentUser, required this.callBackParent})
      : super(key: key);
  final MiagedUser currentUser;
  final Function callBackParent;

  @override
  _ProfileScreenBodyState createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final UserService _userService = UserService();
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    loginController.text = widget.currentUser.login;
    passwordController.text = widget.currentUser.password;
    addressController.text = widget.currentUser.address;
    postalCodeController.text = widget.currentUser.postalCode;
    bDayController.text = widget.currentUser.birthDayDate;
    cityController.text = widget.currentUser.city;
    avatarController.text = widget.currentUser.avatarLink;
  }

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPwdController = TextEditingController();
  var bDayController = TextEditingController();
  var addressController = TextEditingController();
  var postalCodeController = TextEditingController();
  var cityController = TextEditingController();
  var avatarController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  "Please paste your avatar's link below",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              content: TextField(
                                controller: avatarController,
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Done"))
                              ],
                            );
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          widget.currentUser.avatarLink,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child: DogoProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              MiagedUser.DEFAULT_AVATAR_LINK,
                              width: 110.0,
                              height: 110.0,
                              fit: BoxFit.fill,
                            );
                          },
                          width: 110.0,
                          height: 110.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    tooltip: 'Tips',
                    color: const Color(royalBlue),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => const Popup(
                          popupName: "Tips",
                          popupMessage:
                              "Here you can update your perosnal data, click the picture to edit ! (if passed url isn't available, you'll have the Waluigi default avatar.)",
                          popupStyle: popupInfo,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My informations",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: loginController,
                      readOnly: true,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          border: OutlineInputBorder(),
                          labelText: 'Login',
                          hintText: 'abc@gmail.com'),
                    ),
                    TextFormField(
                      controller: passwordController,
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
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      validator: (text) {
                        if (text != null && text != '') {
                          return Validators.validatePassword(text);
                        } else {
                          return null;
                        }
                      },
                      // validator: (text) => Validators.validatePassword(text!),
                      style: GoogleFonts.comfortaa(
                          fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                          hintText: 'Type a secure password'),
                    ),
                    TextFormField(
                      controller: confirmPwdController,
                      obscureText: true,
                      validator: (text) {
                        if (text != null) {
                          return Validators.confirmPassword(
                              text, newPasswordController.text);
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password',
                          hintText: 'Must match password above'),
                    ),
                    TextFormField(
                      controller: bDayController,
                      validator: (text) => Validators.dateValidator(text!),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime.now())
                            .then((date) {
                          if (date != null) {
                            bDayController.text =
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
                    CSCPicker(
                      dropdownDecoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: const Border(
                              bottom: BorderSide(color: Colors.white))),
                      disabledDropdownDecoration: const BoxDecoration(
                          color: Colors.grey,
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
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
                            cityController.text = value;
                          }
                        });
                      },
                    ),
                    TextFormField(
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
                    TextFormField(
                      controller: postalCodeController,
                      validator: (text) =>
                          Validators.postalCodeValidator(text!),
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.local_post_office_outlined),
                          border: OutlineInputBorder(),
                          labelText: 'Postal Code',
                          hintText: '06000'),
                    ),
                    TextFormField(
                      controller: addressController,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.place),
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          hintText:
                              '21 Park Lane Cir, Toronto ON M3B 1Z8, Canada'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  onSurface: Colors.transparent),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var login = loginController.text.trim();
                                  var password = passwordController.text.trim();
                                  if (newPasswordController.text != '') {
                                    password =
                                        newPasswordController.text.trim();
                                  }
                                  var address = addressController.text.trim();
                                  var postalCode =
                                      postalCodeController.text.trim();
                                  var birthdayDate = bDayController.text.trim();
                                  var city = cityController.text.trim();
                                  var avatarLink = avatarController.text.trim();
                                  var newData = MiagedUser.forUpdate(
                                      login,
                                      password,
                                      birthdayDate,
                                      address,
                                      postalCode,
                                      city,
                                      avatarLink);
                                  var isUpdated =
                                      await _userService.updateUser(newData);
                                  if (isUpdated) {
                                    await _authenticationService
                                        .updatePassword(password);
                                    FocusScope.of(context).unfocus();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Popup(
                                        popupName: "Done",
                                        popupMessage:
                                            "Your data has been updated !",
                                        popupStyle: popupSuccess,
                                      ),
                                    ).then(
                                        (value) => {widget.callBackParent()});
                                  } else {
                                    FocusScope.of(context).unfocus();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Popup(
                                        popupName: "Error",
                                        popupMessage:
                                            "Something gone wrong ... Please try again.",
                                        popupStyle: popupError,
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.done_outline,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Update my informations",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                onSurface: Colors.transparent,
                                primary: Colors.red,
                              ),
                              onPressed: () async {
                                await _authenticationService.signOut();
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Disconnect",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
