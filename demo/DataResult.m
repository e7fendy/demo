//
//  DataResult.m
//  demo
//
//  Created by fendywu on 18/04/2017.
//  Copyright © 2017 fendywu. All rights reserved.
//

#import "DataResult.h"

@implementation MyData
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DataResultInfo
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DataResult
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
