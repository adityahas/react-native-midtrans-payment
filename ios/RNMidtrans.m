
#import "RNMidtrans.h"
#import <React/RCTLog.h>

@interface RNMidtrans ()
@property (nonatomic, copy) RCTResponseSenderBlock callback;
@end

@implementation RNMidtrans

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(checkOut : (NSDictionary*) optionConect
                  : (NSDictionary*) transRequest
                  : (NSArray*) items
                  : (NSDictionary*) creditCardOptions
                  : (NSDictionary*) mapUserDetail
                  : (NSDictionary*) optionColorTheme
                  : (NSDictionary*) optionFont
                  : (RCTResponseSenderBlock)callback){

    [CONFIG setClientKey:[optionConect valueForKey:@"clientKey"]
             environment:[optionConect valueForKey:@"sandbox"] ? MidtransServerEnvironmentSandbox : MidtransServerEnvironmentProduction
       merchantServerURL:[optionConect valueForKey:@"urlMerchant"]];

    NSMutableArray *itemitems = [[NSMutableArray alloc] init];
    for (NSDictionary *ele in items) {
        MidtransItemDetail *tmp =
        [[MidtransItemDetail alloc] initWithItemID:[ele valueForKey:@"id"]
                                              name:[ele valueForKey:@"name"]
                                             price:[ele valueForKey:@"price"]
                                          quantity:[ele valueForKey:@"qty"]];
        [itemitems addObject:tmp];
    }

    MidtransAddress *shippingAddress = [MidtransAddress addressWithFirstName:[mapUserDetail valueForKey:@"fullName"]
                                                                    lastName:@""
                                                                       phone:[mapUserDetail valueForKey:@"phoneNumber"]
                                                                     address:[mapUserDetail valueForKey:@"address"]
                                                                        city:[mapUserDetail valueForKey:@"city"]
                                                                  postalCode:[mapUserDetail valueForKey:@"zipcode"]
                                                                 countryCode:[mapUserDetail valueForKey:@"country"]];
    MidtransAddress *billingAddress = [MidtransAddress addressWithFirstName:[mapUserDetail valueForKey:@"fullName"]
                                                                    lastName:@""
                                                                       phone:[mapUserDetail valueForKey:@"phoneNumber"]
                                                                     address:[mapUserDetail valueForKey:@"address"]
                                                                        city:[mapUserDetail valueForKey:@"city"]
                                                                  postalCode:[mapUserDetail valueForKey:@"zipcode"]
                                                                 countryCode:[mapUserDetail valueForKey:@"country"]];

    MidtransCustomerDetails *customerDetail =
    [[MidtransCustomerDetails alloc] initWithFirstName:[mapUserDetail valueForKey:@"fullName"]
                                              lastName:@"lastname"
                                                 email:[mapUserDetail valueForKey:@"email"]
                                                 phone:[mapUserDetail valueForKey:@"phoneNumber"]
                                       shippingAddress:shippingAddress
                                        billingAddress:billingAddress];

    NSNumber *totalAmount = [NSNumber numberWithInt:[[transRequest valueForKey:@"totalAmount"] intValue]];
    MidtransTransactionDetails *transactionDetail =
    [[MidtransTransactionDetails alloc] initWithOrderID:[transRequest valueForKey:@"transactionId"]
                                         andGrossAmount:totalAmount];
    
    self.callback = callback;

    [[MidtransMerchantClient shared]
     requestTransactionTokenWithTransactionDetails:transactionDetail
     itemDetails:itemitems
     customerDetails:customerDetail
     completion:^(MidtransTransactionTokenResponse * _Nullable token, NSError *_Nullable error) {
         if (token) {
             UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

             MidtransUIPaymentViewController *vc = [[MidtransUIPaymentViewController alloc] initWithToken:token];

             [ctrl presentViewController:vc animated:NO completion:nil];
             // set the delegate
             vc.paymentDelegate = self;
         }
         else {
             callback(@[error.localizedDescription, [NSNull null]]);
         }
     }];
};

#pragma mark - MidtransUIPaymentViewControllerDelegate
- (void)finishPayment:(MidtransTransactionResult *)result error:(NSError *)error
{
    if (self.callback == nil) {
        return;
    }
    
    if (error) {
        self.callback(@[error]);
    } else if (result) {
        self.callback(@[result.transactionStatus, [NSNull null]]);
    } else {
        self.callback(@[@"cancelled", [NSNull null]]);
    }
    
    self.callback = nil;
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentSuccess:(MidtransTransactionResult *)result{
    RCTLogInfo(@"%@", result);
    [self finishPayment:result error:nil];
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentFailed:(NSError *)error {
    RCTLogInfo(@"%@", error);
    [self finishPayment:nil error:error];
}

- (void)paymentViewController:(MidtransUIPaymentViewController *)viewController paymentPending:(MidtransTransactionResult *)result {
    RCTLogInfo(@"%@", result);
    [self finishPayment:result error:nil];
}

- (void)paymentViewController_paymentCanceled:(MidtransUIPaymentViewController *)viewController {
    RCTLogInfo(@"Cancel Transaction");
    [self finishPayment:nil error:nil];
}
@end
