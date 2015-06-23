//
//  ResultViewController.h
//  Lleida.net
//
//  Created by Joan Martin on 22/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJLleidaNetResult.h"

@interface ResultViewController : UIViewController

- (id)initWithResult:(MJLleidaNetResult*)result;

@property (nonatomic, strong, readonly) MJLleidaNetResult *result;

@end
