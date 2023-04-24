import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/module/custom_paint/entity/white_board_define.dart';

/// Created by fanjiajia02 on 2023/4/21
/// Desc: ViewModel

class WhiteBoardSelectorPanelViewModel extends ChangeNotifier {
  // 是否展示颜色选择器
  bool showColorSelector = true;

  // 是否展示画笔的宽度选择器
  bool showSizeSelector = false;

  /// 颜色选择器的颜色配置，key = 颜色，value = 是否选中，UI上每个颜色监听自己是否被选中
  /// 注意：统一在[setCurSelectColor]中修改是否选中
  late final Map<Color, bool> selectColors;

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
  Map<PainterType, PainterSize> _painterSizeCache = {};
  // key 画笔类型， value 画笔的颜色
  Map<PainterType, Color> _painterColorCacle = {};
  /// ============= end of 以下是一些状态记录 ================


  WhiteBoardSelectorPanelViewModel() {
    // 初始化画笔颜色选择器的颜色
    _initSelectColors();
    // 初始化画笔类型信息
    _initPainterTypes();
  }

  /// 初始化颜色选择器的颜色
  void _initSelectColors() {
    selectColors = {};
    selectColors[const Color(0xFF1A1C1F)] = false;
    selectColors[const Color(0xFF808080)] = false;
    selectColors[const Color(0xFFFF3A3A)] = true; // 默认选中红色
    selectColors[const Color(0xFFFFBC0F)] = false;
    selectColors[const Color(0xFF3CC745)] = false;
    selectColors[const Color(0xFF0BD9A5)] = false;
    selectColors[const Color(0xFF26B7FF)] = false;
    selectColors[const Color(0xFF3377FF)] = false;
    selectColors[const Color(0xFF974DFF)] = false;

    // 默认选中的颜色
    curPaintColor = const Color(0xFFFF3A3A);
  }

  void _initPainterTypes() {
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

  /// 设置选中的颜色
  /// 第[index]个颜色
  void setCurSelectColor(int index) {
    if (index > selectColors.length ||
        selectColors.keys.elementAt(index) == curPaintColor) {
      return;
    }
    // 原来的颜色恢复未选中状态
    selectColors[curPaintColor] = false;
    curPaintColor = selectColors.keys.elementAt(index);
    // 新颜色选中
    selectColors[curPaintColor] = true;
    // 隐藏画笔宽度选择器
    showOrHideSizeSelector(false);
    notifyListeners();
    // 做cache缓存
    _painterColorCacle[curPinterType] = curPaintColor;
  }

  /// 设置选中的画笔类型
  void setCurSelectPainterType(int index) {
    if (index > painterTypes.length ||
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
  }

}

