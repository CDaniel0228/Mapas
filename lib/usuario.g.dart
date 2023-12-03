// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Usuario extends _Usuario with RealmEntity, RealmObjectBase, RealmObject {
  Usuario(
    ObjectId id,
    String nombres,
    String usuario,
    String ownerId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'nombres', nombres);
    RealmObjectBase.set(this, 'apodo', usuario);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  Usuario._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get nombres => RealmObjectBase.get<String>(this, 'nombres') as String;
  @override
  set nombres(String value) => RealmObjectBase.set(this, 'nombres', value);

  @override
  String get usuario => RealmObjectBase.get<String>(this, 'apodo') as String;
  @override
  set usuario(String value) => RealmObjectBase.set(this, 'apodo', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<Usuario>> get changes =>
      RealmObjectBase.getChanges<Usuario>(this);

  @override
  Usuario freeze() => RealmObjectBase.freezeObject<Usuario>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Usuario._);
    return const SchemaObject(ObjectType.realmObject, Usuario, 'Usuario', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('nombres', RealmPropertyType.string),
      SchemaProperty('usuario', RealmPropertyType.string, mapTo: 'apodo'),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }
}
