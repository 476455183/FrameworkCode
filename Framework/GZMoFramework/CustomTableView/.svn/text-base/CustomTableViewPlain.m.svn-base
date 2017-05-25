//
//  CustomTableViewPlain.m
//  GZMoFramework
//
//  Created by mojx on 16/7/19.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomTableViewPlain.h"
#import "GZPublicMethod.h"

//tableview展示的数据类型
enum TableView_Data_Type
{
    DataType_Text = 0,//只显示文本数据
    DataType_Image_Text = 1,//图片和文本数据均显示
    DataType_AttributedText = 2,//显示带有属性化的文本数据
    DataType_Image_TwoText = 3,//图片和文本数据均显示，文本数据两种形式显示
};

@interface CustomTableViewPlain ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *attributeDictionary1;
    NSDictionary *attributeDictionary2;
    UIFont *textFont_;
    UIColor *textColor_;
    UIFont *titleFont_, *subTitleFont_;
    UIColor *titleColor_, *subTitleColor_;
    NSInteger cellHieght_;
    NSInteger cellHieghtOffset_;
    CGSize imageSize_;
    CGFloat cornerRadius_;
    
    /** tableview展示的数据类型*/
    enum TableView_Data_Type tableView_dataType;
}

@end

@implementation CustomTableViewPlain

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        /* 添加子控件的代码
         在重新构造方法的时候,我们只需要把控件放进去,暂时先不用考虑他们在什么位置,而是在layoutSubViews方法里面布局子控件
         */
        self.myTableView = [[UITableView alloc]init];
        self.myTableView.dataSource = self;
        self.myTableView.delegate = self;
        //一句话解决所有TableView的多余cell
        [self.myTableView setTableFooterView:[[UIView alloc]init]];
        [self addSubview:self.myTableView];
        
        //解决cell设置imageView时分割线短15像素的处理
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    return self;
}

//在layoutSubViews方法里面布局子控件
- (void)layoutSubviews
{
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.myTableView.frame = CGRectMake(0, 0, width, height);
}

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       标题字体颜色
 *  @param valueColor       value字体颜色
 *  @param font             字体
 *  @param spacing          段间距
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array titleColor:(UIColor *)titleColor valueColor:(UIColor *)valueColor font:(UIFont *)font spacing:(CGFloat)spacing cellHieghtOffset:(NSInteger)cellHieghtOffset
{
    if (array.count < 1)
    {
        self.dataMArray = [[NSMutableArray alloc]init];
        [self.myTableView reloadData];
        return;
    }
    tableView_dataType = DataType_AttributedText;
    [self initAttributeDictionary: font titleColor:titleColor valueColor:valueColor spacing:spacing];
    
    self.dataMArray = [[NSMutableArray alloc]init];
    textFont_ = font;
    cellHieghtOffset_ = cellHieghtOffset;
    
    for (int i=0; i< array.count; i++)
    {
        NSMutableAttributedString *mabstrings = [[NSMutableAttributedString alloc]init];
        NSMutableDictionary *dic = [array objectAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%@\r\n",[dic objectForKey:@"title"]];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary1];
        [mabstrings appendAttributedString:attrString];
        str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"value"]];
        attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary2];
        [mabstrings appendAttributedString:attrString];
        
        [self.dataMArray addObject:mabstrings];
    }

    [self.myTableView reloadData];
}

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param titleColor       主标题字体颜色
 *  @param titleFont        主标题字体
 *  @param subTitleColor    子标题字体颜色
 *  @param subTitleFont     子标题字体
 *  @param spacing          段间距
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array
      titleColor:(UIColor *)titleColor
       titleFont:(UIFont *)titleFont
   subTitleColor:(UIColor *)subTitleColor
    subTitleFont:(UIFont *)subTitleFont
         spacing:(CGFloat)spacing
       imageSize:(CGSize)imageSize
    cornerRadius:(CGFloat)cornerRadius
