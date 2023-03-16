

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pattern_bloc/bloc/list_post_state.dart';
import 'package:flutter_pattern_bloc/service/https_service.dart';

import '../models/post_model.dart';


class ListPostCubit extends Cubit<ListPostState>{
  ListPostCubit() : super(ListPostInit());

  void apiPostList() async{
    emit(ListPostLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
      emit(ListPostLoaded(posts: Network.parsePostList(response)));
    }else{
      emit(ListPostError(error: "Ciuld not fetch posts"));
    }
  }

  void apiPostDelete(Post post) async{
    emit(ListPostLoading());
    final response = await Network.DELETE(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if(response != null){
      apiPostList();
    }else{
      emit(ListPostError(error: "Ciuld not deklete posts"));
    }
  }
}