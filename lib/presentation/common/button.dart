import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/config/size_config.dart';

const buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.press,
    required this.text,
    this.icon,
    this.color,
    this.loading = false,
    this.outlined = false,
  }) : super(key: key);

  final String text;
  final Color? color;
  final bool outlined;
  final Function()? press;
  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      constraints: const BoxConstraints(maxWidth: 400),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side:
              BorderSide(color: loading ? Colors.grey.shade200 : primaryColor),
          primary: outlined ? Colors.white : color ?? primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: loading ? null : press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: SpinKitFadingCircle(
                      itemBuilder: (_, int index) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                      size: 30.0,
                    ),
                  )
                : Container(),
            Text(
              text,
              style: buttonTextStyle.copyWith(
                color: loading
                    ? Colors.grey
                    : outlined
                        ? primaryColor
                        : Colors.white,
              ),
            ),
            icon != null
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(icon),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
