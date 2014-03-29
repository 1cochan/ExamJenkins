
#import "SDK.h"
#import "SendInfoDelegater.h"

@implementation SDK


//----------------------------------------------------------------------------------------------------
//情報を一つ取得
+(void)getAdWithCompletionBlock:(void(^)(NSInteger sts, Info*))onCompletedBlock{
    [SDK getAdListWithCount:1 completionBlock:^(NSInteger sts, NSArray *ads) {
        onCompletedBlock(sts, [ads firstObject]);
    }];
}
//情報を複数取得
+(void)getAdListWithCount:(NSInteger)count completionBlock:(void(^)(NSInteger sts, NSArray* ads))onCompletedBlock{
    __block SendInfoDelegater *delegator = [[SendInfoDelegater alloc] init];
    id delegateCompletedBlock = ^(NSInteger sts, NSArray *ads){
        onCompletedBlock(sts, ads);
    };
    [delegator requestAdWithNumberOfAds:count onCompletedBlock:delegateCompletedBlock];
}

//除外関係
//----------------------------------------------------------------------------------------------------
//除外Info登録（一つだけ）
+(void)addExcludeInfo:(Info*)ad{
    [SendInfoDelegater addExcludeInfo:ad];
}
//除外Info登録（複数）
+(void)addExcludeInfos:(NSArray*)ads{
    [SendInfoDelegater addExcludeInfos:ads];
}
//除外Info解除
+(void)clearExcludeInfos{
    [SendInfoDelegater clearExcludeInfos];
}

//クリック時
//----------------------------------------------------------------------------------------------------
+(void)clickWithAd:(Info*)ad{
    NSURL *clickURL = [NSURL URLWithString:ad.url];
    [[UIApplication sharedApplication] openURL:clickURL];
}
@end
