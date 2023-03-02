import 'package:firstapp/controller/%20article_controller.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/home/pages/articles/article_card.dart';
import 'package:flutter/material.dart';

import '../../../../../services/check_connection.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleContoller articleContoller = ArticleContoller();
  bool isConnection =false;
   checkConnectivity() async {
    isConnection = await CheckConnection.checkInternetConnection();
    setState(() {
      isConnection;
    });
   }

  @override
  void initState() {
    checkConnectivity();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isConnection ? FutureBuilder(
        future: articleContoller.getArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.data?.length,
              itemBuilder: (context, index) {
                dynamic article = snapshot.data?.data?.elementAt(index);
                return ArticleCard(article: article);
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          // By default show a loading spinner.
          return const CircularProgressIndicator();
        }): Center(
            child: Container(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.network_cell_sharp,
                      size: 40, color: ColorManager.grey),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "No Internet Connecion. Please check your settings and try again.",
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () => checkConnectivity(),
                      child: const Text("Retry"))
                ],
              ),
            ),
        );
  }
}
