import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/ui/account/account_view_model.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';

/// The sign-in / create-account card.
///
/// Shared by the standalone account page and the auth dialog so the two can
/// never drift apart — which form is showing is driven by
/// [AccountViewModel.showRegistration].
class AuthForm extends StatelessWidget {
  final AccountViewModel viewModel;

  /// Width of the card. The dialog hands it the available width so it can fill
  /// a narrow sheet; the page keeps the original fixed measure.
  final double width;

  const AuthForm({super.key, required this.viewModel, this.width = 350});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !viewModel.showRegistration,
      replacement: _card(_registerForm()),
      child: _card(_loginForm()),
    );
  }

  Widget _card(Widget child) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }

  Widget _loginForm() {
    return Form(
      key: viewModel.loginKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          CustomFormField(
            hintText: "Enter your email",
            label: " Email",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.email,
            prefixIcon: const Icon(Icons.mail_outline,
                size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Email is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomFormField(
            hintText: "Enter your password",
            label: " Password",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.password,
            isPasswordField: true,
            prefixIcon: const Icon(Icons.key, size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            width: double.infinity,
            maxWidth: 350,
            height: 45,
            elevation: 2,
            isLoading: viewModel.loginLoading,
            color: AppColors.gradient2,
            title: const Text("Login", style: TextStyle(color: Colors.white)),
            ontap: () {
              viewModel.login();
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Not having account?",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                      color: AppColors.gradient2,
                      fontFamily: AppFonts.poppinsMedium),
                ),
                onTap: () {
                  viewModel.onCreateAccountTapped();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Form(
      key: viewModel.registerKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          CustomFormField(
            hintText: "Enter your name",
            label: " Name",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.name,
            prefixIcon: const Icon(Icons.person_2_outlined,
                size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Name is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          CustomFormField(
            hintText: "Enter your email",
            label: " Email",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.email,
            prefixIcon: const Icon(Icons.mail_outline,
                size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Email is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          CustomFormField(
            hintText: "Enter your location address",
            label: " Location Address",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.location,
            prefixIcon: const Icon(Icons.location_on_outlined,
                size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Location address is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          CustomFormField(
            hintText: "Enter your password",
            label: " Password",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.password,
            isPasswordField: true,
            prefixIcon: const Icon(Icons.key, size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          CustomFormField(
            hintText: "Confirm your password",
            label: " Confirm Password",
            filled: true,
            fillColor: Colors.white,
            controller: viewModel.confirmPassword,
            isPasswordField: true,
            prefixIcon: const Icon(Icons.key, size: 15, color: Colors.grey),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Confirm password is required.";
              } else if (value != viewModel.password!.text) {
                return "Confirm password not equal to password";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            width: double.infinity,
            maxWidth: 350,
            height: 45,
            elevation: 2,
            isLoading: viewModel.registerLoading,
            color: AppColors.gradient2,
            title: const Text("Create Account",
                style: TextStyle(color: Colors.white)),
            ontap: () {
              viewModel.createAccount();
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Already registered?",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      color: AppColors.gradient2,
                      fontFamily: AppFonts.poppinsMedium),
                ),
                onTap: () {
                  viewModel.onSignInTapped();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
