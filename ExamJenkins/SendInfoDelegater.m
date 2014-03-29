//
//  SendAdInfoDelegater.m

#import "SendInfoDelegater.h"

/**
 *  ARCのソースとして作成。
 */
@implementation SendInfoDelegater{
    id receiveData;
    NSInteger status;
    void(^onCompletedBlock)(NSInteger, NSArray*);
    NSURLConnection *conn;
}
static NSMutableDictionary *_excludeApps;

- (id)init{
    self = [super init];
    if (self) {
        receiveData = nil;
        if(!_excludeApps){
            _excludeApps = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

#pragma mark 除外リスト
//----------------------------------------------------------------------------------------------------
+(void)addExcludeInfo:(Info*)info{
    [_excludeApps setObject:info forKey:info.appKey];
}
+(void)addExcludeInfos:(NSArray*)infos{
    for (Info *ad in infos) {
        [SendInfoDelegater addExcludeInfo:ad];
    }
}
+(void)clearExcludeInfos{
    [_excludeApps removeAllObjects];
}
/**
 *  除外リストをカンマ区切りに連結して返す
 *
 *  @return 
 */
+(NSString*)excludeAppKeys2NSString{
    NSString *ret = @"";
    for (NSString *appKey in _excludeApps) {
        if(ret.length > 0){
            ret = [ret stringByAppendingString:@","];
        }
        ret = [ret stringByAppendingString:appKey];
    }
    return ret;
}
//----------------------------------------------------------------------------------------------------
/**
 *  広告要求リクエスト実行
 *
 *  @param numberOfAds         要求広告数
 *  @param excludeAppKeys      除外AppKey
 *  @param onCompletedBlock    完了時ブロック。NSInteger statusコード, NSArray AdのArray
 */
-(void)requestAdWithNumberOfAds:(NSInteger)numberOfAds
               onCompletedBlock:(void(^)(NSInteger, NSArray*))onCompletedBlockArg{
    
    // 接続中の場合は終了
    if (receiveData) {
        return;
    }

    onCompletedBlock = onCompletedBlockArg;
    receiveData = [NSMutableData data];
    
    //	タイムアウト設定あり
    NSString *excludeAppKeys = [SendInfoDelegater excludeAppKeys2NSString];
    NSString *urlString = @"https://dl.dropboxusercontent.com/u/180622001/ad.json"; //TODO:消すこと
//    NSLog(@"%@", urlString);
	conn = [NSURLConnection connectionWithRequest:
            [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3.0] delegate:self];
}

#pragma mark NSURLConnectionDelegate
//----------------------------------------------------------------------------------------------------
/**
 *  response受信時
 *
 *  @param connection
 *  @param response   
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//	DLOG(@"--- didReceiveResponse:status=[%ld]", (long)status);
	status = [(NSHTTPURLResponse *)response statusCode];
}
/**
 *  データ受信(途中)
 *
 *  @param connection
 *  @param data
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//	DLOG(@"--- didReceiveData");
	[receiveData appendData:data];
}
/**
 *  通信異常時
 *
 *  @param connection
 *  @param error
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//	DLOG(@"--- Server Receive NG. [%ld]", (long)[error code]);
    
	// サーバからの受信データ(JSON形式)をパースする
	NSError *JsonErr;
	NSDictionary *recvData = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingAllowFragments error:&JsonErr];
    
    //ステータスコード取得
	NSInteger resSts;
	@try {
		resSts = [self extractedResponseStatusCode:error jsonDictionary:recvData];
	} @catch (NSException *exception){
//		DLOG(@"--- Exception[%@:%ld]", [exception description], (long)[error code]);
		resSts = CALLBACK_EXCEPTION_STS;
	}
    
    receiveData = nil;
    
	if (!onCompletedBlock){
        return;
    }
    // アプリ側へcallback（空のNSArrayを返却)
    onCompletedBlock(CALLBACK_IDX_STS, [[NSArray alloc] init]);
}

/**
 *  (すべてのデータを)受信完了
 *
 *  @param connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//	DLOG(@"--- Server Receive OK.[%ld]", (long)status);
    
	// サーバからの受信データ(JSON形式)をパースする
	NSError *JsonErr;
	NSDictionary *recvData = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingAllowFragments error:&JsonErr];

	NSInteger resSts = 1;
    
    //TODO_DONE:Adクラス組み立て
//    NSArray *infoDic = [recvData objectForKey:LOW_LEVEL_API_JSON_KEY_ads];
//    NSArray *info = [Ad getFromAdsDictionaries:infoDic];
    NSArray *infos = @[[[Info alloc] init]];

    receiveData = nil;
    onCompletedBlock(resSts, infos);
}

#pragma mark Utility
//----------------------------------------------------------------------------------------------------
/**
 *  戻ってきたJSONからstatusコードを取り出す
 *
 *  @param error
 *  @param recvData
 *
 *  @return
 */
-(NSInteger)extractedResponseStatusCode:(NSError *)error jsonDictionary:(NSDictionary *)jsonDictionary{
    NSInteger resSts;
//    if (error.code == AP_HTTP_STATUS_SUCCESSFUL_OK) {
//        resSts = [[jsonDictionary objectForKey:LOW_LEVEL_API_JSON_KEY_STATUS] integerValue];
//    } else {
//        resSts = [error code];
//    }
    return resSts;
}
@end
