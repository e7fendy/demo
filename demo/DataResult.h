//
//  DataResult.h
//  demo
//
//  Created by fendywu on 18/04/2017.
//  Copyright © 2017 fendywu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MyData <NSObject>
@end
@interface MyData : JSONModel
@property (strong, nonatomic) NSString *Image;
@property (strong, nonatomic) NSString *Introduction;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *OpenTime;
@property (strong, nonatomic) NSString *ParkName;
@property (strong, nonatomic) NSString *YearBuilt;
@property (strong, nonatomic) NSString *_id;
@end

@interface DataResultInfo :JSONModel
@property (assign, nonatomic) long long count;
@property (assign, nonatomic) long long limit;
@property (assign, nonatomic) long long offset;
@property (strong, nonatomic) NSString *sort;
@property (strong, nonatomic) NSArray<MyData*><MyData> *results;
@end

@interface DataResult : JSONModel
@property (strong, nonatomic) DataResultInfo *result;
@end
