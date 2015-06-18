//
// Copyright 2015 Mobile Jazz SL
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "MJLleidaNetClient.h"

#import "MJLleidaNetResponse.h"
#import <AFNetworking/AFNetworking.h>

@implementation MJLleidaNetClient
{
    AFHTTPSessionManager *_httpSessionManager;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password
{
    self = [super init];
    if (self)
    {
        _username = username;
        _password = password;
        
        _host = @"http://api.lleida.net/sms/v1";
        
        AFHTTPRequestSerializer *requestSerializer = [[AFHTTPRequestSerializer alloc] init];
        AFXMLParserResponseSerializer *responseSerializer = [[AFXMLParserResponseSerializer alloc] init];
        
        // Setting the backend return language
        NSString *language = [[NSLocale preferredLanguages] firstObject];
        [requestSerializer setValue:language forHTTPHeaderField:@"Accept-Language"];
        
        _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_host]];
        _httpSessionManager.requestSerializer = requestSerializer;
        _httpSessionManager.responseSerializer = responseSerializer;
    }
    return self;
}

- (void)performRequest:(MJLleidaNetRequest*)request completionBlock:(MJLleidaNetResultBlock)completionBlock
{
    [self mjz_performRequest:request completionBlock:completionBlock];
}

#pragma mark Private Methods

- (void)mjz_performRequest:(MJLleidaNetRequest*)request completionBlock:(MJLleidaNetResultBlock)completionBlock
{
    NSString *xml = [request xmlWithUsername:_username password:_password];
    [self mjz_sendXML:xml completionBlock:completionBlock];
}

- (void)mjz_sendXML:(NSString*)xml completionBlock:(MJLleidaNetResultBlock)completionBlock
{
    [_httpSessionManager POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFileData:data name:@"xml" fileName:@"xml" mimeType:@"applicaiton/xml"];
        
    } success:^(NSURLSessionDataTask *task, NSXMLParser *xmlParser) {
        
        MJLleidaNetResponse *response = [[MJLleidaNetResponse alloc] init];
        xmlParser.delegate = response;
        
        [xmlParser parse];
        
        if (completionBlock)
            completionBlock(response.result, [xmlParser parserError]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completionBlock)
            completionBlock(nil, error);
    }];
}

@end

@implementation MJLleidaNetClient (API)

- (void)api_userDetailsWithCompletionBlock:(MJLleidaNetResultBlock)completionBlock
{
    MJLleidaNetUserDetailsRequest *request = [MJLleidaNetUserDetailsRequest new];
    [self performRequest:request completionBlock:completionBlock];
}

- (void)api_sendSMS:(NSString*)message phones:(NSArray*)phones completionBlock:(MJLleidaNetResultBlock)completionBlock
{
    MJLleidaNetSMSRequest *request = [MJLleidaNetSMSRequest new];
    request.text = message;
    request.recipients = phones;
    
    [self performRequest:request completionBlock:completionBlock];
}

- (void)api_stateOfMessageWithIdentifier:(NSString*)identifier completionBlock:(MJLleidaNetResultBlock)completionBlock
{
    MJLleidaNetMessageStatusRequest *request = [MJLleidaNetMessageStatusRequest new];
    request.identifier = identifier;
    
    [self performRequest:request completionBlock:completionBlock];
}

- (void)api_incomingMessagesWithCompletionBlock:(MJLleidaNetResultBlock)completionBlock
{
    MJLleidaNetIncomingMessagesRequest*request = [MJLleidaNetIncomingMessagesRequest new];
    [self performRequest:request completionBlock:completionBlock];
}

@end
