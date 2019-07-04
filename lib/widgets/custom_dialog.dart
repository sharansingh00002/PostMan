import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    this.radius = 8.0,
    this.assetName,
    this.child,
    this.title,
    this.description,
    this.buttons,
  });

  final double radius;
  final String assetName;
  final String title;
  final String description;
  final List<Widget> buttons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: title != null,
              child: Text(
                title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            child ?? Container(),
            Visibility(
              visible: description != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  description ?? '',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: (buttons == null) ? 8.0 : 0.0,
              ),
              child: (buttons == null)
                  ? Container()
                  : Row(
                      mainAxisAlignment: (buttons.length > 1)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.spaceEvenly,
                      children: buttons,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
