//
//  BookCell.m
//  DJBookReader
//
//  Created by user on 15/7/20.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:@"BookCell" owner:nil options:nil];
        
        if (arrayOfViews.count < 1) {
            return nil;
        }
        
        if (! [arrayOfViews[0] isKindOfClass:[BookCell class]]) {
            return nil;
        }
        
        self = arrayOfViews[0];
    }
    
    return self;
}

@end
