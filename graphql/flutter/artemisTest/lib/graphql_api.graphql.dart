// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation$User with EquatableMixin {
  CreateUser$Mutation$User();

  factory CreateUser$Mutation$User.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$Mutation$UserFromJson(json);

  @JsonKey(unknownEnumValue: UserType.artemisUnknown)
  UserType userType;

  String lastName;

  String firstName;

  String middleName;

  @override
  List<Object> get props => [userType, lastName, firstName, middleName];
  Map<String, dynamic> toJson() => _$CreateUser$Mutation$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation with EquatableMixin {
  CreateUser$Mutation();

  factory CreateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$MutationFromJson(json);

  CreateUser$Mutation$User createUser;

  @override
  List<Object> get props => [createUser];
  Map<String, dynamic> toJson() => _$CreateUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetCalls$Query$Call$CallID with EquatableMixin {
  GetCalls$Query$Call$CallID();

  factory GetCalls$Query$Call$CallID.fromJson(Map<String, dynamic> json) =>
      _$GetCalls$Query$Call$CallIDFromJson(json);

  int id;

  @override
  List<Object> get props => [id];
  Map<String, dynamic> toJson() => _$GetCalls$Query$Call$CallIDToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetCalls$Query$Call with EquatableMixin {
  GetCalls$Query$Call();

  factory GetCalls$Query$Call.fromJson(Map<String, dynamic> json) =>
      _$GetCalls$Query$CallFromJson(json);

  GetCalls$Query$Call$CallID callID;

  String localAddress;

  String remoteAddress;

  @JsonKey(unknownEnumValue: CallState.artemisUnknown)
  CallState callState;

  @override
  List<Object> get props => [callID, localAddress, remoteAddress, callState];
  Map<String, dynamic> toJson() => _$GetCalls$Query$CallToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetCalls$Query with EquatableMixin {
  GetCalls$Query();

  factory GetCalls$Query.fromJson(Map<String, dynamic> json) =>
      _$GetCalls$QueryFromJson(json);

  List<GetCalls$Query$Call> allCalls;

  @override
  List<Object> get props => [allCalls];
  Map<String, dynamic> toJson() => _$GetCalls$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUser$Query$User with EquatableMixin {
  GetUser$Query$User();

  factory GetUser$Query$User.fromJson(Map<String, dynamic> json) =>
      _$GetUser$Query$UserFromJson(json);

  String firstName;

  String lastName;

  @JsonKey(unknownEnumValue: UserType.artemisUnknown)
  UserType userType;

  String middleName;

  @override
  List<Object> get props => [firstName, lastName, userType, middleName];
  Map<String, dynamic> toJson() => _$GetUser$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUser$Query with EquatableMixin {
  GetUser$Query();

  factory GetUser$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUser$QueryFromJson(json);

  GetUser$Query$User user;

  @override
  List<Object> get props => [user];
  Map<String, dynamic> toJson() => _$GetUser$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewUserSub$Subscription$User with EquatableMixin {
  NewUserSub$Subscription$User();

  factory NewUserSub$Subscription$User.fromJson(Map<String, dynamic> json) =>
      _$NewUserSub$Subscription$UserFromJson(json);

  String firstName;

  String lastName;

  @JsonKey(unknownEnumValue: UserType.artemisUnknown)
  UserType userType;

  @override
  List<Object> get props => [firstName, lastName, userType];
  Map<String, dynamic> toJson() => _$NewUserSub$Subscription$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewUserSub$Subscription with EquatableMixin {
  NewUserSub$Subscription();

  factory NewUserSub$Subscription.fromJson(Map<String, dynamic> json) =>
      _$NewUserSub$SubscriptionFromJson(json);

  NewUserSub$Subscription$User newUser;

  @override
  List<Object> get props => [newUser];
  Map<String, dynamic> toJson() => _$NewUserSub$SubscriptionToJson(this);
}

enum UserType {
  @JsonValue('UserManager')
  userManager,
  @JsonValue('UserTechLead')
  userTechLead,
  @JsonValue('UserDev')
  userDev,
  @JsonValue('UserQA')
  userQA,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum CallState {
  @JsonValue('Offered')
  offered,
  @JsonValue('Ringing')
  ringing,
  @JsonValue('Connecting')
  connecting,
  @JsonValue('Connected')
  connected,
  @JsonValue('Initiated')
  initiated,
  @JsonValue('Ringback')
  ringback,
  @JsonValue('Disconnected')
  disconnected,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class CreateUserArguments extends JsonSerializable with EquatableMixin {
  CreateUserArguments({@required this.firstN, @required this.lastN});

  @override
  factory CreateUserArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateUserArgumentsFromJson(json);

  final String firstN;

  final String lastN;

  @override
  List<Object> get props => [firstN, lastN];
  @override
  Map<String, dynamic> toJson() => _$CreateUserArgumentsToJson(this);
}

class CreateUserMutation
    extends GraphQLQuery<CreateUser$Mutation, CreateUserArguments> {
  CreateUserMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'CreateUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'firstN')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'lastN')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'createUser'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'firstName'),
                    value: VariableNode(name: NameNode(value: 'firstN'))),
                ArgumentNode(
                    name: NameNode(value: 'lastName'),
                    value: VariableNode(name: NameNode(value: 'lastN'))),
                ArgumentNode(
                    name: NameNode(value: 'userType'),
                    value: EnumValueNode(name: NameNode(value: 'UserQA')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'userType'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'lastName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'firstName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'middleName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'CreateUser';

  @override
  final CreateUserArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  CreateUser$Mutation parse(Map<String, dynamic> json) =>
      CreateUser$Mutation.fromJson(json);
}

class GetCallsQuery extends GraphQLQuery<GetCalls$Query, JsonSerializable> {
  GetCallsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'GetCalls'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'allCalls'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'callID'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'id'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
                FieldNode(
                    name: NameNode(value: 'localAddress'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'remoteAddress'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'callState'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'GetCalls';

  @override
  List<Object> get props => [document, operationName];
  @override
  GetCalls$Query parse(Map<String, dynamic> json) =>
      GetCalls$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetUserArguments extends JsonSerializable with EquatableMixin {
  GetUserArguments({@required this.userId, this.midName});

  @override
  factory GetUserArguments.fromJson(Map<String, dynamic> json) =>
      _$GetUserArgumentsFromJson(json);

  final String userId;

  final String midName;

  @override
  List<Object> get props => [userId, midName];
  @override
  Map<String, dynamic> toJson() => _$GetUserArgumentsToJson(this);
}

class GetUserQuery extends GraphQLQuery<GetUser$Query, GetUserArguments> {
  GetUserQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'GetUser'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'userId')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'midName')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: false),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'user'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'userID'),
                    value: VariableNode(name: NameNode(value: 'userId'))),
                ArgumentNode(
                    name: NameNode(value: 'midName'),
                    value: VariableNode(name: NameNode(value: 'midName')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'firstName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'lastName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'userType'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'middleName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'GetUser';

  @override
  final GetUserArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  GetUser$Query parse(Map<String, dynamic> json) =>
      GetUser$Query.fromJson(json);
}

class NewUserSubSubscription
    extends GraphQLQuery<NewUserSub$Subscription, JsonSerializable> {
  NewUserSubSubscription();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.subscription,
        name: NameNode(value: 'NewUserSub'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'newUser'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'channelID'),
                    value: StringValueNode(value: '0', isBlock: false))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'firstName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'lastName'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'userType'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'NewUserSub';

  @override
  List<Object> get props => [document, operationName];
  @override
  NewUserSub$Subscription parse(Map<String, dynamic> json) =>
      NewUserSub$Subscription.fromJson(json);
}
