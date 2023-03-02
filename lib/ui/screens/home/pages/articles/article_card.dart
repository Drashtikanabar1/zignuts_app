import 'package:firstapp/model/model_aritical.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
   ArticleCard({super.key,required this.article});
  Data article;
  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: const EdgeInsets.only(right: 20,left:20,top: 20),
      child: Card(
           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          child: SizedBox(
            
            height: 135,
            width:Dimensions.screenWidth,
            child: Row(
              children: [
                Expanded(
                  
                  flex: 1,
                  child: ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),),
                    child: Image.network(article.jetpackFeaturedMediaUrl ?? "",height: 150,width: 120,fit: BoxFit.cover,)),
                ),
               
                
               Expanded(
                flex: 3,
                 child: Column(
                  children: [
                     Container(
                      width :380,
                      padding: const EdgeInsets.only(top: 10,left: 3),
                      child: Text(article.primaryCategory?.name ??  " ",),
                    ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 3),
                    child:   Text(article.title?.rendered ?? ""),),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(onPressed: ()async{
                          final Uri url=Uri.parse(article.canonicalUrl ?? "");
                          if(!await launchUrl(url,
                          mode: LaunchMode.externalApplication)){
                             throw Exception('Could not launch $url');
                          }
                          }, child:const Text("Get More Info",
                                style: TextStyle(color: Colors.green, fontSize: 15)
                                ),),
                    )
                  ],
                   
                 ),

                
               ),
             

              ],
            ),
          ),
       
      ),
    );
  }
}