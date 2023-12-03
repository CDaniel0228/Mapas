import 'package:realm/realm.dart';

part 'usuario.g.dart';

@RealmModel()
class _Usuario {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String nombres;
  @MapTo('apodo')
  late String usuario;
  @MapTo('owner_id')
  late String ownerId;
}
