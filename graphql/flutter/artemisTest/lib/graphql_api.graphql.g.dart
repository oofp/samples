// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUser$Mutation$User _$CreateUser$Mutation$UserFromJson(
    Map<String, dynamic> json) {
  return CreateUser$Mutation$User()
    ..userType = _$enumDecodeNullable(_$UserTypeEnumMap, json['userType'],
        unknownValue: UserType.artemisUnknown)
    ..lastName = json['lastName'] as String
    ..firstName = json['firstName'] as String
    ..middleName = json['middleName'] as String;
}

Map<String, dynamic> _$CreateUser$Mutation$UserToJson(
        CreateUser$Mutation$User instance) =>
    <String, dynamic>{
      'userType': _$UserTypeEnumMap[instance.userType],
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumMap = {
  UserType.userManager: 'UserManager',
  UserType.userTechLead: 'UserTechLead',
  UserType.userDev: 'UserDev',
  UserType.userQA: 'UserQA',
  UserType.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

CreateUser$Mutation _$CreateUser$MutationFromJson(Map<String, dynamic> json) {
  return CreateUser$Mutation()
    ..createUser = json['createUser'] == null
        ? null
        : CreateUser$Mutation$User.fromJson(
            json['createUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUser$MutationToJson(
        CreateUser$Mutation instance) =>
    <String, dynamic>{
      'createUser': instance.createUser?.toJson(),
    };

GetCalls$Query$Call$CallID _$GetCalls$Query$Call$CallIDFromJson(
    Map<String, dynamic> json) {
  return GetCalls$Query$Call$CallID()..id = json['id'] as int;
}

Map<String, dynamic> _$GetCalls$Query$Call$CallIDToJson(
        GetCalls$Query$Call$CallID instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

GetCalls$Query$Call _$GetCalls$Query$CallFromJson(Map<String, dynamic> json) {
  return GetCalls$Query$Call()
    ..callID = json['callID'] == null
        ? null
        : GetCalls$Query$Call$CallID.fromJson(
            json['callID'] as Map<String, dynamic>)
    ..localAddress = json['localAddress'] as String
    ..remoteAddress = json['remoteAddress'] as String
    ..callState = _$enumDecodeNullable(_$CallStateEnumMap, json['callState'],
        unknownValue: CallState.artemisUnknown);
}

Map<String, dynamic> _$GetCalls$Query$CallToJson(
        GetCalls$Query$Call instance) =>
    <String, dynamic>{
      'callID': instance.callID?.toJson(),
      'localAddress': instance.localAddress,
      'remoteAddress': instance.remoteAddress,
      'callState': _$CallStateEnumMap[instance.callState],
    };

const _$CallStateEnumMap = {
  CallState.offered: 'Offered',
  CallState.ringing: 'Ringing',
  CallState.connecting: 'Connecting',
  CallState.connected: 'Connected',
  CallState.initiated: 'Initiated',
  CallState.ringback: 'Ringback',
  CallState.disconnected: 'Disconnected',
  CallState.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

GetCalls$Query _$GetCalls$QueryFromJson(Map<String, dynamic> json) {
  return GetCalls$Query()
    ..allCalls = (json['allCalls'] as List)
        ?.map((e) => e == null
            ? null
            : GetCalls$Query$Call.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GetCalls$QueryToJson(GetCalls$Query instance) =>
    <String, dynamic>{
      'allCalls': instance.allCalls?.map((e) => e?.toJson())?.toList(),
    };

GetUser$Query$User _$GetUser$Query$UserFromJson(Map<String, dynamic> json) {
  return GetUser$Query$User()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..userType = _$enumDecodeNullable(_$UserTypeEnumMap, json['userType'],
        unknownValue: UserType.artemisUnknown)
    ..middleName = json['middleName'] as String;
}

Map<String, dynamic> _$GetUser$Query$UserToJson(GetUser$Query$User instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': _$UserTypeEnumMap[instance.userType],
      'middleName': instance.middleName,
    };

GetUser$Query _$GetUser$QueryFromJson(Map<String, dynamic> json) {
  return GetUser$Query()
    ..user = json['user'] == null
        ? null
        : GetUser$Query$User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetUser$QueryToJson(GetUser$Query instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

NewUserSub$Subscription$User _$NewUserSub$Subscription$UserFromJson(
    Map<String, dynamic> json) {
  return NewUserSub$Subscription$User()
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..userType = _$enumDecodeNullable(_$UserTypeEnumMap, json['userType'],
        unknownValue: UserType.artemisUnknown);
}

Map<String, dynamic> _$NewUserSub$Subscription$UserToJson(
        NewUserSub$Subscription$User instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': _$UserTypeEnumMap[instance.userType],
    };

NewUserSub$Subscription _$NewUserSub$SubscriptionFromJson(
    Map<String, dynamic> json) {
  return NewUserSub$Subscription()
    ..newUser = json['newUser'] == null
        ? null
        : NewUserSub$Subscription$User.fromJson(
            json['newUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewUserSub$SubscriptionToJson(
        NewUserSub$Subscription instance) =>
    <String, dynamic>{
      'newUser': instance.newUser?.toJson(),
    };

CreateUserArguments _$CreateUserArgumentsFromJson(Map<String, dynamic> json) {
  return CreateUserArguments(
    firstN: json['firstN'] as String,
    lastN: json['lastN'] as String,
  );
}

Map<String, dynamic> _$CreateUserArgumentsToJson(
        CreateUserArguments instance) =>
    <String, dynamic>{
      'firstN': instance.firstN,
      'lastN': instance.lastN,
    };

GetUserArguments _$GetUserArgumentsFromJson(Map<String, dynamic> json) {
  return GetUserArguments(
    userId: json['userId'] as String,
    midName: json['midName'] as String,
  );
}

Map<String, dynamic> _$GetUserArgumentsToJson(GetUserArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'midName': instance.midName,
    };
