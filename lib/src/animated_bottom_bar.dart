import 'package:flutter/material.dart';

/// update by using [selectedIndex]
/// get the updated value in [onItemSelected]

class AnimatedBottomBar extends StatefulWidget {

  AnimatedBottomBar({
    Key? key,
    this.height = 70,
    this.width = 100,
    this.selectedIndex = 0,
    this.iconSize,
    this.cornerRadius = 15,
    this.depth = 8,
    this.shrink = 30,
    this.color = Colors.blue,
    this.animationDuration = const Duration(milliseconds: 300),
    this.curves = Curves.easeInOut,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  final double height;
  final double width;
  final double cornerRadius;
  final double? iconSize;
  final double depth;
  final double shrink;
  final int selectedIndex;
  final Duration animationDuration;
  final Curve curves;
  final Color color;
  final List<AnimatedBarItem>? items;
  final ValueChanged<int>? onItemSelected;

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {

  bool onPress = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: widget.height + widget.depth,
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: widget.curves,
          bottom: onPress == false ? widget.depth : 0,
          child: Container(
            alignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: widget.curves,
              width: onPress == false ?
              widget.width :
              widget.width-widget.shrink,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.cornerRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(
                      2,
                      4.0,
                    ),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: widget.color,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.items!.map((item) {
                  var index = widget.items!.indexOf(item);
                  return GestureDetector(
                    onTap: () {
                      setState((){
                        setState(() {
                          onPress = true;
                          Future.delayed(widget.animationDuration,(){
                            setState(() {
                              widget.onItemSelected!(index);
                              onPress = false;
                            });
                          });
                        });
                      });
                    },
                    child: _ItemWidget(
                      item: item,
                      iconSize: widget.iconSize ?? 20,
                      width: widget.width * (1/(widget.items!.length + 1)),
                      isSelected: index == widget.selectedIndex,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final AnimatedBarItem item;
  final double width;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.width,
    required this.iconSize,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: double.maxFinite,
        width: width,
        color: Colors.transparent,
        child: item.title != null ?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(
                size: iconSize,
                color: isSelected
                    ? item.activeColor
                    : item.inactiveColor == null
                    ? item.activeColor
                    : item.inactiveColor,
              ),
              child: item.icon,
            ),
            DefaultTextStyle.merge(
              style: TextStyle(
                color: isSelected
                    ? item.activeColor
                    : item.inactiveColor == null
                    ? item.activeColor
                    : item.inactiveColor,
                fontWeight: FontWeight.bold,
              ),
              child: item.title ?? Text(""),
            ),
          ],
        ) : IconTheme(
            data: IconThemeData(
              size: iconSize,
              color: isSelected
                  ? item.activeColor
                  : item.inactiveColor == null
                  ? item.activeColor
                  : item.inactiveColor,
            ),
            child: item.icon
        ),
      );
  }
}

class AnimatedBarItem {

  AnimatedBarItem({
    required this.icon,
    this.activeColor = Colors.white,
    this.title,
    this.inactiveColor = Colors.black,
  });

  final Widget icon;

  final Widget? title;

  final Color activeColor;

  final Color? inactiveColor;

}

