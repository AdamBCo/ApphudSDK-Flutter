import 'dart:ui';

import 'package:apphud/models/sk_product/subscription_period_time_wrapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_period_wrapper.g.dart';

@JsonSerializable()
class SKProductSubscriptionPeriodWrapper {
  final int? numberOfUnits;
  final SKSubscriptionPeriodTime? time;

  SKProductSubscriptionPeriodWrapper({
    required this.numberOfUnits,
    required this.time,
  });

  factory SKProductSubscriptionPeriodWrapper.fromJson(Map map) =>
      _$SKProductSubscriptionPeriodWrapperFromJson(map as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final SKProductSubscriptionPeriodWrapper typedOther =
        other as SKProductSubscriptionPeriodWrapper;
    return typedOther.numberOfUnits == numberOfUnits && typedOther.time == time;
  }

  @override
  int get hashCode => hashValues(this.numberOfUnits, this.time);
}