cellHieghtOffset:(NSInteger)cellHieghtOffset
{
    if (array.count < 1 || cornerRadius < 0)
    {
        self.dataMArray = [[NSMutableArray alloc]init];
        [self.myTableView reloadData];
        return;
    }
    tableView_dataType = DataType_Image_TwoText;
    
    [self initAttributeDictionary2:titleColor titleFont:titleFont subTitleColor:subTitleColor subTitleFont:subTitleFont spacing:spacing];
    self.dataMArray = [[NSMutableArray alloc]init];
    for (int i=0; i<array.count; i++)
    {
        NSMutableAttributedString *mabstrings = [[NSMutableAttributedString alloc]init];
        NSMutableDictionary *dic = [array objectAtIndex:i];
        NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
        NSString *str = [NSString stringWithFormat:@"%@\r\n",[dic objectForKey:@"title"]];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary1];
        [mabstrings appendAttributedString:attrString];
        str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sub_title"]];
        attrString = [[NSAttributedString alloc] initWithString:str attributes:attributeDictionary2];
        [mabstrings appendAttributedString:attrString];
        
        [dic2 setObject:mabstrings forKey:@"value"];
        [dic2 setObject:[dic objectForKey:@"image"] forKey:@"image"];
        [self.dataMArray addObject:dic2];
    }
    
    imageSize_ = imageSize;
    cornerRadius_ = cornerRadius;
    textFont_ = titleFont;
    titleFont_ = titleFont;
    subTitleFont_ = subTitleFont;
    titleColor_ = titleColor,
    subTitleColor_ = subTitleColor;
    cellHieghtOffset_ = cellHieghtOffset;
    [self.myTableView reloadData];
}

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param color            颜色
 *  @param font             字体大小
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array color:(UIColor *)color font:(UIFont *)font cellHieghtOffset:(NSInteger)cellHieghtOffset
{
    if (array.count < 1)
    {
        self.dataMArray = [[NSMutableArray alloc]init];
        [self.myTableView reloadData];
        return;
    }
    tableView_dataType = DataType_Text;
    self.dataMArray = array;
    textFont_ = font;
    textColor_ = color;
    cellHieghtOffset_ = cellHieghtOffset;
    [self.myTableView reloadData];
}

/**
 *  初始化数据
 *
 *  @param array            数据
 *  @param color            颜色
 *  @param font             字体大小
 *  @param imageSize        cell图片大小
 *  @param cornerRadius     cell图片圆角半径
 *  @param cellHieghtOffset cell偏置高度
 */
- (void)initData:(NSMutableArray *)array color:(UIColor *)color font:(UIFont *)font imageSize:(CGSize)imageSize cornerRadius:(CGFloat)cornerRadius cellHieghtOffset:(NSInteger)cellHieghtOffset
{
    if (array.count < 1 || cornerRadius < 0)
    {
        self.dataMArray = [[NSMutableArray alloc]init];
        [self.myTableView reloadData];
        return;
    }
    tableView_dataType = DataType_Image_Text;
    self.dataMArray = array;
    imageSize_ = imageSize;
    cornerRadius_ = cornerRadius;
    textFont_ = font;
    textColor_ = color;
    cellHieghtOffset_ = cellHieghtOffset;
    [self.myTableView reloadData];
}

/**
 *  插入数据
 *
 *  @param object 数据
 *  @param index  索引位置
 */
- (void)insertData:(id)object index:(NSInteger)index
{
    if (self.dataMArray)
        [self.dataMArray insertObject:object atIndex:index];
}

#pragma mark - 数据源方法
#pragma mark 一共有多少组（section == 区域\组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 第section组一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMArray.count;
}

#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = self.accessoryType;
    cell.selectionStyle = self.selectionStyle;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.numberOfLines = 0;
    if (tableView_dataType == DataType_AttributedText)
    {
        cell.textLabel.attributedText = self.dataMArray[indexPath.row];
    }
    else if (tableView_dataType == DataType_Text)
    {
        cell.textLabel.text = self.dataMArray[indexPath.row];
        cell.textLabel.font = textFont_;
        cell.textLabel.textColor = textColor_;
    }
    else if (tableView_dataType == DataType_Image_Text)
    {
        NSMutableDictionary *dic = [self.dataMArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [dic objectForKey:@"value"];
        cell.textLabel.font = textFont_;
        cell.textLabel.textColor = textColor_;
        
        //设置image
        cell.imageView.layer.cornerRadius = cornerRadius_;//imageSize_.width/2;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.image = [GZPublicMethod scaleToSize:[dic objectForKey:@"image"] newsize:imageSize_];
    }
    else if (tableView_dataType == DataType_Image_TwoText)
    {
        NSMutableDictionary *dic = [self.dataMArray objectAtIndex:indexPath.row];
        cell.textLabel.attributedText = [dic objectForKey:@"value"];
        
        //设置image
        cell.imageView.layer.cornerRadius = cornerRadius_;//imageSize_.width/2;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.image = [GZPublicMethod scaleToSize:[dic objectForKey:@"image"] newsize:imageSize_];
    }
    
    return cell;
}

