// ignore_for_file: unused_import, implementation_imports

import 'dart:ffi';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:isar/src/isar_native.dart';
import 'package:isar/src/query_builder.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'databace_isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"fstPage_isar","idProperty":"id","properties":[{"name":"id","type":3},{"name":"fstPage_setting","type":11},{"name":"setUP","type":0},{"name":"locled","type":0},{"name":"back","type":0},{"name":"passcode","type":0},{"name":"seitai","type":0}],"indexes":[],"links":[]}]';

Future<Isar> openIsar(
    {String name = 'isar',
    String? directory,
    int maxSize = 1000000000,
    Uint8List? encryptionKey}) async {
  final path = await _preparePath(directory);
  return openIsarInternal(
      name: name,
      directory: path,
      maxSize: maxSize,
      encryptionKey: encryptionKey,
      schema: _schema,
      getCollections: (isar) {
        final collectionPtrPtr = malloc<Pointer>();
        final propertyOffsetsPtr = malloc<Uint32>(7);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(7);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['fstPage_isar'] = IsarCollectionImpl<fstPage_isar>(
          isar: isar,
          adapter: _fstPage_isarAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 7),
          propertyIds: {
            'id': 0,
            'fstPage_setting': 1,
            'setUP': 2,
            'locled': 3,
            'back': 4,
            'passcode': 5,
            'seitai': 6
          },
          indexIds: {},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        malloc.free(propertyOffsetsPtr);
        malloc.free(collectionPtrPtr);

        return collections;
      });
}

Future<String> _preparePath(String? path) async {
  if (path == null || p.isRelative(path)) {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, path ?? 'isar');
  } else {
    return path;
  }
}

class _fstPage_isarAdapter extends TypeAdapter<fstPage_isar> {
  @override
  int serialize(IsarCollectionImpl<fstPage_isar> collection, RawObject rawObj,
      fstPage_isar object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.fstPage_setting;
    dynamicSize += (value1?.length ?? 0) * 8;
    List<Uint8List?>? bytesList1;
    if (value1 != null) {
      bytesList1 = [];
      for (var str in value1) {
        final bytes = _utf8Encoder.convert(str);
        bytesList1.add(bytes);
        dynamicSize += bytes.length;
      }
    }
    final _fstPage_setting = bytesList1;
    final value2 = object.setUP;
    final _setUP = value2;
    final value3 = object.locled;
    final _locled = value3;
    final value4 = object.back;
    final _back = value4;
    final value5 = object.passcode;
    final _passcode = value5;
    final value6 = object.seitai;
    final _seitai = value6;
    final size = dynamicSize + 23;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        malloc.free(rawObj.buffer);
        rawObj.buffer = malloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = malloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = rawObj.buffer.asTypedList(size);
    final writer = BinaryWriter(buffer, 23);
    writer.writeLong(offsets[0], _id);
    writer.writeStringList(offsets[1], _fstPage_setting);
    writer.writeBool(offsets[2], _setUP);
    writer.writeBool(offsets[3], _locled);
    writer.writeBool(offsets[4], _back);
    writer.writeBool(offsets[5], _passcode);
    writer.writeBool(offsets[6], _seitai);
    return bufferSize;
  }

