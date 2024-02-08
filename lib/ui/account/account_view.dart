import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/account/account_view_model.dart';
import 'package:frankoweb/ui/shared/custom_button.dart';
import 'package:frankoweb/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class AccountsView extends StackedView<AccountViewModel> {
  const AccountsView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(AccountViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          AppImages.logo,
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: !viewModel.showRegistration,
                      replacement: Container(
                          width: 350,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Form(
                            key: viewModel.registerKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomFormField(
                                  hintText: "Enter your name",
                                  label: " Name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.name,
                                  prefixIcon: const Icon(
                                    Icons.person_2_outlined,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Name is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomFormField(
                                  hintText: "Enter your email",
                                  label: " Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.email,
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Email is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomFormField(
                                  hintText: "Enter your location address",
                                  label: " Location Address",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.location,
                                  prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Location address is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomFormField(
                                  hintText: "Enter your password",
                                  label: " Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.password,
                                  isPasswordField: true,
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Password is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomFormField(
                                  hintText: "Confirm your password",
                                  label: " Confirm Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.confirmPassword,
                                  isPasswordField: true,
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Confirm password is required.";
                                    } else if (value !=
                                        viewModel.password!.text) {
                                      return "Confirm password not equal to password";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  width: double.infinity,
                                  maxWidth: 350,
                                  height: 45,
                                  elevation: 2,
                                  isLoading: viewModel.registerLoading,
                                  color: AppColors.gradient2,
                                  title: const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  ontap: () {
                                    viewModel.createAccount();
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already registered?",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                          )),
                      child: Container(
                          width: 350,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Form(
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
                                  prefixIcon: const Icon(
                                    Icons.mail_outline,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Email is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomFormField(
                                  hintText: "Enter your password",
                                  label: " Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  controller: viewModel.password,
                                  isPasswordField: true,
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Password is required.";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomButton(
                                  width: double.infinity,
                                  maxWidth: 350,
                                  height: 45,
                                  elevation: 2,
                                  isLoading: viewModel.loginLoading,
                                  color: AppColors.gradient2,
                                  title: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  ontap: () {
                                    viewModel.login();
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Not having account?",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Back To Previous Page",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            )));
  }

  @override
  AccountViewModel viewModelBuilder(BuildContext context) => AccountViewModel();
}