#pragma mark 设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFixedCellHeight)//固定cell高度
        return self.fixedCellHeight;
    
    if (tableView_dataType == DataType_AttributedText)
    {
        NSMutableAttributedString *mabstrings = self.dataMArray[indexPath.row];
        CGSize text_size = [GZPublicMethod sizeWithString:mabstrings.string font:textFont_ maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
        return text_size.height + cellHieghtOffset_;
    }
    else if (tableView_dataType == DataType_Text)
    {
        NSString *text = self.dataMArray[indexPath.row];
        CGSize text_size = [GZPublicMethod sizeWithString:text font:textFont_ maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
        return text_size.height + cellHieghtOffset_;
    }
    else if (tableView_dataType == DataType_Image_Text)
    {
        NSMutableDictionary *dic = [self.dataMArray objectAtIndex:indexPath.row];
        NSString *text = [dic objectForKey:@"value"];
        CGSize text_size = [GZPublicMethod sizeWithString:text font:textFont_ maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
        if (text_size.height > imageSize_.height)
            return text_size.height + cellHieghtOffset_;
        else
            return imageSize_.height + cellHieghtOffset_;
    }
    else if (tableView_dataType == DataType_Image_TwoText)
    {
        NSMutableDictionary *dic = [self.dataMArray objectAtIndex:indexPath.row];
        NSMutableAttributedString *mabstrings = [dic objectForKey:@"value"];
        CGSize text_size = [GZPublicMethod sizeWithString:mabstrings.string font:textFont_ maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
        if (text_size.height > imageSize_.height)
            return text_size.height + cellHieghtOffset_;
        else
            return imageSize_.height + cellHieghtOffset_;
    }
    return 44;
}

#pragma mark 选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.deselectRowAnimated)
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    [self.selectRowDelegate tableViewPlainDidSelectRowAtIndexPath:indexPath dataArray:self.dataMArray];
}

//初始化属性字典
-(void)initAttributeDictionary:(UIFont *)font titleColor:(UIColor *)titleColor valueColor:(UIColor *)valueColor spacing:(CGFloat)spacing
{
    //字体
    //UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    //段落
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = NSTextAlignmentCenter;//设置对齐方式
    ps.lineSpacing = 5.0;//行间距
    //ps.paragraphSpacing = 2;//段间距
    
    //颜色
    UIColor *color = titleColor;//[UIColor blackColor];
    //属性字典
    attributeDictionary1 = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
    
    //段落
    ps.alignment = NSTextAlignmentLeft;//设置对齐方式
    ps.lineSpacing = 5.0;//行间距
    ps.paragraphSpacing = spacing;//段间距
    //颜色
    color = valueColor;//[UIColor darkGrayColor];
    //属性字典
    attributeDictionary2 = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
}

//初始化属性字典
-(void)initAttributeDictionary2:(UIColor *)titleColor titleFont:(UIFont *)titleFont subTitleColor:(UIColor *)subTitleColor subTitleFont:(UIFont *)subTitleFont spacing:(CGFloat)spacing
{
    //字体
    //UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    //段落
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.alignment = NSTextAlignmentCenter;//设置对齐方式
    ps.lineSpacing = 5.0;//行间距
    //ps.paragraphSpacing = 2;//段间距
    
    //颜色
    UIColor *color = titleColor;//[UIColor blackColor];
    //属性字典
    attributeDictionary1 = @{NSFontAttributeName: titleFont, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
    
    //段落
    ps.alignment = NSTextAlignmentLeft;//设置对齐方式
    ps.lineSpacing = 5.0;//行间距
    ps.paragraphSpacing = spacing;//段间距
    //颜色
    color = subTitleColor;//[UIColor darkGrayColor];
    //属性字典
    attributeDictionary2 = @{NSFontAttributeName: subTitleFont, NSParagraphStyleAttributeName:ps, NSForegroundColorAttributeName:color};
}

@end
