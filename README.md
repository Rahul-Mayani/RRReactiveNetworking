# RRReactiveNetworking

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/Rahul-Mayani/RRReactiveNetworking/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/PagingTableView.svg?style=flat)](https://github.com/Rahul-Mayani/RRReactiveNetworking/tree/master/RRReactiveNetworking/)


Managing Nested Asynchronous Callbacks in Objective-C using ReactiveCocoa by AFNetworking


## Requirements

**Use of the following Cocoapods is required**: 

- [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- [ReactiveObjC](https://github.com/ReactiveCocoa/ReactiveObjC)


## Installation

#### Manually
1. Download the project.
2. Add `RRApiManager.h` & `RRApiManager.m`  with necessary files in your project.
3. Congratulations!  

## Usage example

A **RACSignal** should wrap an operation with an asynchronous callback block.

The last signal to run should call subscribeNext for receiving output values. If no output values are available, subscribeNext can be replaced by subscribeCompleted or subscribeError.

Any intermediate step is defined by **flattenMap**. The parameter in flattenMap corresponds to the data from the next signal. It also takes a return value, which is the subsequent signal to run. The two signals are written top-down and are executed top-down.

We don’t want to strongly retain self: in ARC, we introduce **__weak**. Also, the extra square brackets at start and end are ugly in Objective-C’s implementation of functional reactive programming.

```Objective-C

@weakify(self);

NSDictionary *param = @{@"key": @"test"};
[[[[[RRApiManagerShared postAPICallURL:API_URL header:nil param:param]
flattenMap:^(id responseOfPostAPI) {
    NSLog(@"%@",responseOfPostAPI);
    return [RRApiManagerShared getAPICallURL:API_URL header:nil];
}]
subscribeOnBackgroundAndDeliverOnMainThread]
subscribeNext:^(id responseGetAPI) {
    NSLog(@"%@",responseGetAPI);
} error:^(NSError * error) {
    NSLog(@"%@",error.localizedDescription);
}] rac_deallocDisposable];

```

To run the project, clone the repo, and run pod install from the RRReactiveNetworking directory first.

## Contribute 

We would love you for the contribution to **RRReactiveNetworking**, check the ``LICENSE`` file for more info.


## License

[RRReactiveNetworking](https://github.com/Rahul-Mayani/RRReactiveNetworking/tree/master/RRReactiveNetworking/) is available under the MIT license. See the [LICENSE](https://github.com/Rahul-Mayani/RRReactiveNetworking/blob/master/LICENSE) file for more info.
