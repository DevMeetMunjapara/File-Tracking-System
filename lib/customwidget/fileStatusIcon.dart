import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FileStatusIcon extends StatelessWidget {
  var fileStatus;
  var mysize = 20;
  FileStatusIcon({
    super.key,
    required this.fileStatus,
  });
  Widget iconFun(String status) {
    if (status == "reject") {
      return Icon(
        Icons.cancel,
        size: 20,
        color: Colors.red,
      );
    } else if (status == "process") {
      return Icon(
        Icons.work_history,
        size: 20,
        color: Color.fromARGB(255, 234, 187, 17),
      );
    } else if (status == "approve") {
      return Icon(
        Icons.verified,
        size: 20,
        color: Color.fromARGB(255, 15, 161, 20),
      );
    }
    return Icon(Icons.abc);
  }

  @override
  Widget build(BuildContext context) {
    return iconFun(fileStatus);
  }
}
