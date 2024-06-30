import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfoody/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutterfoody/features/cart/presentation/widgets/food_single_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      bottomNavigationBar: Container(
        height: 170.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Color(0xffFFF1E9)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff010832)),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                      cartProvider.subTotal.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF6B23)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vat(5%) Service Charge included (5%)',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff02308E)),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                      cartProvider.vat.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff02308E)),
                    ),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff02308E)),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                      cartProvider.total.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffFF6B23)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: FutureBuilder(
            future: cartProvider.getFoodItem(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (cartProvider.foodList.isEmpty) {
                return Text('No Item Found');
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.h),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xfff7f8f9)),
                      child: Column(
                        children: [
                          Container(
                            height: 60.w,
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xffFF6B23),
                                Color(0xffFF9727)
                              ]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.r),
                                  topRight: Radius.circular(5.r)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Breakfast',
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700
                                          //height: 1,
                                          ),
                                    ),
                                    Text(
                                      'Vat(5%) Service Charge(5%)',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        height: 1,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),

                          Flexible(
                            child: Consumer<CartProvider>(
                              builder: (context, value, child) =>
                                  ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(vertical: 24.h),
                                      itemBuilder: (context, index) {
                                        final item =
                                            cartProvider.foodList[index];
                                        return FoodSingleItem(
                                          entity: item,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.r),
                                          child: Row(
                                            children: [
                                              RotatedBox(
                                                  quarterTurns: 2,
                                                  child: Icon(
                                                    Icons.linear_scale_rounded,
                                                    size: 10.sp,
                                                    color:
                                                        const Color(0xffFF6B23),
                                                  )),
                                              Expanded(
                                                  child: DottedBorder(
                                                dashPattern: [1, 3],
                                                color: Color(0xffFF6B23),
                                                padding: EdgeInsets.zero,
                                                borderType: BorderType.RRect,
                                                child: SizedBox.shrink(),
                                              )),
                                              Icon(
                                                Icons.linear_scale_rounded,
                                                size: 10.sp,
                                                color: Color(0xffFF6B23),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: cartProvider.foodList.length),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
