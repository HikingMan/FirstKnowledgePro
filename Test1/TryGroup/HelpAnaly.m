//
//  HelpAnaly.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "HelpAnaly.h"
#import "TypeOneModel.h"
#import "TypeTwoModel.h"
#import "TypeThreeModel.h"

@implementation HelpAnaly

+(NSArray *)getMadeInMineSource{
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for(int i = 0;i < 9;i++){
        
        if(i%3==0){
            
            TypeOneModel *model = [[TypeOneModel alloc]init];
            model.identify = [NSString stringWithFormat:@"NumberOne+%d",i];
            model.showText = @"全都怪我，不该沉默时沉默，该勇敢时软弱，如果不是我，误会自己洒脱，让我们难过；若当初的你，和现在的我，假如重来过；倘若那天，把该说的话好好说，该体谅的不执着，如果那天我，不受情绪挑拨，让我们难过。可惜没如果";
            [array addObject:model];
            
        }else if (i%3==1){
            
            TypeTwoModel *model = [[TypeTwoModel alloc]init];
            model.count = 100+i;
            model.showText = @"Hey Jude";
            [array addObject:model];
            
        }else{
            
            TypeThreeModel *model = [[TypeThreeModel alloc]init];
            model.name = [NSString stringWithFormat:@"This is Mr.%d",i];
            model.showText = @"我的口袋有三十三块，伟大的中国要建三百年，区区的小事六年国建，小小的岛国，肮脏的台北，贪官污吏一手遮天，美丽的谎言说过多少遍，说来说去从来没实现";
            [array addObject:model];
        }
        
    }
    return array;

    
}

@end
