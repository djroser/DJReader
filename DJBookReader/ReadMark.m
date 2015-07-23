//
//  ReadMark.m
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "ReadMark.h"

@implementation ReadMark


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.lastRead forKey:@"lastRead"];
    
    [aCoder encodeInteger:self.mark1 forKey:@"mark1"];
    [aCoder encodeInteger:self.mark2 forKey:@"mark2"];
    [aCoder encodeInteger:self.mark3 forKey:@"mark3"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.lastRead = [aDecoder decodeIntegerForKey:@"lastRead"];
        
        self.mark1 = [aDecoder decodeIntegerForKey:@"mark1"];
        self.mark2 = [aDecoder decodeIntegerForKey:@"mark2"];
        self.mark3 = [aDecoder decodeIntegerForKey:@"mark3"];
        
    }
    
    return self;
}

@end
