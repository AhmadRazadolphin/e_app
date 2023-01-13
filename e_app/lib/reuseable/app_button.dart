import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? textButton;
  final IconData? iconButton;
  final EdgeInsets? paddingButton;
  const AppButton(
      {Key? key, required this.textButton, this.iconButton, this.paddingButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Stack(
            children: [
              // const ButtonThemeBar(),
              Container(
                height: height,
                width: width / 1.8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Center(
                      child: Text(
                        textButton!,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: paddingButton!,
                    child: Icon(
                      iconButton,
                      color: Colors.blue.shade700,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
