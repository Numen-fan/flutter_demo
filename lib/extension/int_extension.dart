
import '../util/adapt.dart';

extension IntFit on int {
  double get px {
    return Adapt.px(this.toDouble());
  }
}