  @override
  fstPage_isar deserialize(IsarCollectionImpl<fstPage_isar> collection,
      BinaryReader reader, List<int> offsets) {
    final object = fstPage_isar();
    object.id = reader.readLongOrNull(offsets[0]);
    object.fstPage_setting = reader.readStringList(offsets[1]);
    object.setUP = reader.readBoolOrNull(offsets[2]);
    object.locled = reader.readBoolOrNull(offsets[3]);
    object.back = reader.readBoolOrNull(offsets[4]);
    object.passcode = reader.readBoolOrNull(offsets[5]);
    object.seitai = reader.readBoolOrNull(offsets[6]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readStringList(offset)) as P;
      case 2:
        return (reader.readBoolOrNull(offset)) as P;
      case 3:
        return (reader.readBoolOrNull(offset)) as P;
      case 4:
        return (reader.readBoolOrNull(offset)) as P;
      case 5:
        return (reader.readBoolOrNull(offset)) as P;
      case 6:
        return (reader.readBoolOrNull(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension GetCollection on Isar {
  IsarCollection<fstPage_isar> get fstPage_isars {
    return getCollection('fstPage_isar');
  }
}

extension fstPage_isarQueryWhereSort on QueryBuilder<fstPage_isar, QWhere> {
  QueryBuilder<fstPage_isar, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension fstPage_isarQueryWhere on QueryBuilder<fstPage_isar, QWhereClause> {}

extension fstPage_isarQueryFilter
    on QueryBuilder<fstPage_isar, QFilterCondition> {
  QueryBuilder<fstPage_isar, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> setUPIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'setUP',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> setUPEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'setUP',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> locledIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'locled',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> locledEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'locled',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> backIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'back',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> backEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'back',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> passcodeIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'passcode',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> passcodeEqualTo(
      bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'passcode',
      value: value,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> seitaiIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'seitai',
      value: null,
    ));
  }

  QueryBuilder<fstPage_isar, QAfterFilterCondition> seitaiEqualTo(bool? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'seitai',
      value: value,
    ));
  }
}

extension fstPage_isarQueryLinks
    on QueryBuilder<fstPage_isar, QFilterCondition> {}

extension fstPage_isarQueryWhereSortBy on QueryBuilder<fstPage_isar, QSortBy> {
  QueryBuilder<fstPage_isar, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortBySetUP() {
    return addSortByInternal('setUP', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortBySetUPDesc() {
    return addSortByInternal('setUP', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByLocled() {
    return addSortByInternal('locled', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByLocledDesc() {
    return addSortByInternal('locled', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByBack() {
    return addSortByInternal('back', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByBackDesc() {
    return addSortByInternal('back', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByPasscode() {
    return addSortByInternal('passcode', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortByPasscodeDesc() {
    return addSortByInternal('passcode', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortBySeitai() {
    return addSortByInternal('seitai', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> sortBySeitaiDesc() {
    return addSortByInternal('seitai', Sort.Desc);
  }
}

extension fstPage_isarQueryWhereSortThenBy
    on QueryBuilder<fstPage_isar, QSortThenBy> {
  QueryBuilder<fstPage_isar, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenBySetUP() {
    return addSortByInternal('setUP', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenBySetUPDesc() {
    return addSortByInternal('setUP', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByLocled() {
    return addSortByInternal('locled', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByLocledDesc() {
    return addSortByInternal('locled', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByBack() {
    return addSortByInternal('back', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByBackDesc() {
    return addSortByInternal('back', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByPasscode() {
    return addSortByInternal('passcode', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenByPasscodeDesc() {
    return addSortByInternal('passcode', Sort.Desc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenBySeitai() {
    return addSortByInternal('seitai', Sort.Asc);
  }

  QueryBuilder<fstPage_isar, QAfterSortBy> thenBySeitaiDesc() {
    return addSortByInternal('seitai', Sort.Desc);
  }
}

extension fstPage_isarQueryWhereDistinct
    on QueryBuilder<fstPage_isar, QDistinct> {
  QueryBuilder<fstPage_isar, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<fstPage_isar, QDistinct> distinctBySetUP() {
    return addDistinctByInternal('setUP');
  }

  QueryBuilder<fstPage_isar, QDistinct> distinctByLocled() {
    return addDistinctByInternal('locled');
  }

  QueryBuilder<fstPage_isar, QDistinct> distinctByBack() {
    return addDistinctByInternal('back');
  }

  QueryBuilder<fstPage_isar, QDistinct> distinctByPasscode() {
    return addDistinctByInternal('passcode');
  }

  QueryBuilder<fstPage_isar, QDistinct> distinctBySeitai() {
    return addDistinctByInternal('seitai');
  }
}

extension fstPage_isarQueryProperty
    on QueryBuilder<fstPage_isar, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<List<String>?, QQueryOperations> fstPage_settingProperty() {
    return addPropertyName('fstPage_setting');
  }

  QueryBuilder<bool?, QQueryOperations> setUPProperty() {
    return addPropertyName('setUP');
  }

  QueryBuilder<bool?, QQueryOperations> locledProperty() {
    return addPropertyName('locled');
  }

  QueryBuilder<bool?, QQueryOperations> backProperty() {
    return addPropertyName('back');
  }

  QueryBuilder<bool?, QQueryOperations> passcodeProperty() {
    return addPropertyName('passcode');
  }

  QueryBuilder<bool?, QQueryOperations> seitaiProperty() {
    return addPropertyName('seitai');
  }
}
