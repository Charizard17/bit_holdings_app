import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FlutterFire {
  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> deleteUser(String email, String password) async {
    try {
      User user = await _auth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credentials);
      await user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addCoin(
      String coin, String quantity, String buyPrice, String date) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var value = double.parse(quantity);
      var price = double.parse(buyPrice);
      var totalInvested = value * price;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Coins')
          .doc(coin);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({
            'TotalInvested': totalInvested,
            'Quantity': value,
            'Price': price,
            'Date': date,
          });
          return true;
        }
        double newQuantity = snapshot['Quantity'] + value;
        double newTotalInvested = snapshot['TotalInvested'] + totalInvested;
        transaction.update(documentReference, {
          'TotalInvested': newTotalInvested,
          'Quantity': newQuantity,
          'Price': price,
          'Date': date,
        });
        return true;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteCoin(String coin) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(coin);

    await documentReference
        .delete()
        .whenComplete(() => print('Coin deleted from the database'))
        .catchError((e) => print(e));
  }

  Future<bool> addSettings(String isDarkMode) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Settings')
          .doc('ThemeMode');
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({'isDarkMode': isDarkMode});
          return true;
        }
        transaction.update(documentReference, {'isDarkMode': isDarkMode});
        return true;
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
