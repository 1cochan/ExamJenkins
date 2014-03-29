//
//  NSString+APUtility.h
//  AMoAdSDK
//
//  Created by 足立 晃一 on 2014/03/23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (APUtility)

-(UIImage*)imageFromBase64EncodedString;
-(NSData*)dataFromBase64EncodedString;

@end
