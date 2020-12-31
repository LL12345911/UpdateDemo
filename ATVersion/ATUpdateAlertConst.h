//
//  ATUpdateAlertConst.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

/** RGB */
#define SELColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** 屏幕高度 */
#define SCREEN1_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN1_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN1_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

/** 入场出场动画时间 */
UIKIT_EXTERN const CGFloat SELAnimationTimeInterval;

/** 更新内容显示字体大小 */
UIKIT_EXTERN const CGFloat SELDescriptionFont;

/** 更新内容最大显示高度 */
UIKIT_EXTERN const CGFloat SELMaxDescriptionHeight;
