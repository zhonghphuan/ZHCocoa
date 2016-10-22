

#import "NSString+base64.h"

@implementation NSString (base64)

- (NSString *)base64Encode{
    //任务加密解密都是对二进制进行操作
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}


- (NSString *)base64Decode{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
