import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatUTCDate(String date) {
  var strToDateTime = DateTime.parse(date.toString());
  var result = DateFormat('dd-MM-yyyy').format(strToDateTime);

  return result.replaceAll('-', '.');
}

String formatIncomingPhone(String phone) {
  String p = '';
  if (phone.toString().length > 9) {
    p = phone.toString().substring(4);
  } else {
    p = phone;
  }
  p = '${p.length >= 2 ? p.substring(0, 2) : ''} ${p.length >= 5 ? p.substring(2, 5) : ''} ${p.length >= 5 ? p.substring(5) : ''}';

  return p;
}

String formatPhone(String phone) {
  String formatted = '';
  if (phone.length == 2 || phone.length == 6) {
    formatted = '$phone ';
  } else {
    formatted = phone;
  }

  return phone;
}

Map<String, dynamic> unformatShopFormData(rawData) {
  var data = {
    "key_uz": rawData['translates'][1]['key'],
    "key_ru": rawData['translates'][0]['key'],
    "key_en": rawData['translates'][2]['key'],
    "address_uz": rawData['translates'][1]['address'],
    "address_ru": rawData['translates'][0]['address'],
    "address_en": rawData['translates'][2]['address'],
    "description_uz": rawData['translates'][1]['address'],
    "description_ru": rawData['translates'][0]['address'],
    "description_en": rawData['translates'][2]['address'],
    "latitude": rawData['latitude'] ?? 0.0,
    "longitude": rawData['longitude'] ?? 0.0,
    "phone": rawData['phone'],
    "contact_person": rawData['contact_person'],
    "owner_person": rawData['owner_person'],
    "outlet_type_id": rawData['outlet_type_id'] != null
        ? rawData['outlet_type_id'].toString()
        : '48',
    "channel_type_id": rawData['channel_type_id'] != null
        ? rawData['channel_type_id'].toString()
        : '1',
    "state_id":
        rawData['state_id'] != null ? rawData['state_id'].toString() : '1',
  };

  return data;
}

Map<String, dynamic> buildShopFormData(rawData) {
  var data = {
    "project_id": rawData['project_id'],
    "id": rawData['id'],
    "translate": [
      {
        "lang_id": 1,
        "key": rawData['key_ru'],
        "address": rawData['address_ru'],
        "description": rawData['description_ru'],
      },
      {
        "lang_id": 2,
        "key": rawData['key_uz'],
        "address": rawData['address_uz'],
        "description": rawData['description_uz'],
      },
      {
        "lang_id": 3,
        "key": rawData['key_en'],
        "address": rawData['address_en'],
        "description": rawData['description_en'],
      },
    ],
    "latitude": rawData['latitude'] ?? 0.0,
    "longitude": rawData['longitude'] ?? 0.0,
    "phone": rawData['phone'],
    "contact_person": rawData['contact_person'],
    "owner_person": rawData['owner_person'],
    "outlet_type_id": rawData['outlet_type_id'],
    "channel_type_id": rawData['channel_type_id'],
    "state_id": rawData['state_id'],
  };

  return data;
}

List buildSurveyEditData(List rows, List editedRows) {
  List data = [];
  for (var i = 0; i < editedRows.length; i++) {
    var product_id =
        rows[int.parse(editedRows[i]['row'].toString())]['product_id'];
    Map<String, dynamic> currentRow = Map.from(editedRows[i]);
    currentRow.remove('row');
    Iterable propertIds = currentRow.keys;

    data.addAll(
      propertIds.map(
        (id) => {
          "product_id": product_id,
          "property_id": id,
          "value": currentRow[id],
        },
      ),
    );
  }

  return data;
}

List buildSurveyAddData(List rows, List editedRows) {
  List data = [];
  for (var i = 0; i < editedRows.length; i++) {
    var product_id = editedRows[i]['product_id'];
    Map<String, dynamic> currentRow = Map.from(editedRows[i]);
    currentRow.remove('product_id');
    currentRow.remove('product_name');
    Iterable propertIds = currentRow.keys;

    data.addAll(
      propertIds.map(
        (id) => {
          "product_id": product_id,
          "property_id": id,
          "value": currentRow[id],
        },
      ),
    );
  }

  return data;
}
