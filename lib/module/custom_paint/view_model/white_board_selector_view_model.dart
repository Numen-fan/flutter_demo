import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/module/custom_paint/entity/white_board_define.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: ViewModel

class WhiteBoardSelectorViewModel extends ChangeNotifier {

  // 当前的模式，批注和白板
  final DrawMode curDrawMode;

  // 默认画笔的颜色
  late final Color defaultColor;

  // 是否展示颜色选择器
  bool showColorSelector = true;

  // 是否展示画笔的宽度选择器
  bool showSizeSelector = false;

  // 是否可撤销
  bool undoEnable = false;

  // 是否可重做
  bool redoEnable = false;

  // 是否支持保存截图
  bool supportSave = true;

  /// 颜色选择器的颜色配置，key = 颜色，value = 是否选中，UI上每个颜色监听自己是否被选中
  /// 注意：统一在[setCurSelectColor]中修改是否选中
  late final Map<Color, bool> painterColors;

  /// 绘制工具选择器配置，key = 绘制工具，value = 是否选中
  late final Map<PainterType, bool> painterTypes;

  /// 每个画笔的宽度配置
  late Map<PainterType, List<PainterSize>> painterSizeMap;

  /// ============= start of 以下是一些状态记录 ==============
  // 当前画笔的颜色
  late Color curPaintColor;
  // 当前画笔的类型
  late PainterType curPinterType;
  // key 画笔类型， value 画笔的宽度
  final Map<PainterType, PainterSize> _painterSizeCache = {};
  // key 画笔类型， value 画笔的颜色
  final Map<PainterType, Color> _painterColorCache = {};
  /// ============= end of 以下是一些状态记录 ================

  WhiteBoardModelListener? listener;

  WhiteBoardSelectorViewModel(
      {this.curDrawMode = DrawMode.annotation, this.supportSave = true}) {
    // 批注默认红色，白板默认黑色
    defaultColor = curDrawMode == DrawMode.annotation
        ? const Color(0xFFFF3A3A)
        : const Color(0xFF1A1C1F);
    // 初始化画笔颜色选择器的颜色
    _initPainterColors();
    // 初始化画笔信息
    _initPainterInfo();
  }

  /// 初始化颜色选择器的颜色
  void _initPainterColors() {
    painterColors = {};
    painterColors[const Color(0xFF1A1C1F)] = false;
    painterColors[const Color(0xFF808080)] = false;
    painterColors[const Color(0xFFFF3A3A)] = false;
    painterColors[const Color(0xFFFFBC0F)] = false;
    painterColors[const Color(0xFF3CC745)] = false;
    painterColors[const Color(0xFF0BD9A5)] = false;
    painterColors[const Color(0xFF26B7FF)] = false;
    painterColors[const Color(0xFF3377FF)] = false;
    painterColors[const Color(0xFF974DFF)] = false;

    // 默认选中的颜色
    curPaintColor = defaultColor;
    painterColors[curPaintColor] = true;
  }

  void _initPainterInfo() {
    painterTypes = {};
    painterSizeMap = {};
    // 一共有两种画笔宽度，有无填充和透明度
    var allSize = PainterSize.values;
    var noFillAndTransSize = PainterSize.values.where((element) =>
        element != PainterSize.fill && element != PainterSize.translucency);
    for (var type in PainterType.values) {
      painterTypes[type] = false;
      // 配置这个类型的画笔宽度
      if (type == PainterType.pen ||
          type == PainterType.highlight ||
          type == PainterType.line ||
          type == PainterType.arrow) {
        painterSizeMap[type] = noFillAndTransSize.toList();
      } else {
        painterSizeMap[type] = allSize;
      }
    }
    // 默认在画笔上
    curPinterType = PainterType.pen;
    painterTypes[curPinterType] = true;
  }

  void setListener(WhiteBoardModelListener? l) {
    listener = l;
  }

  /// 设置选中的颜色
  /// 第[index]个颜色
  void setCurSelectColor(int index) {
    if (index < 0 || index > painterColors.length ||
        painterColors.keys.elementAt(index) == curPaintColor) {
      return;
    }
    // 原来的颜色恢复未选中状态
    painterColors[curPaintColor] = false;
    curPaintColor = painterColors.keys.elementAt(index);
    // 新颜色选中
    painterColors[curPaintColor] = true;
    // 隐藏画笔宽度选择器
    showOrHideSizeSelector(false);
    notifyListeners();
    // 做cache缓存
    _painterColorCache[curPinterType] = curPaintColor;
    updatePainterStyle();
  }

  /// 设置选中的画笔
  void setCurSelectPainterType(int index) {
    if (index < 0 || index > painterTypes.length ||
        painterTypes.keys.elementAt(index) == curPinterType) {
      return;
    }
    painterTypes[curPinterType] = false;
    curPinterType = painterTypes.keys.elementAt(index);
    painterTypes[curPinterType] = true;
    // 『选择』和『橡皮擦』不展示上方的颜色选择器
    showColorSelector = curPinterType != PainterType.select &&
        curPinterType != PainterType.eraser;
    // 隐藏画笔宽度选择器
    showOrHideSizeSelector(false);

    // 更换了画笔，恢复此前这个画笔的颜色
    if(showColorSelector) {
      var newPainterColor = _painterColorCache[curPinterType] ?? defaultColor;
      var index = painterColors.keys.toList().indexOf(newPainterColor);
      setCurSelectColor(index);
      // 通知UI滚动到相应的位置
      listener?.onPainterColorChanged(index);
    }
    updatePainterStyle();
    notifyListeners();
  }

  void showOrHideSizeSelector(bool show) {
    if(showSizeSelector == show) {
      return;
    }
    showSizeSelector = show;
    notifyListeners();
  }

  PainterSize getPainterSize(PainterType painterType) {
    if(!_painterSizeCache.containsKey(painterType)) {
      _painterSizeCache[painterType] = PainterSize.width3; // 每种画笔的默认宽度为width3
    }
    return _painterSizeCache[painterType]!;
  }

  List<PainterSize> getAllPainterSize(PainterType painterType) {
    return painterSizeMap[painterType]!;
  }

  void setCurPainterSize(PainterSize painterSize) {
    _painterSizeCache[curPinterType] = painterSize;
    showOrHideSizeSelector(false); // 选择画笔宽度后，隐藏选择器
    updatePainterStyle();
  }

  /// 通知画笔样式到native
  /// 1. 当前的画笔是[curPinterType]
  /// 2. 当前的颜色是[curPaintColor]
  /// 3. 当前的画笔尺寸是[getPainterSize(curPinterType)]
  /// 4. **注意** 如果是『选择』『橡皮擦』两种类型，没有color和size哟，接口设计上注意一下
  void updatePainterStyle() {
    debugPrint("updatePainterStyle");
  }

  /// 退出批注
  void quitWhiteBoard() {
    debugPrint("quitWhiteBoard");
  }

  /// 删除标注
  void deleteAnnotation() {
    debugPrint("deleteAnnotation");
  }

  /// 保存截图
  void saveScreenshot() {
    debugPrint("saveScreenshot");
  }

  /// 撤销
  void undo() {
    debugPrint("undo");
  }

  /// 重做？？？
 void redo() {
   debugPrint("redo");
 }
}

/// 提供一些监听
mixin WhiteBoardModelListener {
  // 画笔的颜色发生改变，比如切换画笔，相应的颜色也要发生改变，UI上可以让颜色选择器自动滚动到指定位置
  onPainterColorChanged(int index);

}

