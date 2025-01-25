//

part of '_core.dart';

typedef EventMapper<T> = Stream<T> Function(T event);

typedef EventTransformer<T> = Stream<T> Function(
  Stream<T> events,
  EventMapper<T> mapper,
);

class _Handler {
  const _Handler({required this.isType, required this.type});
  final bool Function(dynamic value) isType;
  final Type type;
}

// [T] for event type and R for listener type
mixin EventHandler<T, R> {
  //
  //
  final _eventController = StreamController<T>.broadcast();
  // final _subscriptions = <StreamSubscription<dynamic>>[];
  final _handlers = <_Handler>[];
  // ignore: prefer_function_declarations_over_variables
  final _eventTransformer = (events, mapper) {
    return events
        .map(mapper)
        .transform<dynamic>(const _FlatMapStreamTransformer<dynamic>());
  };

  StreamSubscription on<E extends T>(
      FutureOr<void> Function(E event, R listener) handler,
      [bool Function(E event)? condition]) {
    debugPrint("EventHandler: handler added on type $E");
    assert(() {
      final handlerExists = _handlers.any((handler) => handler.type == E);
      if (handlerExists) {
        return true; // return without adding handler
      }
      _handlers.add(_Handler(isType: (dynamic e) => e is E, type: E));
      return true;
    }());
    //
    // final subscription = (transformer ?? _eventTransformer)(
    ifCondition(event) {
      return event is E && (condition?.call(event) ?? true);
    }

    //
    final subscription = (_eventTransformer)(
      _eventController.stream.where(ifCondition).cast<E>(),
      (dynamic event) {
        //
        final controller = StreamController<E>.broadcast(
          sync: true,
          // onCancel: emitter.cancel,
        );

        Future<void> handleEvent() async {
          void onDone() {
            if (!controller.isClosed) controller.close();
          }

          try {
            await handler(event as E, this as R);
          } catch (error, _) {
            rethrow;
          } finally {
            onDone();
          }
        }

        handleEvent();
        return controller.stream;
      },
    ).listen(null);
    //
    return subscription;
  }

  @protected
  void emit<E extends T>(E event) {
    // ignore: prefer_asserts_with_message
    if (!_eventController.hasListener) return;
    //
    final handlerExists = _handlers.any((handler) => handler.isType(event));
    if (!handlerExists) {
      return;
    }
    try {
      _eventController.add(event);
    } catch (error, _) {
      rethrow;
    }
  }
  //
}

//
///

class _FlatMapStreamTransformer<T> extends StreamTransformerBase<Stream<T>, T> {
  const _FlatMapStreamTransformer();

  @override
  Stream<T> bind(Stream<Stream<T>> stream) {
    final controller = StreamController<T>.broadcast(sync: true);

    controller.onListen = () {
      final subscriptions = <StreamSubscription<dynamic>>[];

      final outerSubscription = stream.listen(
        (inner) {
          final subscription = inner.listen(
            controller.add,
            onError: controller.addError,
          );

          subscription.onDone(() {
            subscriptions.remove(subscription);
            if (subscriptions.isEmpty) controller.close();
          });

          subscriptions.add(subscription);
        },
        onError: controller.addError,
      );

      outerSubscription.onDone(() {
        subscriptions.remove(outerSubscription);
        if (subscriptions.isEmpty) controller.close();
      });

      subscriptions.add(outerSubscription);

      controller.onCancel = () {
        if (subscriptions.isEmpty) return null;
        final cancels = [for (final s in subscriptions) s.cancel()];
        return Future.wait(cancels).then((_) {});
      };
    };

    return controller.stream;
  }
}
