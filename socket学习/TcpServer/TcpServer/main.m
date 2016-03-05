#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //        1
        int err;
        int fd=socket(AF_INET, SOCK_STREAM  , 0);
        BOOL success=(fd!=-1);
        //        1
        //   2
        if (success) {
            NSLog(@"socket success");
            struct sockaddr_in addr;
            memset(&addr, 0, sizeof(addr));
            addr.sin_len=sizeof(addr);
            addr.sin_family=AF_INET;
            //            =======================================================================
            addr.sin_port=htons(1024);
            //        ============================================================================
            addr.sin_addr.s_addr=INADDR_ANY;
            err=bind(fd, (const struct sockaddr *)&addr, sizeof(addr));
            success=(err==0);
        }
        //   2
        //        ============================================================================
        if (success) {
            NSLog(@"bind(绑定) success");
            err=listen(fd, 5);//开始监听
            success=(err==0);
        }
        //    ============================================================================
        //3
        if (success) {
            NSLog(@"listen success");
            while (true) {
                struct sockaddr_in peeraddr;
                int peerfd;
                socklen_t addrLen;
                addrLen=sizeof(peeraddr);
                NSLog(@"prepare accept");
                peerfd=accept(fd, (struct sockaddr *)&peeraddr, &addrLen);
                success=(peerfd!=-1);
                //    ============================================================================
                if (success) {
                    NSLog(@"accept success,remote address:%s,port:%d",inet_ntoa(peeraddr.sin_addr),ntohs(peeraddr.sin_port));
                    char buf[1024];
                    ssize_t count;
                    size_t len=sizeof(buf);
                    do {
                        count=recv(peerfd, buf, len, 0);
                        NSString* str = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
                        NSLog(@"%@",str);
                    } while (strcmp(buf, "exit")!=0);
                }
                //    ============================================================================
                close(peerfd);
            }
        }
        //3
    }
    return 0;
}
