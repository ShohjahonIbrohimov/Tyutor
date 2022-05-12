import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:moreinfo/presentation/widgets/pages/auth/molecules/enter_phone_form.dart';

List studentInputFields = [
  {
    'name': 'fio',
    'type': 'text',
    'validator': 'fio_validator',
  },
  {
    'name': 'phone',
    'type': 'text',
    'inputFormatters': [
      FilteringTextInputFormatter.digitsOnly,
      CustomInputFormatter(),
      LengthLimitingTextInputFormatter(11),
    ],
    'prefix': const Text('+998 '),
    'validator': 'phone_validator',
  },
  {
    'name': 'telegram_link',
    'type': 'text',
    'validator': 'tg_validator',
  },
  {
    'name': 'email',
    'type': 'text',
    'validator': 'email_validator',
  },
  {
    'name': 'birthday',
    'type': 'date',
    'format': DateFormat('yyyy-MM-dd'),
    'initialDatePickerMode': null,
  },
  {
    'name': 'p_seria',
    'type': 'text',
    'validator': 'seria_validator',
    // 'autovalidateMode': AutovalidateMode.disabled,
  },
  {
    'name': 'p_number',
    'type': 'text',
    'validator': 'pass_num_validator',
    'inputFormatters': [FilteringTextInputFormatter.digitsOnly],
    // 'autovalidateMode': AutovalidateMode.disabled,
  },
  {
    'name': 'receive_date',
    'type': 'date',
    'format': DateFormat('yyyy'),
    'initialDatePickerMode': DatePickerMode.year,
  },
  {
    'name': 'course',
    'type': 'select',
    'options': [
      {
        'key': '1-Kurs',
        'id': 1,
      },
      {
        'key': '2-Kurs',
        'id': 2,
      },
      {
        'key': '3-Kurs',
        'id': 3,
      },
      {
        'key': '4-Kurs',
        'id': 4,
      },
    ]
  },
  {
    'name': 'permanent_address',
    'type': 'text',
  },
  {
    'name': 'rating_status',
    'type': 'text',
    'inputFormatters': [FilteringTextInputFormatter.digitsOnly]
  },
  {
    'name': 'behavior',
    'type': 'select',
    'options': [
      {
        'key': 'Muammoli',
        'id': 0,
      },
      {
        'key': 'Yaxshi',
        'id': 1,
      }
    ]
  },
];
