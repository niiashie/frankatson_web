import 'package:flutter/material.dart';
import 'package:frankoweb/ui/small_screen/small_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class SmallScreenView extends StackedView<SmallScreenViewModel> {
  const SmallScreenView({
    Key? key,
  }) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(SmallScreenViewModel viewModel) async {
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(),
    ));
  }

  @override
  SmallScreenViewModel viewModelBuilder(BuildContext context) =>
      SmallScreenViewModel();
}
