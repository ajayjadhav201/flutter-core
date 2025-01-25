part of '_core.dart';

class Mutex {
  bool _isLocked = false;
  final List<Completer<bool>> _waitQueue = [];
  //
  //s
  Future<bool> lock({Duration? timeout}) async {
    //
    if (!_isLocked) {
      _isLocked = true;
      return true;
    }
    //
    final completer = Completer<bool>();
    _waitQueue.add(completer);
    //
    // if timeout is added.
    if (timeout != null) {
      return Future.any([
        completer.future,
        Future.delayed(timeout, () {
          _waitQueue.remove(completer);
          return false;
          // throw TimeoutException(
          //     "Failed to acquire lock within the specified timeout $timeout");
        })
      ]);
    }
    return completer.future;
  }

  void release() {
    //
    if (!_isLocked) return;
    //
    if (_waitQueue.isNotEmpty) {
      final nextCompleter = _waitQueue.removeAt(0);
      return nextCompleter.complete(true);
    } else {
      _isLocked = false;
    }
  }
}
