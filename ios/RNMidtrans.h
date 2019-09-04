
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MidtransKit/MidtransKit.h>

@interface RNMidtrans : UIViewController <RCTBridgeModule, MidtransUIPaymentViewControllerDelegate>

@end
  
