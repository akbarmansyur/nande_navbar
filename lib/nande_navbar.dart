library nande_navbar;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class NandeNavbar extends StatelessWidget {
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double height;
  final List<NandeItem> customItems;
  final TextStyle? labelStyle;
  final bool enableLabel;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Color? splashColor;
  final Color? highlightColor;
  final int currentIndex;
  final Function(int) onTap;
  final double selectedIconSize;
  final double unselectedIconSize;
  const NandeNavbar({
    Key? key,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius,
    this.backgroundColor,
    this.height = 60,
    required this.customItems,
    this.enableLabel = false,
    this.labelStyle = const TextStyle(),
    this.selectedColor = Colors.black87,
    this.unSelectedColor = Colors.black26,
    this.splashColor = Colors.grey,
    this.highlightColor = Colors.grey,
    required this.currentIndex,
    required this.onTap,
    this.selectedIconSize = 24,
    this.unselectedIconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          color:
              backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var item in customItems) ...[
                Expanded(
                  child: NandeNavbarItems(
                    currentIndex: currentIndex,
                    item: item,
                    index: customItems.indexOf(item),
                    ontap: onTap,
                    splashcolor: splashColor!,
                    highlightColor: highlightColor!,
                    selectedColor: selectedColor!,
                    unSelectedColor: unSelectedColor!,
                    selectedIconSize: selectedIconSize,
                    unselectedIconSize: unselectedIconSize,
                    enableLabel: enableLabel,
                    labelStyle: labelStyle!,
                  ),
                ),
              ]
            ]),
      ),
    );
  }
}

class NandeItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String? label;

  NandeItem({
    required this.icon,
    this.selectedIcon,
    this.label,
  });
}

class NandeNavbarItems extends StatefulWidget {
  final NandeItem item;
  final int currentIndex;
  final int index;
  final Function(int) ontap;
  final Color selectedColor;
  final Color highlightColor;
  final Color splashcolor;
  final Color unSelectedColor;
  final double selectedIconSize;
  final double unselectedIconSize;

  final bool enableLabel;
  final TextStyle labelStyle;
  const NandeNavbarItems({
    Key? key,
    required this.currentIndex,
    required this.index,
    required this.ontap,
    required this.item,
    required this.highlightColor,
    required this.splashcolor,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.selectedIconSize,
    required this.unselectedIconSize,
    required this.labelStyle,
    required this.enableLabel,
  }) : super(key: key);

  @override
  State<NandeNavbarItems> createState() => _NandeNavbarItemsState();
}

class _NandeNavbarItemsState extends State<NandeNavbarItems>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  late AnimationController animationController;
  late CurvedAnimation curved;

  late Animation<Color?> iconColor;
  late Widget icon;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    curved = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    currentIndex = widget.currentIndex;

    var colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(
            begin: widget.unSelectedColor, end: widget.selectedColor),
        weight: 1,
      ),
    ]).chain(CurveTween(curve: Curves.fastOutSlowIn));

    icon = Icon(
      widget.item.icon,
      color: widget.unSelectedColor,
      size: widget.unselectedIconSize,
    );
    iconColor = animationController.drive(colorTween);

    if (currentIndex == widget.index) {
      animationController
        ..forward()
        ..addListener(() {
          if (animationController.value > 0.5) {
            setState(() {
              icon = Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.rotationY(animationController.value * math.pi),
                child: Icon(
                  widget.item.selectedIcon ?? widget.item.icon,
                  color: widget.selectedColor,
                  size: widget.selectedIconSize,
                ),
              );
            });
          }
        });
    } else {
      animationController
        ..reverse()
        ..addListener(() {
          if (animationController.value < 0.5) {
            setState(() {
              icon = Icon(
                widget.item.icon,
                color: widget.unSelectedColor,
                size: widget.unselectedIconSize,
              );
            });
          }
        });
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant NandeNavbarItems oldWidget) {
    if (widget.currentIndex != oldWidget.currentIndex) {
      currentIndex = widget.currentIndex;
      if (currentIndex == widget.index) {
        animationController
          ..forward()
          ..addListener(() {
            if (animationController.value > 0.5) {
              setState(() {
                icon = Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.rotationY(animationController.value * math.pi),
                  child: Icon(
                    widget.item.selectedIcon ?? widget.item.icon,
                    color: widget.selectedColor,
                    size: widget.selectedIconSize,
                  ),
                );
              });
            }
          });
      } else {
        animationController
          ..reverse()
          ..addListener(() {
            if (animationController.value < 0.5) {
              setState(() {
                icon = Icon(
                  widget.item.icon,
                  color: widget.unSelectedColor,
                  size: widget.unselectedIconSize,
                );
              });
            }
          });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            splashColor: widget.splashcolor,
            highlightColor: widget.highlightColor,
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              widget.ontap(widget.index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: curved,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(0)
                        ..rotateY(curved.value * math.pi)
                        ..setEntry(3, 2, 0.001),
                      child: icon,
                    );
                  },
                ),
                const SizedBox(
                  height: 2,
                ),
                widget.enableLabel
                    ? currentIndex == widget.index
                        ? Text(
                            widget.item.label ?? '',
                            style: widget.labelStyle,
                          )
                        : Container()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
