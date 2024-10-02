import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/search/defult.dart';
import 'package:fruitshub/search/search_bloc.dart';
import 'package:fruitshub/search/search_builder.dart';

class MySearchController extends StatefulWidget {
  const MySearchController({
    super.key,
    required this.query,
  });

  final String query;

  @override
  State<MySearchController> createState() => _MySearchControllerState();
}

class _MySearchControllerState extends State<MySearchController> {
  late String token;

  void getToken() async {
    token = await SharedPrefManager().getData('token');
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<SearchCubit, Search>(
          builder: (context, state) {
            if (state is SearchDefult) {
              return Defult(query: widget.query);
            } else if (state is SearchError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    backgroundColor: Color.fromARGB(255, 243, 99, 89),
                    content: Text(
                      'خطأ ، ادخل النص في مربع البحث ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              });
              state = SearchDefult();
              return Defult(query: widget.query);
            } else if (widget.query == '') {
              return Defult(query: widget.query);
            } else {
              return SearchBuilder(
                query: widget.query,
                token: token,
              );
            }
          },
        ),
      ),
    );
  }
}
