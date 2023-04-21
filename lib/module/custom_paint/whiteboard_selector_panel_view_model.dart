import 'package:flutter/widgets.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: ViewModel

class WhiteBoardSelectorPanelViewModel extends ChangeNotifier {

  // 是否展示颜色选择器
  bool showColorSelector = true;

  void showOrHideColorSelector(bool show) {
    showColorSelector = show;
    notifyListeners();
  }

}

