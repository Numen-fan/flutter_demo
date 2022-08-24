class Global {
  static final List<ChangeListener> _listeners = [];

  static void addListener(ChangeListener listener) {
    _listeners.add(listener);
  }

  static void removeListener(ChangeListener listener) {
    _listeners.remove(listener);
  }

  static void notifyChanged() {
    for (ChangeListener listener in _listeners) {
      listener.valueChange();
    }
  }
}

class ChangeListener {
  void valueChange() {}
}
