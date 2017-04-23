//
//  DetailsViewController.h
//  demo
//
//  Created by fendywu on 19/04/2017.
//  Copyright © 2017 fendywu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataResult.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) MyData *data;
@property (strong, nonatomic) NSArray<MyData*> *others;
@end
