

class datas {
  int? number;
  String? user;
  generate_uuid uuid_uuid;

  datas(this.number, this.user, this.uuid_uuid);

  int return_hush() {
    int? _hashcode;

    _hashcode = int.parse('${user.hashCode}'
        '${number.hashCode}'
        '${uuid_uuid.return_uuid().hashCode}');

    return _hashcode;
  }

  Map Users_Datas() {
    print('uuid: ${uuid_uuid.return_uuid()}');
    print('uuid-hash: ${uuid_uuid.return_uuid().hashCode}');

    // ignore: omit_local_variable_types
    Map<String, dynamic> _Users_data = {
      'user': Null,
      'number': Null,
      'uuid': Null
    };

    _Users_data['user'] = user;

    _Users_data['number'] = number;

    _Users_data['uuid'] = uuid_uuid.return_uuid();

    return _Users_data;
  }

  int return_hush_usernumber() {
    var _hascode = int.parse('${user.hashCode}' '${number.hashCode}');

    return _hascode;
  }

  int generate_data() {
    Map<String, dynamic>? _Users_data = Users_Datas().cast<String, dynamic>();

    String _user = _Users_data['user'];

    int _number = _Users_data['number'];

    int? _hashcode;

    _hashcode = int.parse('${_user.hashCode}' '${_number.hashCode}');

    return _hashcode;
  }
}

class generate_uuid {
  String uuid_id;

  generate_uuid(this.uuid_id);

  String return_uuid() {
    return uuid_id;
  }
}