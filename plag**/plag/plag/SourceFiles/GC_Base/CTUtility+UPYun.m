//
//  CTUtility(UPYun).m
//  XF_BusinessCard
//
//  Created by MaYing on 15/1/26.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "CTUtility+UPYun.h"

@implementation  CTUtility(UPYun)
+(void)uploadFileToUP:(NSString *)filePath newFileName:(NSString *) newFileName successBlock:(void (^)(void))successBlock errorBlock:(void (^)(void))errorBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        if(upyun_global_init() == UPYUN_RET_OK)
        {
            upyun_config_t conf = {0};
            conf.user = UPYUN_USERNAME;
            conf.passwd = UPYUN_PASWWORD;
            conf.endpoint = UPYUN_ED_AUTO;//网络类型
            conf.debug = 0;
            //
            upyun_t* u = upyun_create(&conf);
            //设置超时
            upyun_set_timeout(u,60);
            //
            const char * filePath_c = [filePath UTF8String];
            
            upyun_content_t content = {0};
            content.type = UPYUN_CONTENT_FILE;
            content.u.fp = fopen(filePath_c, "rb");
            
            struct stat file_stat;
            stat(filePath_c, &file_stat);
            
            content.len = file_stat.st_size;;
            content.md5 = 1;
            
            upyun_upload_info_t upload_info = {0};
            int status = 0;
            NSString * targetFilePath = [NSString stringWithFormat:@"/%s/%@",UPYUN_BUCKET,newFileName];
            upyun_ret_e ret = upyun_upload_file(u, [targetFilePath UTF8String], &content, NULL, &upload_info, &status);
            fclose(content.u.fp);
            upyun_destroy(u);
            upyun_global_cleanup();
            
            if(ret == UPYUN_RET_OK && status == 200)
            {
                if(successBlock)
                {
                    successBlock();
                }
            }
            else
            {
                if(errorBlock)
                {
                    errorBlock();
                }
            }
        }
        //
        
    });
}
@end
