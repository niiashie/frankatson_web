import 'package:flutter/material.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/partners/partners_view_model.dart';
import 'package:stacked/stacked.dart';

class PartnersScreenView extends StackedView<PartnersViewModel> {
  const PartnersScreenView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(PartnersViewModel viewModel) async {
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.gradient2,
                          AppColors.gradient1,
                        ],
                      )),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  elevation: 5,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image.asset(
                                        AppImages.logo,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      MediaQuery.of(context).size.width >= 800
                                          ? true
                                          : false,
                                  child: const SizedBox(
                                    width: 10,
                                  ),
                                ),
                                Visibility(
                                    visible:
                                        MediaQuery.of(context).size.width >= 800
                                            ? true
                                            : false,
                                    child: const Text(
                                      "Frankatson",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: AppFonts.poppinsMedium,
                                          fontSize: 25),
                                    ))
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width >=
                                                    800
                                                ? 18
                                                : 14),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Partners",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppFonts.poppinsMedium,
                                      fontSize:
                                          MediaQuery.of(context).size.width >=
                                                  800
                                              ? 30
                                              : 20),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.list,
                                color: Colors.white,
                                size: 25,
                              ),
                              offset: const Offset(0.0, 60),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              onSelected: (value) {
                                if (value == "Account") {
                                } else if (value == "news") {
                                } else if (value == "blog") {}
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "login",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("Login"),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "news",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("News"),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "blog",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: Text("Blogs"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width >= 800
                              ? MediaQuery.of(context).size.width / 1.5
                              : double.infinity,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: viewModel.items,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  @override
  PartnersViewModel viewModelBuilder(BuildContext context) =>
      PartnersViewModel();
}
