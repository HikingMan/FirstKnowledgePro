//
//  TryFirstTableViewCell.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TryFirstTableViewCell.h"



@interface TryFirstTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *operaBut;


@end


@implementation TryFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)operaClicked:(id)sender {
    
    if(self.block){
        self.block(sender);
    }
}

- (void) reloadCellWithSource:(TryFirstModel *)sourceModel{
    
    self.headImage.backgroundColor = [UIColor redColor];
    
    self.detailLabel.text = sourceModel.detailInfo;
    
    [self.operaBut setTitle:sourceModel.isOperated?@"已操作":@"未操作" forState:UIControlStateNormal];
    
    CGFloat detailHeight = [TryFirstModel getCellHeightWithInfo:sourceModel];
    
    CGRect rect = self.detailLabel.frame;
    
    rect.size.height = detailHeight;
    
    self.detailLabel.frame = rect;
    
    self.detailLabel.backgroundColor = [UIColor redColor];
    if(sourceModel.isOperated){
        self.detailLabel.numberOfLines = 0;
    }else{
        self.detailLabel.numberOfLines = 1;
    }
    
    [self layoutSubviews];
}

@end
