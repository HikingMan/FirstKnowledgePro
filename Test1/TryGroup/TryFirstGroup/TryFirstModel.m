//
//  TryFirstModel.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TryFirstModel.h"
#import "NetWorkManager.h"

@implementation TryFirstModel

+(void)getSourceDataWithCompleteHandle:(void (^)(NSArray *, BOOL, NSError *))block{
    
    [[NetWorkManager shareManager] getDataWithUrl:@"https://www.baidu.com" parameters:@{} result:^(id result) {
       
        if(result!=nil){
            //解析数据生成model，最后生成数据源
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for(int i=0 ; i<3 ; i++){
                
                TryFirstModel * model = [TryFirstModel new];
                model.headPicUrl = [NSString stringWithFormat:@"这是图片%d",i];
                model.detailInfo = [NSString stringWithFormat:@"这里是第%d条",i];
                if(i==1){
                    model.detailInfo=@"叫我怎么能不难过，你劝我灭了心中的火，我还能怎么说，怎么说都是错；你对我说，如果要我，把心对你解剖，我会说我愿意做，我受够了寂寞，只是，爱要怎么说出口，我的心里好难受，如果能将你拥有，我会忍住不让眼泪流，每一次握你的手，指尖传来你的温柔";
                }
                model.isOperated = i%2;
                
                [array addObject:model];
            }
            if(block){
                block(array,YES,nil);
            }
            
        }
        
        
    }];
    
    
    
}
+(void)changeOperationState:(TryFirstModel *)model CompleteHandle:(void (^)(TryFirstModel *, BOOL, NSError *))block{
    
    [[NetWorkManager shareManager] getDataWithUrl:@"http://www.sina.com.cn/" parameters:@{@"state":[NSNumber numberWithBool:model.isOperated]} result:^(id result) {
        if(result!=nil){
            
            model.isOperated =!model.isOperated;
            
            if(block){
                block(model,YES,nil);
            }
        }
    }];
    
    
}
//类似于cell的高度处理都要在model里面
+(CGFloat)getCellHeightWithInfo:(TryFirstModel *)model{
    
    if(!model.isOperated){
        return 20;
    }else{
        CGSize size = [model.detailInfo boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        return size.height>=20?size.height:20;
    }
    
}
@end
