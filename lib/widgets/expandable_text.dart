import 'package:flutter/material.dart';
import 'package:nailstudy_app_flutter/constants.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
          duration: const Duration(milliseconds: 500),
          child: ConstrainedBox(
              constraints: widget.isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 50.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: kParagraph1, color: kGrey),
              ))),
      widget.isExpanded
          ? ConstrainedBox(constraints: const BoxConstraints())
          : TextButton(
              child: const Text('...'),
              onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}