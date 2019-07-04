// Generic interface for all BLOC's
import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

// Generic BLOC Provider
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({this.bloc, this.child});

  final T bloc;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState<dynamic>();
  }

  static T of<T extends BlocBase>(BuildContext context) {
    final Type type = _typeOf<BlocProvider<T>>();
    final BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider?.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
