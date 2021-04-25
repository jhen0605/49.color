//
//  CALayer+CALayer_borderColor.m
//  color
//
//  Created by 簡吟真 on 2021/4/25.
//

#import "CALayer+CALayer_borderColor.h"
#import <UIKit/UIKit.h>
@implementation CALayer (borderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
 self.borderColor = color.CGColor;
}
@end
