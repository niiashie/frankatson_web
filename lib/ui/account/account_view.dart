import 'package:flutter/material.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/account/account_view_model.dart';
import 'package:frankoweb/ui/account/widget/auth_form.dart';
import 'package:frankoweb/ui/shared/animations/animations.dart';
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Reveal(
                    effect: RevealEffect.zoomIn,
                    scale: 0.6,
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthForm(viewModel: viewModel),
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
