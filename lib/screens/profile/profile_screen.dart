import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/services/user_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';
import 'package:miaged/widgets/popup.dart';

import '../../constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();

  late Future<User?> user;

  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  var bDayController = TextEditingController();
  var addressController = TextEditingController();
  var postalCodeController = TextEditingController();

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
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Center(
                          child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(currentUser.avatarLink),
                          backgroundColor: Colors.black,
                          maxRadius: 55,
                        ),
                      )),
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
                                      var newData = User.forUpdate(
                                          login,
                                          password,
                                          birthdayDate,
                                          address,
                                          postalCode);
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
