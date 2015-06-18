//
//  MJLleidaNetIncomingMessage.h
//  Lleida.net
//
//  Created by Joan Martin on 18/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "MJXMLObject.h"

@interface MJLleidaNetIncomingMessage : MJXMLObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *recipient;
@property (nonatomic, strong) NSString *text;

@end
