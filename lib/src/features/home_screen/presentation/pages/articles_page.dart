import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/core/exports.dart';
import 'package:flutter_clean_architecture/src/core/utils/constants/app_strings.dart';
import 'package:flutter_clean_architecture/src/core/utils/injections.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/domain/entities/article.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/domain/usecases/all_articles_usecase.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/presentation/bloc/articles_bloc.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/presentation/bloc/articles_event.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/presentation/bloc/articles_state.dart';
import 'package:flutter_clean_architecture/src/features/home_screen/presentation/widgets/articles_list_shimmer_widget.dart';
import 'package:flutter_clean_architecture/src/shared/presentation/widgets/tile_widget.dart';

class AritclesPage extends StatefulWidget {
  const AritclesPage({super.key});

  @override
  State<AritclesPage> createState() => _AritclesPageState();
}

class _AritclesPageState extends State<AritclesPage> with TextStyles {
  final ArticlesBloc _articlesBloc =
      ArticlesBloc(allArticlesUseCase: sl<AllArticlesUseCase>());

  List<Article> articleModelList = <Article>[];

  @override
  void initState() {
    callArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body:



      // TileWidget(
      //   isLocalImage: false,
      //   isIcon: false,
      //   isNetworkImage: true,
      //   image: "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-674010.jpg&fm=jpg",
      //   title: "Just a new title that is very long enough to go out of screen",
      //   subtitle: "Just text when lomg ",
      //   trailingText: "50000",
      //   trailingSubtitle: DateTime.now().hour.toString(),
      // ),

      BlocConsumer<ArticlesBloc, ArticlesState>(
        bloc: _articlesBloc,
        listener: (BuildContext context, ArticlesState state) {
          if (state is SuccessGetArticlesState) {
            articleModelList = state.articles;
          }
        },
        builder: (BuildContext context, ArticlesState state) {
          if (state is LoadingGetArticlesState) {
            return const ArticleListShimmerWidget();
          } else if (state is ErrorGetArticlesState) {
            return Text('Retry again ${state.message}');
          }
          if (articleModelList.isEmpty) {
            return const Text('No Articles');
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articleModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Article articleData = articleModelList[index];

                    String imageUrl = articleData.media.isNotEmpty &&
                            articleData.media.first.mediaMetadata.isNotEmpty
                        ? articleData.media.first.mediaMetadata.first.url
                        : AppStrings.noImageURL;

                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.15,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Row(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 130,
                            height: 150,
                            fit: BoxFit.fitWidth,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  articleData.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  articleData.abstract,
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void callArticles() {
    _articlesBloc.add(OnGettingArticlesEvent(period: 1));
  }
}
