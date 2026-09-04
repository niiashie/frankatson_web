import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frankoweb/api/auth_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/models/api_response.dart';
import 'package:frankoweb/models/user.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends BaseViewModel {
  TextEditingController? email, password, name, location, confirmPassword;
  bool showRegistration = false, registerLoading = false, loginLoading = false;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  AuthApi authApi = AuthApi();

  init() {
    email = TextEditingController(text: "");
    password = TextEditingController(text: "");
    name = TextEditingController(text: "");
    location = TextEditingController(text: "");
    confirmPassword = TextEditingController(text: "");
  }

  onCreateAccountTapped() {
    showRegistration = true;
    rebuildUi();
  }

  onSignInTapped() {
    showRegistration = false;
    rebuildUi();
  }

  login() async {
    if (loginKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "email": email!.text,
        "password": password!.text
      };

      try {
        loginLoading = true;
        rebuildUi();

        ApiResponse loginResponse = await authApi.login(data);
        if (loginResponse.ok) {
          debugPrint("response : ${loginResponse.body}");
          final user = User.fromJson(loginResponse.body, "login");

          // Without a token there is no session: every later request would go
          // out unauthenticated and the UI would show the user as signed out.
          // Fail loudly here rather than storing a half-session.
          if ((user.token ?? '').isEmpty) {
            loginLoading = false;
            rebuildUi();
            appService.showErrorFromApiRequest(
                title: "Sign-in failed",
                message: "The server did not return a session token. "
                    "Please try again, or contact support if this persists.");
            return;
          }

          appService.user = user;
          await appService.save(user);
          loginLoading = false;
          resetValues();
          rebuildUi();
          // `true` tells showAuthDialog's caller the user actually signed
          // in, as opposed to dismissing the sheet.
          Navigator.of(StackedService.navigatorKey!.currentContext!).pop(true);
        }
      } on DioException catch (e) {
        loginLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }

  createAccount() async {
    if (registerKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "name": name!.text,
        "email": email!.text,
        "location": location!.text,
        "password": password!.text
      };
      try {
        registerLoading = true;
        rebuildUi();
        ApiResponse createAccountResponse = await authApi.register(data);
        if (createAccountResponse.ok) {
          appService.showErrorFromApiRequest(
              message: "Successfully created account,login to proceed",
              title: "Registration Success");
          showRegistration = false;
          registerLoading = false;
          resetValues();
          rebuildUi();
        }
      } on DioException catch (e) {
        registerLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }

  resetValues() {
    email!.text = "";
    password!.text = "";
    name!.text = "";
    location!.text = "";
    confirmPassword!.text = "";
  }
}
