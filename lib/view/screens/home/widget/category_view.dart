import 'package:flutter/material.dart';
import 'package:flutter_restaurant/helper/responsive_helper.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/category_provider.dart';
import 'package:flutter_restaurant/provider/splash_provider.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/utill/routes.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/base/title_widget.dart';
import 'package:flutter_restaurant/view/screens/category/category_screen.dart';
import 'package:flutter_restaurant/view/screens/home/widget/category_pop_up.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 23, 0, 10),
              child:
                  TitleWidget(title: getTranslated('all_categories', context)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 95,
                  child: category.categoryList != null
                      ? category.categoryList.length > 0
                          ? GridView.builder(
                              itemCount: category.categoryList.length,
                              padding: EdgeInsets.only(
                                  left: Dimensions.PADDING_SIZE_SMALL),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String _name = '';
                                category.categoryList[index].name.length > 15
                                    ? _name = category.categoryList[index].name
                                            .substring(0, 20) +
                                        ' ...'
                                    : _name = category.categoryList[index].name;
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.PADDING_SIZE_DEFAULT),
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      Routes.getCategoryRoute(
                                          category.categoryList[index].id),
                                      arguments: CategoryScreen(
                                          categoryModel:
                                              category.categoryList[index]),
                                    ), // arguments:  category.categoryList[index].name),
                                    child: Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 4,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                Images.placeholder_image,
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.cover,
                                            image: Provider.of<SplashProvider>(
                                                            context,
                                                            listen: false)
                                                        .baseUrls !=
                                                    null
                                                ? '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/${category.categoryList[index].image}'
                                                : '',
                                            imageErrorBuilder: (c, o, s) =>
                                                Image.asset(
                                                    Images.placeholder_image,
                                                    width: 65,
                                                    height: 65,
                                                    fit: BoxFit.cover),
                                            // width: 100, height: 100, fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Flexible(
                                        child: Text(
                                          _name,
                                          style: rubikMedium.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                            )
                          : Center(
                              child: Text(getTranslated(
                                  'no_category_available', context)))
                      : CategoryShimmer(),
                ),
                ResponsiveHelper.isMobile(context)
                    ? SizedBox()
                    : category.categoryList != null
                        ? Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (con) => Dialog(
                                          child: Container(
                                              height: 550,
                                              width: 600,
                                              child: CategoryPopUp())));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.PADDING_SIZE_SMALL),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Text(
                                        getTranslated('view_all', context),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : CategoryAllShimmer(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled:
                  Provider.of<CategoryProvider>(context).categoryList == null,
              child: Column(children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: Colors.grey[300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: Provider.of<CategoryProvider>(context).categoryList == null,
          child: Column(children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}
