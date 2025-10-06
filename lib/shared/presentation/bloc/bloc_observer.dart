import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom BLoC Observer to monitor all BLoCs in the application
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print('🔵 BLoC Created: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('🟡 Event: ${bloc.runtimeType} - $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('🟠 State Change: ${bloc.runtimeType}');
      print('   Current: ${change.currentState}');
      print('   Next: ${change.nextState}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('🔄 Transition: ${bloc.runtimeType}');
      print('   Event: ${transition.event}');
      print('   Current: ${transition.currentState}');
      print('   Next: ${transition.nextState}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('🔴 Error in ${bloc.runtimeType}: $error');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('🔴 BLoC Closed: ${bloc.runtimeType}');
    }
  }
}
