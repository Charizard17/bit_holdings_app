import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<bool> addCoin(
    String coin, String quantity, String buyPrice, String date) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(quantity);
    var price = double.parse(buyPrice);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(coin);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'Quantity': value,
          'Price': price,
          'Date': date,
        });
        return true;
      }
      double newQuantity = snapshot['Quantity'] + value;
      transaction.update(documentReference, {
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
