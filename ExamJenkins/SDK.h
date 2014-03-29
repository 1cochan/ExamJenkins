
#import <UIKit/UIKit.h>
#import "Info.h"

@interface SDK : NSObject {
}


//----------------------------------------------------------------------------------------------------
+(void)getAdWithCompletionBlock:(void(^)(NSInteger sts, Info* ad))onCompletedBlock;
+(void)getAdListWithCount:(NSInteger)count completionBlock:(void(^)(NSInteger sts, NSArray*ads))onCompletedBlock;
+(void)addExcludeInfo:(Info*)ad;
+(void)addExcludeInfos:(NSArray*)adList;
+(void)clearExcludeInfos;
+(void)clickWithAd:(Info*)ad;

@end
