//
//  ResultViewController.m
//  Lleida.net
//
//  Created by Joan Martin on 22/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "ResultViewController.h"

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
    
    NSString *string = [_result apx_descriptionWithIndentationLevel:0];
//    string = [string stringByReplacingOccurrencesOfString:@"\"<null>\"" withString:@"null"];
//    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
//    string = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
//
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//    
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *prettyJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    self.textView.text = string;
}

@end
