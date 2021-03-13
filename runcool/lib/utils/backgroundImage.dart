import 'package:flutter/material.dart';
import 'constants.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  BackgroundImage({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              image: DecorationImage(
                  image: AssetImage('images/gym.jpg'),
                  fit: BoxFit.fitWidth,
                  colorFilter: new ColorFilter.mode(
                      kBackgroundColor.withOpacity(0.2), BlendMode.dstATop)),
            ),
            // constraints: BoxConstraints.expand(),
          ),
        ),
        child,
      ],
    );
  }
}
