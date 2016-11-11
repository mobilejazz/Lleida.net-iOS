[![Version](https://cocoapod-badges.herokuapp.com/v/Lleida.net-iOS/badge.png)](http://cocoadocs.org/docsets/Lleida.net-iOS)
[![Platform](https://cocoapod-badges.herokuapp.com/p/Lleida.net-iOS/badge.png)](http://cocoadocs.org/docsets/Lleida.net-iOS)
[![CocoaDocs](https://img.shields.io/badge/docs-%E2%9C%93-blue.svg)](http://cocoadocs.org/docsets/Hermod)
<!--- [![Build Status](https://travis-ci.org/mobilejazz/Motis.png)](https://travis-ci.org/mobilejazz/Lleida.net-iOS)-->


# Lleida.net-iOS
iOS client for Lleida.net services

## Instalation
The easiest way of installing the Lleida.net SDK is to use Cocoa Pods:
```
pod 'Lleida.net', :git => 'https://github.com/mobilejazz/Lleida.net-iOS.git'
```

## Usage
To use Lleida.net SDK you just need to configure a `MJLleidaNetClient` instance by setting the username and password;

```
MJLleidaNetClient *client = [[MJLleidaNetClient alloc] initWithUsername:@"username" password:@"password"];
```

Then, we can just call the API methods to perform any desired action. For example, if we want to send an SMS we just need to call:

```
// Array of recipients to send the SMS
NSArray *recipients = @[@"+34666778899", 
                        @"+33666554433",
                      ];
                      
// The message to send
NSString *message = @"Hello World Message".

// Sending the SMS
[client sendSMS:message phones:recipients completionBlock:^(MJLleidaNetResult *result, NSError *error) {
    if (error)
        NSLog(@"Network error: %@", error.localizedDescription),
    else if (result.status != MJLleidaNetResultStatusCorrect)
        NSLog(@"Lleida.net error: %@", result.message);
    else
        NSLog(@"All ok");
}];
```

All API methods have the same completion block, including a `MJLleidaNetResult` instance plus an `NSError`. In case of network error, the `error` instance will include all error details. Otherwise, the `result` instance will include all Lleida.net response. The `result.status` will be an indicator of the status of the requested action.

## Disclosure
This SDK has been developed by Mobile Jazz without any previous collaboration agreement with Lleida.net. Therefore, Mobile Jazz is not responsible of unexpected unreliability of the SDK with the Lleida.net API. Also, the SDK might not support all Lleida.net features as we have only included those features we need.

## License
Copyright 2015 Mobile Jazz SL

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
