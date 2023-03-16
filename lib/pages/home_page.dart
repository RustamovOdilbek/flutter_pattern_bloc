import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pattern_bloc/bloc/list_post_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../bloc/list_post_state.dart';
import '../models/post_model.dart';
import '../service/https_service.dart';
import '../service/log_service.dart';
import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC"),
      ),
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (BuildContext context, ListPostState state) {
          if (state is ListPostError) {
            return viewOfHome(items, false);
          }
          if (state is ListPostLoaded) {
            items = state.posts!;
            return viewOfHome(items!, false);
          }

          return viewOfHome(items, true);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget viewOfHome(List<Post> items, bool isLoading) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(ctx, items[index]);
          },
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
