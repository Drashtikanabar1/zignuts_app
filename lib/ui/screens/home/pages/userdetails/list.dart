
import 'package:firstapp/controller/random_provider.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/response/customer_randomuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/network_cubit.dart';



class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
   RandomProvider? randomProvider;
   ModelCustomrRequest? user;
   bool isUser=false;
  randomuser()async{
    isUser =true;
    ModelCustomrResponse result = await randomProvider!.getRandomuser();
    
     
    if(isUser){
        setState(() {
       user = result.results?.first;
     }); 

    }
    setState(() {
      
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
 
    randomProvider = Provider.of<RandomProvider>(context);
    randomProvider!.networkCubit ??= BlocProvider.of<NetworkCubit>(context);
    if(!isUser){
      randomuser();
    }
   
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:EdgeInsets.only(top:200,left: 30),
          child: Center(
            child: Column(
              children: [
                user?.picture?.large ==null ?
                Placeholder(
                  child:Image.asset(ImageAssets.imageplacholder) ,
                )
             
                :Image.network(user?.picture?.large  ?? ""  ,alignment: Alignment.center,height: 200,width: 180,fit: BoxFit.cover,),
                Text("${user?.name?.title ?? ""} ${user?.name?.first ?? ""} ${user?.name?.last ?? ""}"),
                 Text("${user?.gender ?? ""}" ),
                 Text("${user?.dob?.age ?? ""}"),
                 
              
              ],
            ),
          ),
        ),
      ),
    )
  ;
  }
}