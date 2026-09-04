import 'package:flutter/material.dart';
import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/account/account_view_model.dart';
import 'package:frankoweb/ui/account/widget/auth_form.dart';
import 'package:stacked/stacked.dart';

/// Opens the sign-in / create-account form over the current page.
///
/// Returns `true` when the user authenticated, `null` when they dismissed it —
/// so a caller can refresh itself only if something actually changed:
///
/// ```dart
/// if (await showAuthDialog(context) == true) reload();
/// ```
///
/// The form itself is [AuthForm], the same widget the standalone account page
/// uses, so the two can never drift apart.
Future<bool?> showAuthDialog(BuildContext context) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Sign in",
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (_, __, ___) => const _AuthDialog(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Matches FadePageRoute's easing so the dialog feels like the rest of
      // the app: fade in while easing up and settling out of a slight scale.
      if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

      final eased = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: eased,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
              .animate(eased),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(eased),
            child: child,
          ),
        ),
      );
    },
  );
}

class _AuthDialog extends StatelessWidget {
  const _AuthDialog();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Fill the width on phones, keep the card measure on anything larger.
    final cardWidth = size.width < 420 ? size.width - 48 : 350.0;

    return ViewModelBuilder<AccountViewModel>.reactive(
      viewModelBuilder: () => AccountViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 8,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: cardWidth + 48,
              maxHeight: size.height - 64,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            size: 20, color: Colors.grey),
                        splashRadius: 18,
                        tooltip: "Close",
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(AppImages.logo,
                              width: 70, height: 70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthForm(viewModel: viewModel, width: cardWidth),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
