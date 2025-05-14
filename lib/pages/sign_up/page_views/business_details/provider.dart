import 'package:country_state_city/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../components/country_bottom_sheet.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/extensions/num_duration.dart';

final businessDetailsPageViewProvider =
    NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.businessType,
    this.dob,
    this.country,
    this.businessName = '',
    this.businessAddress = '',
    this.phone = '',
    this.city = '',
    this.regNo = '',
  });

  final String? businessType;
  final DateTime? dob;
  final Country? country;
  final String businessName;
  final String businessAddress;
  final String phone;
  final String city;
  final String regNo;

  _State copyWith({
    String? businessType,
    DateTime? dob,
    Country? country,
    String? businessName,
    String? businessAddress,
    String? phone,
    String? city,
    String? regNo,
  }) {
    return _State(
      dob: dob ?? this.dob,
      businessType: businessType ?? this.businessType,
      country: country ?? this.country,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      regNo: regNo ?? this.regNo,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => _State(country: kDefaultCountry);

  void updateBusinessName(String value) =>
      state = state.copyWith(businessName: value);

  void updateBusinessAddress(String value) =>
      state = state.copyWith(businessAddress: value);

  void updateBusinessType(String? businessType) =>
      state = state.copyWith(businessType: businessType);

  void onPhoneChanged(String value) => state = state.copyWith(phone: value);

  void updateCity(String value) => state = state.copyWith(city: value);
  void updateRegNo(String value) => state = state.copyWith(regNo: value);

  void updateDOB(DateTime? dob) => state = state.copyWith(dob: dob);

  void onCodeTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        duration: 700.ms,
      ),
      builder: (_) {
        return CountryBottomSheet(
          selectedCountry: state.country,
          onSelected: (country) => state = state.copyWith(country: country),
        );
      },
    );
  }
}
