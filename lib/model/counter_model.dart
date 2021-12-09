
import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {

  int _count = 0;

  /// 提供getter
  get count => _count;

  void increment() {
    _count++;
    // 通知监听者
    notifyListeners();
  }

}