import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_manager/Resources/router.dart';

/// Service for handling user auto logout based on user activity
class AutoLogoutService {
  static Timer? _timer;
  static const autoLogoutTimer = 15;
  // Instance of authentication service, prefer singleton
  final FirebaseAuth _authService = FirebaseAuth.instance;

  /// Resets the existing timer and starts a new timer
  void startNewTimer() {
    stopTimer();
    if (_authService.currentUser != null) {
      _timer = Timer.periodic(const Duration(minutes: autoLogoutTimer), (_) {
        timedOut();
      });
    }
  }

  /// Stops the existing timer if it exists
  void stopTimer() {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }

  /// Track user activity and reset timer
  void trackUserActivity([_]) async {
    print('User Activity Detected!');
    if (_authService.currentUser != null && _timer != null) {
      startNewTimer();
    }
  }

  /// Called if the user is inactive for a period of time and opens a dialog
  Future<void> timedOut() async {
    stopTimer();
    if (_authService.currentUser != null) {
      // Logout the user and pass the reason to the Auth Service
      _authService.signOut();
      router.go('/');
    }
  }
}
