import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/common/commons.dart';
import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/customButton.dart';
import '../../../../../core/widgets/customTextButton.dart';
import '../../../../task/presentation/screens/home_screen/home_screen.dart';
import '../../../data/model/on_boarding_model.dart';

class OnBoaringScreens extends StatelessWidget {
  OnBoaringScreens({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(24),
        child: PageView.builder(
          controller: controller,
          itemCount: OnBoardingModel.onBoardingScreens.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                //skip text
                index != 2
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextButton(
                          text: AppStrings.skip,
                          onPressed: () {
                            controller.jumpToPage(2);
                          },
                        ),
                      )
                    : SizedBox(
                        height: 50.h,
                      ),
                SizedBox(
                  height: 12.h,
                ),
                //image
                Image.asset(OnBoardingModel.onBoardingScreens[index].imgPath),
                SizedBox(
                  height: 12.h,
                ),

                //dots
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primary,
                    // dotColor: AppColors.red
                    dotHeight: 8.h,
                    spacing: 8.w,
                    radius: 56.r,

                    // dotWidth: 10
                  ),
                ),
                SizedBox(
                  height: 45.h,
                ),

                //title
                Text(
                  OnBoardingModel.onBoardingScreens[index].title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 20.h,
                ),

                //subTitle
                Text(
                  OnBoardingModel.onBoardingScreens[index].subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 80.h,
                ),
                //! buttons
                Row(
                  children: [
                    //! back button
                    index != 0
                        ? CustomTextButton(
                            text: AppStrings.back,
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            },
                          )
                        : Container(),
                    //! spacer
                    const Spacer(),
                    //! next Button
                    index != 2
                        ? CustomButton(
                            text: AppStrings.next,
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                          ) //! GetStarted Button
                        : CustomButton(
                            width: 163.w,
                            text: AppStrings.getStarted,
                            onPressed: () async {
                              //! navigation to home screen
                              await sl<CacheHelper>()
                                  .saveData(
                                      key: AppStrings.onBoardingKey,
                                      value: true)
                                  .then((value) {
                                print('onBoarding is Visited');
                                navigate(
                                    context: context,
                                    screen: const HomeScreen());
                              }).catchError((e) {
                                print(e.toString());
                              });
                            })
                  ],
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
