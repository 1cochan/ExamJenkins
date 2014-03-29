//
//  Ad.m
//  AMoAdSDK
//
//  Created by B04536 on 2014/03/19.
//
//

#import "Info.h"
#import "NSString+APUtility.h"

@implementation Info

/**
*  NSArray<Ad>を作成。
*
*  @param 返却JSONから生成したNSDictionaryが複数入った状態のNSArray。
*
*  @return <#return value description#>
*/
+(NSArray*)getFromAdsDictionaries:(NSArray*)adsJSONDictionaries{
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in adsJSONDictionaries) {
        Info *ad = [Info getFromDictionary:dic];
        [infos addObject:ad];
    }
    return [infos copy];
}
+(Info*)getFromDictionary:(NSDictionary*)dic{
//    id appKey = [dic objectForKey:LOW_LEVEL_API_JSON_KEY_appKey];
//    id image = [dic objectForKey:LOW_LEVEL_API_JSON_KEY_image]; //base64 or url
//    id appName = [dic objectForKey:LOW_LEVEL_API_JSON_KEY_appName];
//    id appText = [dic objectForKey:LOW_LEVEL_API_JSON_KEY_appText];
//    id clickURL = [dic objectForKey:LOW_LEVEL_API_JSON_KEY_clickUrl];
//    Ad *ad = [[Ad alloc] initWithAppKey:appKey imageURLString:image appName:appName appText:appText clickURL:clickURL];
    Info *ad = [[Info alloc] init];
    return ad;
}

- (id)initWithAppKey:(NSString*)appKey imageURLString:(NSString*)imageURLString appName:(NSString*)appName appText:(NSString*)appText clickURL:(NSString*)clickURL{
    self = [super init];
    if (self) {
        _appKey = appKey;
        _image = imageURLString;
        _appName = appName;
        _appText = appText;
        _url = clickURL;
        [self setImageType:imageURLString];
    }
    return self;
}
-(void)setImageType:(NSString*)value{
    //URLかどうか確認
    //値をセット
    NSURL *url = [NSURL URLWithString:value];
    if([[url scheme] isEqualToString:@"data"]){
        _imageType = AP_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING;
        return;
    }
    _imageType = AP_LOW_LEVEL_API_AD_IMAGE_TYPE_URL_STRING;
}   
-(UIImage*)getImage{
    UIImage *image;
    if([self.imageType isEqual:AP_LOW_LEVEL_API_AD_IMAGE_TYPE_BASE64_ENCODED_STRING]){
        image = [self.image imageFromBase64EncodedString];
    }else{
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.image]]];
    }
    return image;
}

@end
