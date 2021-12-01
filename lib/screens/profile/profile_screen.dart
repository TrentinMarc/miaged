import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/user_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';
import 'package:miaged/widgets/popup.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final AuthenticationService _authenticationService = AuthenticationService();
  late Future<User?> user;

  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  var bDayController = TextEditingController();
  var addressController = TextEditingController();
  var postalCodeController = TextEditingController();
  var cityController = TextEditingController();

  var avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = _userService.getCurrentUser();
    return FutureBuilder(
      future: user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data != null) {
          final data = snapshot.data;
          final User currentUser = data!;
          loginController.text = currentUser.login;
          passwordController.text = currentUser.password;
          addressController.text = currentUser.address;
          postalCodeController.text = currentUser.postalCode;
          bDayController.text = currentUser.birthDayDate;
          cityController.text = currentUser.city;

          avatarController.text = currentUser.avatarLink;
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
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
                              child: CircleAvatar(
                                backgroundImage: const CachedNetworkImageProvider(defaultAvatarLink),
                                foregroundImage: CachedNetworkImageProvider(currentUser.avatarLink),
                                backgroundColor: Colors.black,
                                maxRadius: 55,
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
                                builder: (BuildContext context) =>
                                    const Popup(
                                  popupName: "Tips",
                                  popupMessage:
                                      "Here you can update your perosnal data, click the picture to edit ! (if passed url isn't available, you'll have the default avatar.)",
                                  popupStyle: popupInfo,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(flex: 2, child: Text("Login")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: loginController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Login',
                                      hintText: 'abc@gmail.com',
                                      contentPadding: EdgeInsets.all(8.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(flex: 2, child: Text("Password")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: passwordController,
                                  readOnly: true,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      hintText: 'abc@gmail.com',
                                      contentPadding: EdgeInsets.all(8.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  flex: 2, child: Text("Birthday Date")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: bDayController,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2001),
                                            lastDate: DateTime(2025))
                                        .then((date) {
                                      if (date != null) {
                                        bDayController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(date);
                                      }
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Birthday Date',
                                      hintText: '11/09/1999',
                                      contentPadding: EdgeInsets.all(8.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(flex: 2, child: Text("Address")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: addressController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Address',
                                      hintText: '12 avenue du Maréchal Juin',
                                      contentPadding: EdgeInsets.all(8.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  flex: 2, child: Text("Postal Code")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: postalCodeController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Postal Code',
                                      hintText: '06000',
                                      contentPadding: EdgeInsets.all(8.0)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(flex: 2, child: Text("City")),
                              Flexible(
                                flex: 6,
                                child: TextField(
                                  controller: cityController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'City',
                                      hintText: 'Nice',
                                      contentPadding: EdgeInsets.all(8.0)),
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
                                        onSurface: Colors.transparent),
                                    onPressed: () async {
                                      var login = loginController.text.trim();
                                      var password =
                                          passwordController.text.trim();
                                      var address =
                                          addressController.text.trim();
                                      var postalCode =
                                          postalCodeController.text.trim();
                                      var birthdayDate =
                                          bDayController.text.trim();
                                      var city = cityController.text.trim();
                                      var avatarLink =
                                          avatarController.text.trim();
                                      var newData = User.forUpdate(
                                          login,
                                          password,
                                          birthdayDate,
                                          address,
                                          postalCode,
                                          city,
                                          avatarLink);
                                      var isUpdated = await _userService
                                          .updateUser(newData);
                                      if (isUpdated) {
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
                                        );
                                        setState(() {});
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
                                        setState(() {});
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
        } else if (snapshot.hasError) {
          return const Text("Error during data fetching...");
        }
        return const Center(child: DogoProgressIndicator());
      },
    );
  }
}
