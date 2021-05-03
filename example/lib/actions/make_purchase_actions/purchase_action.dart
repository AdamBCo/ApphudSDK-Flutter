import 'dart:io';

import 'package:appHud_example/widgets/apphud_purchase_result_widget.dart';
import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/composite/apphud_purchase_result.dart';
import 'package:flutter/material.dart';

import '../action_screen.dart';

class PurchaseAction extends ActionFlow {
  String parameterName = "productIdentifier";
  String iOSValue = "productWeekly";
  String androidValue = "com.apphud.test.weekly1";

  @override
  Widget actionName() {
    return Text(
      "Method name: purchase",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget actionParameters() {
    return Text(
        "Parameters: $parameterName - ${Platform.isIOS ? iOSValue : androidValue}",
        style: TextStyle(fontSize: 20, color: Colors.green));
  }

  Widget actionResponse() {
    return FutureBuilder<ApphudPurchaseResult>(
        future: AppHud.purchase(Platform.isIOS ? iOSValue : androidValue),
        builder: (
          BuildContext context,
          AsyncSnapshot<ApphudPurchaseResult> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            return Expanded(
              child: ApphudPurchaseResultWidget(
                result: snapshot.data,
              ),
            );
          } else {
            return Text("Waiting...");
          }
        });
  }
}
