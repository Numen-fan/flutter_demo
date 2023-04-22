// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// ImageLoader公共类，提供图片加载的方法
/// 图片格式有普通的png，jpg，jpeg以及矢量图片svg
/// 图片来源可以是网络图片，也可以是本地的asset图片
///
class ImageLoader extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const ImageLoader(this.url, {this.width, this.height, this.color, this.fit});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: url.isNotEmpty == true,
      child: Visibility(
        visible: url.endsWith('.svg') == true,
        child:
        // isHttp(url)
        //     ? SvgPicture.network(
        //         url,
        //         width: width,
        //         height: height,
        //         fit: fit ?? BoxFit.cover,
        //         color: color,
        //       )
        //     :
        SvgPicture.asset(
                url,
                width: width,
                height: height,
                fit: fit ?? BoxFit.cover,
                color: color,
              ),
        replacement:
        // isHttp(url)
        //     ? CachedNetworkImage(
        //         imageUrl: url,
        //         width: width,
        //         height: height,
        //         fit: BoxFit.cover,
        //         color: color,
        //       )
        //     :
        Image.asset(
                url,
                width: width,
                height: height,
                fit: BoxFit.cover,
                color: color,
              ),
      ),
      replacement: SizedBox(
        width: width,
        height: height,
      ),
    );
  }

  bool isHttp(String url) {
    if (url.startsWith('http:') || url.startsWith('https:')) {
      return true;
    }
    return false;
  }
}
