//
// Ad.h
// AMoAdSDK
//
// Created by B04536 on 2014/03/19.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Info : NSObject
@property (nonatomic, readonly) NSString *appKey;
@property (nonatomic, readonly) NSString *image;  //アイコンイメージのbase64文字列 or URL文字列
@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *appText;
@property (nonatomic, readonly) NSString *url;   //クリックURL文字列
@property (nonatomic, readonly) NSString *imageType; //base64encodedstring or url

#define AP_LOW_LEVEL_API_AD_IMAGE_TYPE_URL_STRING @"AP_LOW_LEVEL_API_AD_IMAGE_TYPE_URL_STRING"
#define AP_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING @"AP_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING"


+(NSArray*)getFromAdsDictionaries:(NSArray*)adsJSONDictionaries;
+(Info*)getFromDictionary:(NSDictionary*)dic;
-(UIImage*)getImage;

@end
