// ignore_for_file: unnecessary_type_check

part of '_core.dart';

typedef Create<T> = T Function();

typedef _SelectorAspect<T> = bool Function(T value);

class _Dependency<T> {
  bool shouldClearSelectors = false;
  bool shouldClearMutationScheduled = false;
  final selectors = <_SelectorAspect<T>>[];
}

//
//
class InheritedScope<T extends Listenable> extends InheritedWidget {
  const InheritedScope({
    super.key,
    // required this.owner,
    // required T Function(BuildContext context) create,
    required T value,
    required super.child,
  }) : _value = value;
  //  : _create = create;
  final T _value;

  // final T Function(BuildContext context) _create;
  // final InheritedProvider<T> owner;

  static T read<T extends Listenable>(BuildContext context) {
    final element = InheritedScope._inheritedElementOf<T>(context);
    if (element == null || element.widget is! InheritedScope<T>) {
      throw Exception("InheritedScope of type '$T' not found");
    }
    return element.value;
  }

  //
  static T watch<T extends Listenable>(BuildContext context) {
    final element = InheritedScope._inheritedElementOf<T>(context);
    if (element == null || element.widget is! InheritedScope<T>) {
      throw Exception("InheritedScope of type '$T' not found");
    }
    context.dependOnInheritedElement(element);
    return element.value;
  }

  static R select<T extends Listenable, R>(
      BuildContext context, R Function(T) selector) {
    final element = InheritedScope._inheritedElementOf<T>(context);
    if (element == null || element.widget is! InheritedScope<T>) {
      throw Exception("InheritedScope of type '$T' not found");
    }

    final selectedValue = selector(element.value);
    context.dependOnInheritedElement(element, aspect: (T newValue) {
      return !const DeepCollectionEquality()
          .equals(selectedValue, selector(newValue));
    });
    return selectedValue;
  }

  //
  static _InheritedScopeElement<T>? _inheritedElementOf<T extends Listenable>(
      BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<InheritedScope<T>>()
        as _InheritedScopeElement<T>?;
  }

  @override
  bool updateShouldNotify(InheritedScope<T> oldWidget) {
    return false;
    // return oldWidget._value != _value;
  }

  @override
  InheritedElement createElement() => _InheritedScopeElement<T>(this);
}

class _InheritedScopeElement<T extends Listenable> extends InheritedElement {
  _InheritedScopeElement(this.widget) : super(widget) {
    widget._value.addListener(_handleUpdate);
  }

  T? _value;

  bool _dirty = false;
  @override
  final InheritedScope<T> widget;

  T get value {
    // if (_didInitValue) {
    //   return _value!;
    // }
    // _didInitValue = true;
    // _value = widget._create(this);
    return widget._value;
    // return _value!;
  }

  // @override
  // void mount(Element? parent, Object? newSlot) {
  //   print("ajaj mount called");
  //   super.mount(parent, newSlot);
  // }

  @override
  void update(InheritedScope<T> newWidget) {
    // final T? oldNotifier = _value;
    // final T? newNotifier = newWidget.;
    // if (oldNotifier != newNotifier) {
    //   oldNotifier?.removeListener(_handleUpdate);
    //   newNotifier?.addListener(_handleUpdate);
    // }
    print("ajaj update called");
    super.update(newWidget);
  }

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    final dependencies = getDependencies(dependent);
    // once subscribed to everything once, it always stays subscribed to everything
    if (dependencies != null && dependencies is! _Dependency<T>) {
      return;
    }

    if (aspect is _SelectorAspect<T>) {
      final selectorDependency =
          (dependencies ?? _Dependency<T>()) as _Dependency<T>;

      if (selectorDependency.shouldClearSelectors) {
        selectorDependency.shouldClearSelectors = false;
        selectorDependency.selectors.clear();
      }
      if (selectorDependency.shouldClearMutationScheduled == false) {
        selectorDependency.shouldClearMutationScheduled = true;
        Future.microtask(() {
          selectorDependency
            ..shouldClearMutationScheduled = false
            ..shouldClearSelectors = true;
        });
      }
      selectorDependency.selectors.add(aspect);
      setDependencies(dependent, selectorDependency);
    } else {
      // subscribes to everything
      setDependencies(dependent, const Object());
    }
  }

  @override
  Widget build() {
    // if (!_didInitValue) {
    //   value.addListener(_handleUpdate);
    // }
    if (_dirty) {
      notifyClients(widget);
    }
    return super.build();
  }

  void _handleUpdate() {
    _dirty = true;
    markNeedsBuild();
  }

  @override
  void notifyClients(InheritedScope<T> oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  void notifyDependent(InheritedScope<T> oldWidget, Element dependent) {
    final dependencies = getDependencies(dependent);
    //
    var shouldNotify = false;
    if (dependencies != null) {
      if (dependencies is _Dependency<T>) {
        // select can never be used inside `didChangeDependencies`, so if the
        // dependent is already marked as needed build, there is no point
        // in executing the selectors.
        if (dependent.dirty) {
          return;
        }

        for (final updateShouldNotify in dependencies.selectors) {
          try {
            // assert(() {
            //   _debugIsSelecting = true;
            //   return true;
            // }());
            shouldNotify = updateShouldNotify(widget._value);
            print("ajaj should notify called $shouldNotify");
          } finally {
            // assert(() {
            //   _debugIsSelecting = false;
            //   return true;
            // }());
          }
          if (shouldNotify) {
            break;
          }
        }
      } else {
        shouldNotify = true;
      }
    }

    if (shouldNotify) {
      dependent.didChangeDependencies();
    }
  }

  @override
  void unmount() {
    _value?.removeListener(_handleUpdate);
    super.unmount();
  }
}
