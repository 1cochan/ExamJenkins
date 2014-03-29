//
//  SendAdInfoDelegater.h
//
//

#import <Foundation/Foundation.h>
#import "Info.h"

@interface SendInfoDelegater : NSObject<NSURLConnectionDelegate>
-(void)requestAdWithNumberOfAds:(NSInteger)numberOfAds
               onCompletedBlock:(void(^)(NSInteger, NSArray*))onCompletedBlockArg;

+(void)addExcludeInfo:(Info*)info;
+(void)addExcludeInfos:(NSArray*)infos;
+(void)clearExcludeInfos;

#define CALLBACK_EXCEPTION_STS 2;
#define CALLBACK_IDX_STS 1

@end
