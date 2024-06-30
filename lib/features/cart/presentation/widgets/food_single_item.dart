import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfoody/features/cart/domain/entities/food_item_entity.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/cart_entity.dart';
import '../provider/cart_provider.dart';

class FoodSingleItem extends StatelessWidget {
  final CartEntity entity;

  const FoodSingleItem({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    final item = entity.item;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Row(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            color: Color(0xffFF6B23),
            radius: Radius.circular(8.r),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Color(0xffFFF1E9),
              ),
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    width: 50.r,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff010832),
                  ),
                ),
                Text(
                  item.description ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686868)),
                )
              ],
            ),
          )),
          SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.currentPrice.toString(),
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff02308E),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.h,
              ),
              !cartProvider.isAddedAlready(item)
                  ? GestureDetector(
                      onTap: () {
                        cartProvider.addToCart(entity);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          border: Border.all(
                            color: Color(0xffFF6B23),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        border: Border.all(
                          color: Color(0xffFF6B23),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cartProvider.removeFromCart(entity);
                            },
                            child: Icon(
                              Icons.remove,
                              size: 10.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              entity.quantity.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cartProvider.addToCart(entity);
                            },
                            child: Icon(
                              Icons.add,
                              size: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ))
        ],
      ),
    );
  }
}
