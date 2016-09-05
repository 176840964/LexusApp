//
//  UILabel+AttributedString.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "UILabel+AttributedString.h"

@implementation UILabel (AttributedString)
- (void)setAttributedNumberStringInContentString:(NSString *)content attributesDic:(NSDictionary *)dic {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSString *regex = @"[0-9]";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSUInteger len = 1;
    NSUInteger loc = 0;
    BOOL isHasMatch = NO;
    for (NSInteger index = 0; index < content.length; index++) {
        NSString *a = [content substringWithRange:NSMakeRange(index, 1)];
        
        if ([pred evaluateWithObject:a]) {
            isHasMatch = YES;
            len ++;
            continue;
        } else {
        }
        
        if (isHasMatch) {
            [attributeString setAttributes:dic range:NSMakeRange(loc, len - 1)];
            loc = index + 1;
            len = 1;
        }
    }
    
    self.attributedText = attributeString;
}
@end
