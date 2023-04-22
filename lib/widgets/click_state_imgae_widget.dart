import 'package:flutter_demo/util/image_loader.dart';
import 'package:flutter/cupertino.dart';

/// A Image Widget show different picture when Tap down and Tap up

enum ImageState { up, down }

// Indicate the image update type
enum Type { url, color }

typedef OnClick = void Function();

typedef OnDoubleClick = void Function();

typedef OnLongClick = void Function();

class ClickStateImageWidget extends StatefulWidget {
  Type type;

  String normalImgUrl;
  String? activeImgUrl;

  Color? normalColor;
  Color? activeColor;

  OnClick? onClick;
  OnDoubleClick? onDoubleClick;
  OnLongClick? onLongClick;

  ClickStateImageWidget(
      {Key? key,
      required this.type,
      required this.normalImgUrl,
      required this.activeImgUrl,
      this.onClick,
      this.onDoubleClick,
      this.onLongClick})
      : super(key: key);

  ClickStateImageWidget.fromColor(
      {Key? key,
      required this.type,
      required this.normalImgUrl,
      required this.activeColor,
      required this.normalColor,
      this.onClick,
      this.onDoubleClick,
      this.onLongClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClickStateImageWidgetState();
}

class _ClickStateImageWidgetState extends State<ClickStateImageWidget> {
  ImageState curState = ImageState.up; // default state

  @override
  Widget build(BuildContext context) {
    Widget? image = widget.type == Type.url ? getUrlImage() : getColorImage();

    return GestureDetector(
      onTapDown: (detail) => update(ImageState.down),
      onTapUp: (details) => update(ImageState.up),
      onTapCancel: () => update(ImageState.up),
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      onDoubleTap: () {
        if (widget.onDoubleClick != null) {
          widget.onDoubleClick!();
        }
      },
      child: image,
    );
  }

  Widget? getUrlImage() {
    return ImageLoader.load(curState == ImageState.down
        ? widget.activeImgUrl
        : widget.normalImgUrl);
  }

  Widget? getColorImage() {
    return ImageLoader.load(widget.normalImgUrl,
        color: curState == ImageState.down
            ? widget.activeColor
            : widget.normalColor);
  }

  void update(ImageState newState) {
    if (curState == newState) {
      return;
    }
    setState(() {
      curState = newState;
    });
  }
}
