
import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

abstract class ListPostState extends Equatable {

  @override
  List<Object?> get props => [];

}

class ListPostInit extends ListPostState{

}

class ListPostLoading extends ListPostState{

}

class ListPostLoaded extends ListPostState{
  final List<Post>? posts;

  ListPostLoaded({this.posts});
}

class ListPostError extends ListPostState{
  final error;
  ListPostError({this.error});
}