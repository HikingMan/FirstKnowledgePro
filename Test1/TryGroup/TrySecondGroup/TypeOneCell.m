//
//  TypeOneCell.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TypeOneCell.h"
#import "TrySecondModelProtocol.h"
#import "TypeOneModel.h"


@implementation TypeOneCell


-(void)reloadCellWithSource:(id<TrySecondModelProtocol>)sourceModel{
    
    TypeOneModel *model = sourceModel;
    
    [self.opOneBut setTitle:model.identify forState:UIControlStateNormal];
    
    self.opOneLabel.text = [sourceModel showText];
    
    CGRect rect = self.opOneLabel.frame;
    rect.size.height = [sourceModel getLableHeightWith:sourceModel];
    self.opOneLabel.frame = rect;
    
    if(model.oneIsTap){
        
        self.opOneBut.backgroundColor = [UIColor whiteColor];
    }else{
        
        self.opOneBut.backgroundColor = [UIColor redColor];
    }
    
}
- (IBAction)butClicked:(id)sender {

    if(self.block){
        self.block(sender);
    }
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
