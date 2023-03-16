import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_post_cubit.dart';
import '../bloc/create_post_state.dart';
import '../models/post_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context, "result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Post"),
        ),
        body: BlocBuilder<CreatePostCubit, CreatePostState>(
          builder: (BuildContext context, CreatePostState state) {
            if (state is CreatePostLoading) {
              return viewOfCreate(true, context, titleController, bodyController);
            }
            if (state is CreatePostLoaded) {
              _finish(context);
            }
            if (state is CreatePostError) {}
            return viewOfCreate(false, context, titleController, bodyController);
          },
        ),
      ),
    );
  }

  Widget viewOfCreate(bool isLoading, BuildContext context,
      TextEditingController titleController,
      TextEditingController bodyController) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Stack(
        children: [
          Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Title", hintStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                    hintText: "Body", hintStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  String title = titleController.text.toString();
                  String body = bodyController.text.toString();
                  Post post = Post(title: title,body: body,userId: 1);
                  BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
                },
                color: Colors.blue,
                child: Text(
                  "Create a Post",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
