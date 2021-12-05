import 'package:flutter/material.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/screens/profile/components/body.dart';
import 'package:miaged/services/user_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void callBack() {
    setState(() {});
  }

  final UserService _userService = UserService();
  late Future<MiagedUser?> user;

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
      builder: (context, AsyncSnapshot<MiagedUser?> snapshot) {
        if (snapshot.data != null) {
          final data = snapshot.data;
          final MiagedUser currentUser = data!;
          return ProfileScreenBody(
            currentUser: currentUser,
            callBackParent: callBack,
          );
        } else if (snapshot.hasError) {
          return const Text("Error during data fetching...");
        }
        return const Center(child: DogoProgressIndicator());
      },
    );
  }
}
