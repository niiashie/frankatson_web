import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frankoweb/api/auth_api.dart';
import 'package:frankoweb/app/locator.dart';
import 'package:frankoweb/constants/colors.dart';
import 'package:frankoweb/constants/fonts.dart';
import 'package:frankoweb/services/app.service.dart';
import 'package:stacked_services/stacked_services.dart';

/// Signs the user out after a stretch of no interaction.
///
/// Guards the case a logout button cannot: someone steps away from a shared
/// machine while signed in. Wraps the whole app (via `MaterialApp.builder`) so
/// activity anywhere — pointer, scroll or keyboard — counts, and so the timer
/// survives navigation between screens.
///
/// Does nothing at all while signed out.
class IdleLogoutWatcher extends StatefulWidget {
  final Widget child;

  /// How long the session may sit idle before it is torn down.
  final Duration idleTimeout;

  /// How long before the deadline the user is warned and offered a reprieve.
  final Duration warnBefore;

  const IdleLogoutWatcher({
    super.key,
    required this.child,
    this.idleTimeout = const Duration(minutes: 25),
    this.warnBefore = const Duration(seconds: 60),
  });

  @override
  State<IdleLogoutWatcher> createState() => _IdleLogoutWatcherState();
}

class _IdleLogoutWatcherState extends State<IdleLogoutWatcher> {
  final AppService _appService = locator<AppService>();
  final AuthApi _authApi = AuthApi();

  DateTime _lastActivity = DateTime.now();
  Timer? _ticker;

  /// While the warning is up, raw pointer/key events must not count as
  /// activity — otherwise the act of reading the dialog would silently cancel
  /// the countdown and the warning would never resolve.
  bool _warning = false;
  bool _signingOut = false;

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKey);
    _ticker = Timer.periodic(const Duration(seconds: 5), (_) => _tick());
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    _ticker?.cancel();
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    _markActive();
    return false; // never consume the event
  }

  void _markActive() {
    if (_warning || _signingOut) return;
    _lastActivity = DateTime.now();
  }

  void _tick() {
    if (_signingOut || !_appService.isLoggedIn) return;

    final idle = DateTime.now().difference(_lastActivity);
    if (idle >= widget.idleTimeout) {
      _signOut();
    } else if (!_warning && idle >= widget.idleTimeout - widget.warnBefore) {
      _showWarning();
    }
  }

  /// Restarts the clock — the user asked to stay signed in.
  void _staySignedIn() {
    _warning = false;
    _lastActivity = DateTime.now();
  }

  Future<void> _showWarning() async {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;

    _warning = true;
    final stayed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _IdleWarningDialog(warnBefore: widget.warnBefore),
    );

    // A null result means the countdown ran out and _signOut closed the
    // dialog itself, so there is nothing left to do.
    if (stayed == true) {
      _staySignedIn();
    } else if (stayed == false) {
      _warning = false;
      await _signOut();
    }
  }

  Future<void> _signOut() async {
    _signingOut = true;

    final context = StackedService.navigatorKey?.currentContext;
    if (_warning && context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop(); // close the warning
    }
    _warning = false;

    await _authApi.signOut();

    _signingOut = false;
    _lastActivity = DateTime.now();

    if (!mounted) return;
    final after = StackedService.navigatorKey?.currentContext;
    if (after == null || !after.mounted) return;
    showDialog<void>(
      context: after,
      builder: (dialogContext) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        title: const Text(
          "Signed out",
          style: TextStyle(
              fontFamily: AppFonts.poppinsBold,
              fontSize: 18,
              color: AppColors.gradient2),
        ),
        content: const Text(
          "You were signed out because the session was left idle. "
          "Please sign in again to continue.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Okay",
                style: TextStyle(color: AppColors.gradient2)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _markActive(),
      onPointerMove: (_) => _markActive(),
      onPointerHover: (_) => _markActive(),
      onPointerSignal: (_) => _markActive(),
      child: widget.child,
    );
  }
}

/// "You're about to be signed out" with a live countdown.
class _IdleWarningDialog extends StatefulWidget {
  final Duration warnBefore;

  const _IdleWarningDialog({required this.warnBefore});

  @override
  State<_IdleWarningDialog> createState() => _IdleWarningDialogState();
}

class _IdleWarningDialogState extends State<_IdleWarningDialog> {
  late int _secondsLeft = widget.warnBefore.inSeconds;
  Timer? _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _secondsLeft = _secondsLeft > 0 ? _secondsLeft - 1 : 0);
    });
  }

  @override
  void dispose() {
    _countdown?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      title: const Text(
        "Still there?",
        style: TextStyle(
            fontFamily: AppFonts.poppinsBold,
            fontSize: 18,
            color: AppColors.gradient2),
      ),
      content: Text(
        "You have been idle for a while. For your security you will be "
        "signed out in $_secondsLeft second${_secondsLeft == 1 ? '' : 's'}.",
        style: const TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Sign out now",
              style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Stay signed in",
              style: TextStyle(
                  color: AppColors.gradient2,
                  fontFamily: AppFonts.poppinsMedium)),
        ),
      ],
    );
  }
}
