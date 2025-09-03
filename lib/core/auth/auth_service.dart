// core/auth/auth_service.dart
import 'dart:async';

enum AuthEventType { logout, tokenExpired, invalidCredentials }

class AuthService {
  final _controller = StreamController<AuthEventType>.broadcast();

  Stream<AuthEventType> get stream => _controller.stream;
  final _refreshCompleter = Completer<void>();

  void notify(AuthEventType event) {
    _controller.add(event);
  }

  /// Called by Bloc after refresh success
  void notifyRefreshSuccess() {
    if (!_refreshCompleter.isCompleted) {
      _refreshCompleter.complete();
    }
  }

  /// Called by Bloc after refresh failure
  void notifyRefreshFailure() {
    if (!_refreshCompleter.isCompleted) {
      _refreshCompleter.completeError("Refresh failed");
    }
  }

  /// ApiClient waits on this
  Future<void> waitForRefresh() => _refreshCompleter.future;

  void dispose() {
    _controller.close();
  }
}
