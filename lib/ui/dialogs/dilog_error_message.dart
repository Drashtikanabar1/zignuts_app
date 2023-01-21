import 'package:flutter/material.dart';

class AlertErrorMessage extends StatefulWidget {
  final String? title, descriptions;

  const AlertErrorMessage({
    Key? key,
    this.title,
    this.descriptions,
  }) : super(key: key);

  @override
  _AlertErrorMessageState createState() => _AlertErrorMessageState();
}

class _AlertErrorMessageState extends State<AlertErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title!,
                      style: const TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(margin: const EdgeInsets.only(left: 0.0, right: 0.0), child: Divider(color: Colors.grey, height: 1)),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.descriptions!, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}