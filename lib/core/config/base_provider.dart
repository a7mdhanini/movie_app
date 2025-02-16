import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  //!--------------------------Loading--------------------------//!

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool isLoading) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isMounted) {
        _isLoading = isLoading;
        notifyListeners();
      }
    });
  }

  //!--------------------------Failure--------------------------//!

  String _failure = '';
  String get failureMessage => _failure;

  void setFailure(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isMounted) {
        _isLoading = false;
        _failure = message;
        notifyListeners();
      }
    });
  }

  //!--------------------------Dispose--------------------------//!

  bool _isMounted = false;
  bool get mounted => _isMounted;

  @override
  void dispose() {
    _isMounted = true;
    super.dispose();
  }
}
