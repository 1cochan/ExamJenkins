//
//  NSString+APUtility.m
//  AMoAdSDK
//
//  Created by 足立 晃一 on 2014/03/23.
//
//

#import "NSString+APUtility.h"

@implementation NSString (APUtility)

/**
 *  Base64のStringをNSDataに変換
 *
 *  @return <#return value description#>
 */
-(NSData*)dataFromBase64EncodedString{
    if (self.length == 0) {
        return nil;
    }
    
    //the iPhone has base 64 decoding built in but not obviously. The trick is to
    //create a data url that's base 64 encoded and ask an NSData to load it.
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self]];
    return data;
}
-(UIImage*)imageFromBase64EncodedString{
    NSData *imageData = [self dataFromBase64EncodedString];
    UIImage *myImage = [UIImage imageWithData:imageData];
    return myImage;
    
}
@end
