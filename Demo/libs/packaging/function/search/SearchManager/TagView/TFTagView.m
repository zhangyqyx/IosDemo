//
//  TFTagView.m
//  TFSearch
//
//  Created by 张永强 on 2018/3/2.
//  Copyright © 2018年 zhangyq. All rights reserved.
//

#import "TFTagView.h"



#define TFTagMaxCol 3
#define TFTextColor TF_COLOR(113, 113, 113)
#define TFTagBgColor [UIColor TF_getColor:@"#fafafa"]
#define TFPolRandomColor self.colorPol[arc4random_uniform((uint32_t)self.colorPol.count)]
#define TF_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

@interface TFTagView()

/** 随机的颜色 */
@property (nonatomic , strong)NSArray *colorPol;
/** 存放label数组 */
@property (nonatomic , strong)NSMutableArray *labelArr;


@end


@implementation TFTagView



- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

- (NSArray *)colorPol {
    if (!_colorPol) {
        NSArray *colorStrPol = @[@"009999", @"0099cc", @"0099ff", @"00cc99", @"00cccc", @"336699", @"3366cc", @"3366ff", @"339966", @"666666", @"666699", @"6666cc", @"6666ff", @"996666", @"996699", @"999900", @"999933", @"99cc00", @"99cc33", @"660066", @"669933", @"990066", @"cc9900", @"cc6600" , @"cc3300", @"cc3366", @"cc6666", @"cc6699", @"cc0066", @"cc0033", @"ffcc00", @"ffcc33", @"ff9900", @"ff9933", @"ff6600", @"ff6633", @"ff6666", @"ff6699", @"ff3366", @"ff3333"];
        NSMutableArray *colorPolM = [NSMutableArray array];
        for (NSString *colorStr in colorStrPol) {
            UIColor *color = [UIColor TF_getColor:colorStr];
            [colorPolM addObject:color];
        }
        _colorPol = colorPolM.copy;
    }
    return _colorPol;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
       
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

- (void)initialization {
    self.tagHeight = 30;
    self.tagRadius = 5;
    self.tagType = TFTagViewStyleDefault;
    self.tagTextColor = TFTextColor;
    self.tagBgColor = TFTagBgColor;
    self.tagTextFont = [UIFont systemFontOfSize:13];
    self.tagSpace = 15;
    self.tagsRankBackgroundColorHexStrings = @[@"#f14230", @"#ff8000", @"#ffcc01", @"#ebebeb"];
    self.tagsRectangMaxCol = 3;
}

- (void)TF_addAndLayoutTags {
    if (self.tagsArr.count == 0) return;
    if (self.tagType == TFTagViewStyleRank) {
        [self setupHRankTags];
        return;
    }
    if (self.tagType == TFTagViewStyleRectang) {
        [self setupRectangTags];
        return;
    }
    [self setupNormalTags];
    self.tagType = self.tagType;
}
- (void)setupNormalTags {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < self.tagsArr.count; i++) {
        UILabel *label = [self createLabelWithTitle:self.tagsArr[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [self.labelArr addObject:label];
    }
    [self setupSubViewLayout];
}
- (void)setupSubViewLayout {
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    for (int i = 0 ; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if (![view isKindOfClass:[UILabel class]]) continue;
        UILabel *subLabel = (UILabel *)view;
        if (subLabel.TF_viewWidth > self.TF_viewWidth) {
            subLabel.TF_viewWidth = self.TF_viewWidth;
        }
        if (currentX + subLabel.TF_viewWidth + self.tagSpace * countRow > self.TF_viewWidth ) {
            subLabel.TF_viewX = 0;
            subLabel.TF_viewY = (currentY += subLabel.TF_viewHeight) + self.tagSpace * ++countCol;
            currentX = subLabel.TF_viewWidth;
            countRow = 1;
            continue;
        }
        subLabel.TF_viewX = (currentX += subLabel.TF_viewWidth) - subLabel.TF_viewWidth + self.tagSpace * countRow;
        subLabel.TF_viewY = currentY + self.tagSpace * countCol;
        countRow ++;
    }
    self.TF_viewHeight = CGRectGetMaxY(self.subviews.lastObject.frame);
}
- (void)setupHRankTags {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *rankTextLabelsM = [NSMutableArray array];
    NSMutableArray *rankTagM = [NSMutableArray array];
    NSMutableArray *rankViewM = [NSMutableArray array];
    for (int i = 0; i < self.tagsArr.count; i++) {
        UIView *rankView = [[UIView alloc] init];
        rankView.TF_viewHeight = self.tagHeight;
        rankView.TF_viewWidth = (self.TF_viewWidth - self.tagSpace * 3) * 0.5;
        rankView.TF_viewX = (self.tagSpace + rankView.TF_viewWidth) * (i % 2);
        rankView.TF_viewY = rankView.TF_viewHeight * (i / 2);
        rankView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // rank tag
        UILabel *rankTag = [[UILabel alloc] init];
        rankTag.textAlignment = NSTextAlignmentCenter;
        rankTag.font = [UIFont systemFontOfSize:10];
        rankTag.layer.cornerRadius = 3;
        rankTag.clipsToBounds = YES;
        rankTag.text = [NSString stringWithFormat:@"%d", i + 1];
        [rankTag sizeToFit];
        rankTag.TF_viewWidth = rankTag.TF_viewHeight += 5;
        rankTag.TF_viewY = (rankView.TF_viewHeight - rankTag.TF_viewHeight) * 0.5;
        [rankView addSubview:rankTag];
        [rankTagM addObject:rankTag];
        // rank text
        UILabel *rankTextLabel = [[UILabel alloc] init];
        rankTextLabel.text = self.tagsArr[i];
        rankTextLabel.userInteractionEnabled = YES;
        [rankTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        rankTextLabel.textAlignment = NSTextAlignmentLeft;
        rankTextLabel.backgroundColor = [UIColor clearColor];
        rankTextLabel.textColor = self.tagTextColor;
        rankTextLabel.font = [UIFont systemFontOfSize:14];
        rankTextLabel.TF_viewX = CGRectGetMaxX(rankTag.frame) + self.tagSpace;
        rankTextLabel.TF_viewWidth = (self.TF_viewWidth - self.tagSpace * 3) * 0.5 - rankTextLabel.TF_viewX;
        rankTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        rankTextLabel.TF_viewHeight = rankView.TF_viewHeight;
        [rankTextLabelsM addObject:rankTextLabel];
        [rankView addSubview:rankTextLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TagView.bundle/cell-content-line"]];
        line.TF_viewHeight = 0.5;
        line.alpha = 0.7;
        line.TF_viewX = - self.TF_viewWidth * 0.5;
        line.TF_viewY = rankView.TF_viewHeight - 1;
        line.TF_viewWidth = self.TF_viewWidth;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [rankView addSubview:line];
        [rankViewM addObject:rankView];
        [self addSubview:rankView];
        // set tag's background color and text color
        switch (i) {
            case 0: // NO.1
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = [UIColor TF_getColor:self.tagsRankBackgroundColorHexStrings[0]];
              
                break;
            case 1: // NO.2
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = [UIColor TF_getColor:self.tagsRankBackgroundColorHexStrings[1]];
                
                break;
            case 2: // NO.3
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = [UIColor TF_getColor:self.tagsRankBackgroundColorHexStrings[2]];
                break;
            default: // Other
                rankTag.backgroundColor = [UIColor TF_getColor:self.tagsRankBackgroundColorHexStrings[3]];
                rankTag.textColor = self.tagTextColor;
                break;
        }
    }
    self.labelArr = rankTextLabelsM;
    UIView * lastView = rankViewM.lastObject;
    self.TF_viewHeight = CGRectGetMaxY(lastView.frame);
    
}
- (void)setupRectangTags {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.labelArr = [NSMutableArray array];
    CGFloat rectangleTagH = self.tagHeight;
    for (int i = 0; i < self.tagsArr.count; i++) {
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = [UIFont systemFontOfSize:14];
        rectangleTagLabel.textColor = self.tagTextColor;
        rectangleTagLabel.backgroundColor = [UIColor clearColor];
        rectangleTagLabel.text = self.tagsArr[i];
        rectangleTagLabel.TF_viewWidth = self.TF_viewWidth / self.tagsRectangMaxCol;
        rectangleTagLabel.TF_viewHeight = rectangleTagH;
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        rectangleTagLabel.TF_viewX = rectangleTagLabel.TF_viewWidth * (i %  self.tagsRectangMaxCol);
        rectangleTagLabel.TF_viewY = rectangleTagLabel.TF_viewHeight * (i /  self.tagsRectangMaxCol);
        [self addSubview:rectangleTagLabel];
        [self.labelArr addObject:rectangleTagLabel];
    }
    self.TF_viewHeight = CGRectGetMaxY(self.subviews.lastObject.frame);
    for (int i = 0; i < self.tagsRectangMaxCol - 1; i++) {
        UIImageView *verticalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TagView.bundle/cell-content-line-vertical"]];
        verticalLine.TF_viewHeight = self.TF_viewHeight;
        verticalLine.alpha = 0.7;
        verticalLine.TF_viewX = self.TF_viewWidth / self.tagsRectangMaxCol * (i + 1);
        verticalLine.TF_viewWidth = 0.5;
        [self addSubview:verticalLine];
    }
    
    for (int i = 0; i < ceil(((double)self.tagsArr.count / self.tagsRectangMaxCol)); i++) {
        UIImageView *verticalLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TagView.bundle/cell-content-line"]];
        verticalLine.TF_viewHeight = 0.5;
        verticalLine.alpha = 0.7;
        verticalLine.TF_viewY = rectangleTagH * (i + 1) - 0.5;
        verticalLine.TF_viewWidth = self.TF_viewWidth;
        [self addSubview:verticalLine];
    }
}

- (UILabel *)createLabelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = self.tagTextFont;
    label.text = title;
    label.textColor = self.tagTextColor;
    label.backgroundColor = self.tagBgColor;
    label.layer.cornerRadius = self.tagRadius;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.TF_viewWidth += 20;
    label.TF_viewHeight += 14;
    [self addSubview:label];
    return label;
}

#pragma mark - 标签点击
- (void)tagDidCLick:(UITapGestureRecognizer *)gr {
    UILabel *label = (UILabel *)gr.view;
    if ([self.delegate respondsToSelector:@selector(TFTagViewClick:tagLabel:index:text:)]) {
        [self.delegate TFTagViewClick:self tagLabel:label index:[self.labelArr indexOfObject:label] text:label.text];
    }
}
- (void)setTagHeight:(CGFloat)tagHeight {
    _tagHeight = tagHeight;
    if (self.tagType == TFTagViewStyleRank) {
        [self setupHRankTags];
        return;
    }
    if (self.tagType == TFTagViewStyleRectang) {
        [self setupRectangTags];
        return;
    }
    for (UILabel *tag in self.labelArr) {
        tag.TF_viewHeight = tagHeight;
    }
}

- (void)setTagsRankBackgroundColorHexStrings:(NSArray *)tagsRankBackgroundColorHexStrings {
    _tagsRankBackgroundColorHexStrings = tagsRankBackgroundColorHexStrings;
    if (self.tagType != TFTagViewStyleRank) return;
    [self setupHRankTags];
}

- (void)setTagsRectangMaxCol:(int)tagsRectangMaxCol {
    _tagsRectangMaxCol = tagsRectangMaxCol;
    if (self.tagType != TFTagViewStyleRectang) return;
     [self setupRectangTags];
}


- (void)setTagType:(TFTagViewType)tagType {
    _tagType = tagType;
    if (tagType == TFTagViewStyleDefault) return;
    if (tagType == TFTagViewStyleColor) {
        for (UILabel *tag in self.labelArr) {
            tag.textColor = [UIColor whiteColor];
            tag.backgroundColor = TFPolRandomColor;
        }
        return;
    }
    if (tagType == TFTagViewStyleBorder) {
        for (UILabel *tag in self.labelArr) {
            tag.backgroundColor = [UIColor clearColor];
            tag.layer.borderColor = TF_COLOR(223, 223, 223).CGColor;
            tag.layer.borderWidth = 0.5;
        }
        return;
    }
    if (tagType == TFTagViewStyleRank || tagType == TFTagViewStyleRectang) {
        [self TF_addAndLayoutTags];
        return;
    }
}
- (void)setTagSpace:(CGFloat)tagSpace {
    _tagSpace = tagSpace;
    if (self.tagType == TFTagViewStyleRank) {
        [self setupHRankTags];
        return;
   }
  if (self.tagType == TFTagViewStyleRectang) return;
  [self setupSubViewLayout];
}
- (void)setTagRadius:(CGFloat)tagRadius {
    _tagRadius = tagRadius;
    for (UILabel *tag in self.labelArr) {
        tag.layer.cornerRadius = tagRadius;
    }
}
- (void)setTagBgColor:(UIColor *)tagBgColor {
    _tagBgColor = tagBgColor;
    for (UILabel *tag in self.labelArr) {
        tag.backgroundColor = tagBgColor;
    }
}
- (void)setTagTextFont:(UIFont *)tagTextFont {
    _tagTextFont = tagTextFont;
    for (UILabel *tag in self.labelArr) {
        tag.font = tagTextFont;
    }
}
- (void)setTagTextColor:(UIColor *)tagTextColor {
    _tagTextColor = tagTextColor;
    for (UILabel *tag in self.labelArr) {
        tag.textColor = tagTextColor;
    }
}

- (void)setTagsArr:(NSArray *)tagsArr {
    _tagsArr = tagsArr;
    if (tagsArr.count == 0) return;
    
    [self TF_addAndLayoutTags];
}




@end
