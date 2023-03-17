/// Created by fanjiajia02 on 2023/3/17
/// Desc:

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class GroupedListView<E, G extends Comparable<Object>> extends StatefulWidget {
  const GroupedListView({
    Key? key,
    required this.groupBy,
    required this.groupBuilder,
    required this.itemBuilder,
    required this.separatorHeight,
    required this.tileHeight,
    required this.elements,
  }) : super(key: key);

  final G Function(E element) groupBy;
  final Widget Function(G group) groupBuilder;
  final Widget Function(BuildContext context, E element) itemBuilder;
  final List<E> elements;
  final double separatorHeight;
  final double tileHeight;

  @override
  _GroupedListViewState<E, G> createState() => _GroupedListViewState<E, G>();
}

class _GroupedListViewState<E, G extends Comparable<Object>>
    extends State<GroupedListView<E, G>> {
  late List<E> _elements;

  late List<double> _groupHeights;
  late List<G> _groupNames;
  int _currentGroupIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _elements = widget.elements;

    _groupNames = groupBy<E, G>(_elements, widget.groupBy)
        .entries
        .map<G>((dynamic entry) => entry.key)
        .toList();

    _groupHeights = groupBy<E, G>(_elements, widget.groupBy)
        .entries
        .map<double>((dynamic entry) => entry.value.length.toDouble())
        .toList();

    double sum = 0;

    _groupHeights = _groupHeights
        .map<double>((double itemCount) =>
    sum += itemCount * widget.tileHeight + widget.separatorHeight)
        .toList();

    _scrollController.addListener(() {
      final double controllerOffset =
          _scrollController.offset + widget.separatorHeight;

      if (controllerOffset < _groupHeights.first) {
        setState(() => _currentGroupIndex = 0);
      } else {
        for (int i = 1; i < _groupHeights.length; i++) {
          if (controllerOffset >= _groupHeights[i - 1] &&
              controllerOffset < _groupHeights[i]) {
            setState(() => _currentGroupIndex = i);
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: widget.separatorHeight),
      ),
      ListView.builder(
        key: widget.key,
        controller: _scrollController,
        itemCount: _elements.length * 2,
        itemBuilder: (BuildContext context, int index) {
          final int actualIndex = index ~/ 2;
          if (index.isEven) {
            final G currentGroup = widget.groupBy(_elements[actualIndex]);
            final G? previousGroup = actualIndex - 1 < 0
                ? null
                : widget.groupBy(_elements[actualIndex - 1]);

            if (previousGroup != currentGroup) {
              return SizedBox(
                height: widget.separatorHeight,
                child: widget.groupBuilder(currentGroup),
              );
            }

            return Container();
          }

          return SizedBox(
            height: widget.tileHeight,
            child: widget.itemBuilder(context, _elements[actualIndex]),
          );
        },
      ),
      SizedBox(
        height: widget.separatorHeight,
        child: widget.groupBuilder(_groupNames[_currentGroupIndex]),
      ),
    ],
  );
}