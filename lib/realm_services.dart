import 'package:agroeconomicos/usuario.dart';
import 'package:realm/realm.dart';
import 'package:flutter/material.dart';

class RealmServices with ChangeNotifier {
  static const String queryAllName = "getAllItemsSubscription";
  static const String queryMyItemsName = "getMyItemsSubscription";

  bool showAll = false;
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    if (app.currentUser != null || currentUser != app.currentUser) {
      currentUser ??= app.currentUser;
      realm = Realm(
          Configuration.flexibleSync(currentUser!, [Usuario.schema])); //[]
      showAll = (realm.subscriptions.findByName(queryAllName) != null);
      if (realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<void> updateSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      if (showAll) {
        mutableSubscriptions.add(realm.all<Usuario>(), name: queryAllName);
      } else {
        mutableSubscriptions.add(
            realm.query<Usuario>(r'owner_id == $0', [currentUser?.id]),
            name: queryMyItemsName);
      }
    });
    await realm.subscriptions.waitForSynchronization();
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      realm.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        notifyListeners();
        realm.syncSession.resume();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> switchSubscription(bool value) async {
    showAll = value;
    if (!offlineModeOn) {
      try {
        isWaiting = true;
        notifyListeners();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  void createItem(String nombre, String usuario) {
    final newItem = Usuario(ObjectId(), nombre, usuario, currentUser!.id);
    realm.write<Usuario>(() => realm.add<Usuario>(newItem));
    notifyListeners();
  }

  void deleteItem(Usuario item) {
    realm.write(() => realm.delete(item));
    notifyListeners();
  }

  Future<void> updateItem(Usuario item,
      {String? summary, bool? isComplete}) async {
    realm.write(() {
      if (summary != null) {
        //Usuario.summary = summary;
      }
      if (isComplete != null) {
        //Usuario.isComplete = isComplete;
      }
    });
    notifyListeners();
  }

  Future<void> close() async {
    if (currentUser != null) {
      await currentUser?.logOut();
      currentUser = null;
    }
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
