/// Created by fanjiajia02 on 2023/4/23
/// Desc: 白板相关定义

/// 画笔类型
enum PainterType {
  // 选择
  select,
  // 画笔
  pen,
  // 荧光笔
  highlight,
  // 橡皮擦
  eraser,
  // 箭头
  arrow,
  // 方形
  square,
  // 直线
  line,
  // 圆
  circle,
  // 三角形
  triangle,
  // 六边形
  hexagon
}

/// 画笔宽度
enum PainterSize {
  fill, // 填充
  translucency, // 半透明
  width1, // 宽度1
  width2,
  width3,
  width4,
  width5
}

/// 绘制模式
enum DrawMode {
  // 批注
  annotation,
  // 白板
  whiteboard
}
