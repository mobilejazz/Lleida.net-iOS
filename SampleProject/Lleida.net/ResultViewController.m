//
//  ResultViewController.m
//  Lleida.net
//
//  Created by Joan Martin on 22/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "ResultViewController.h"
#import "MJXMLObject+Debug.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ResultViewController

- (id)initWithResult:(MJLleidaNetResult*)result
{
    self = [super initWithNibName:@"ResultViewController" bundle:nil];
    if (self)
    {
        _result = result;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _result.action;
    
    NSString *string = [_result apx_description];
    
    self.textView.text = string;
}

@end
