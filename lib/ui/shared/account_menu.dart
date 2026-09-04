import 'package:flutter/material.dart';
import 'package:frankoweb/api/auth_api.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/services/app.service.dart';

/// The signed-in user's avatar and menu, with the sign-out action.
///
/// Renders nothing when nobody is signed in, so it is safe to drop into any
/// app bar unconditionally. Every app bar should carry one — a logout the user
/// cannot reach from the screen they are working on is not a logout.
class AccountMenu extends StatefulWidget {
  /// Icon colour, so the menu reads correctly on both the transparent and the
  /// scrolled (white) app bar states.
  final Color? color;
  final double iconSize;

  /// Called after a successful sign-out, for hosts that need to refresh.
  final VoidCallback? onSignedOut;

  const AccountMenu({
    super.key,
    this.color,
    this.iconSize = 28,
    this.onSignedOut,
  });

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  final AuthApi _authApi = AuthApi();
  final AppService _appService = locator<AppService>();
  late Future<Map<String, String>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _authApi.session();
    _appService.sessionRevision.addListener(_onSessionChanged);
  }

  @override
  void dispose() {
    _appService.sessionRevision.removeListener(_onSessionChanged);
    super.dispose();
  }

  /// Someone signed in, signed out, or the profile was refreshed — re-read
  /// rather than keep showing whoever was here when this menu was built.
  void _onSessionChanged() {
    if (!mounted) return;
    // Block body, not an arrow: `=> _userFuture = ...` returns the assigned
    // Future, and setState asserts its callback returns nothing.
    setState(() {
      _userFuture = _authApi.session();
    });
  }

  Future<void> _signOut() async {
    await _authApi.signOut();
    if (!mounted) return;
    widget.onSignedOut?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: widget.iconSize,
            height: widget.iconSize,
            child: const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;
        return PopupMenuButton<String>(
          icon: Icon(
            Icons.person,
            size: widget.iconSize,
            color: widget.color ?? AppColors.gradient2,
          ),
          padding: EdgeInsets.zero,
          tooltip: "Account",
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          onSelected: (value) {
            if (value == "logout") _signOut();
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: "profile",
              enabled: false,
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 70,
                width: 230,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[400], shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(Icons.person,
                            color: Colors.white, size: 15),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user['name'] ?? '',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                        ),
                        Text(
                          user['email'] ?? '',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: "logout",
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 50,
                width: 230,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,
                        size: 18, color: AppColors.gradient2),
                    SizedBox(width: 10),
                    Text(
                      "Log out",
                      style: TextStyle(
                          color: AppColors.gradient2,
                          fontFamily: AppFonts.poppinsMedium,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
