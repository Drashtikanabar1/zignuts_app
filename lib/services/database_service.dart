import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Authentication/auth_database.dart';







class DatabaseService {
  final Auth _auth = Auth();

  final _firebaseFirestore = FirebaseFirestore.instance;




  saveCardDetails(
      {required String cardName,
      required String vendor,
      required String programmeName,
      required String webURL,
      required String note,
      required String cardFrontURL,
      required String cardBackURL,
      required Function onSuccess,
      required Function(String) onError}) async {
    await _firebaseFirestore
        .collection("cardsOfUser")
        .doc(_auth.getUser()?.uid)
        .update({
          "loyaltyCards": FieldValue.arrayUnion([
            {
              "cardName": cardName,
              "vendor": vendor,
              "programmeName": programmeName,
              "webURL": webURL,
              "note": note,
              "cardFrontURL": cardFrontURL,
              "cardBackURL": cardBackURL
            },
          ])
        })
        .then((value) => {onSuccess()})
        .catchError((e) => {onError(e.toString())});
  }
}
