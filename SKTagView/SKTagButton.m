//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@interface SKTagButton ()

@property (nonatomic, strong) UILabel *signLabel;

@end

@implementation SKTagButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.signLabel) {
        
        [self.signLabel sizeToFit];
        
        CGSize size = self.signLabel.frame.size;
        
        CGFloat offset = 10.0;
        
        self.signLabel.frame = CGRectMake(
            self.frame.size.width - size.width - offset,
            self.frame.size.height / 2 - size.height / 2,
            size.width,
            size.height
        );
        
    }
}

+ (instancetype)buttonWithTag: (SKTag *)tag {
	SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
	
	if (tag.attributedText) {
		[btn setAttributedTitle: tag.attributedText forState: UIControlStateNormal];
	} else {
        
        NSString *text = tag.displaySigns ? [tag.text stringByAppendingString:@"     "] : tag.text;
       
		[btn setTitle: text forState:UIControlStateNormal];
		[btn setTitleColor: tag.textColor forState: UIControlStateNormal];
		btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize: tag.fontSize];
	}
	
	btn.backgroundColor = tag.bgColor;
	btn.contentEdgeInsets = tag.padding;
	btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	
    if (tag.bgImg) {
        [btn setBackgroundImage: tag.bgImg forState: UIControlStateNormal];
    }
    
    if (tag.borderColor) {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth) {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    if (tag.displaySigns) {
        UILabel *signLabel = [[UILabel alloc] init];
        
        signLabel.textColor = [UIColor whiteColor];
        signLabel.font = [UIFont systemFontOfSize:18];
        signLabel.text = tag.enable ? @"+" : @"-";
        
        [btn addSubview:signLabel];
        
        btn.signLabel = signLabel;
    }
    
    btn.userInteractionEnabled = tag.enable;
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

@end
