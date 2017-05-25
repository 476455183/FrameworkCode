//
//  CustomTableViewGrouped.m
//  GZMoFramework
//
//  Created by mojx on 16/8/18.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "CustomTableViewGrouped.h"
#import "GZPublicMethod.h"

@interface CustomTableViewGrouped ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    /** 是否显示登录，YES显示，NO不显示*/
    BOOL isShowLogin;
}

@end

@implementation CustomTableViewGrouped

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
        //self.myTableView = [[UITableView alloc]init];
        self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.myTableView.dataSource = self;
        self.myTableView.delegate = self;
        //一句话解决所有TableView的多余cell
        [self.myTableView setTableFooterView:[[UIView alloc]init]];
        [self addSubview:self.myTableView];
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
    //NSLog(@"%d",self.isShowLogin);
}

/**
 *  初始化数据
 *
 *  @param dataArr 数据
 */
- (void)initData:(NSMutableArray *)dataArr
{
    dataArray = dataArr;
    [self.myTableView reloadData];
}

/**
 *  初始化登录数据，特有的，只有账号、密码、登录三个数据
 */
- (void)initLoginData
{
    // 设置数据
    dataArray = [[NSMutableArray alloc]init];
    self.accountInfoDic = [[NSMutableDictionary alloc]init];
    isShowLogin = YES;
    
    //添加手势
    //[self.myTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit:)]];
    
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit:)];
    [tap setNumberOfTapsRequired:1];
    //解决UITapGestureRecognizer手势与UITableView的点击事件的冲突
    tap.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.myTableView addGestureRecognizer:tap];
    
    //0
    NSMutableArray *group = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"账号：" forKey:@"value"];
    [group addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"密码：" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    //1
    group = [[NSMutableArray alloc]init];
    dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"登录" forKey:@"value"];
    [group addObject:dic];
    [dataArray addObject:group];
    
    [self.myTableView reloadData];
}

#pragma mark - 数据源方法
#pragma mark 一共有多少组（section == 区域\组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

#pragma mark 第section组一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = dataArray[section];
    return array.count;
}

#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = self.accessoryType;//UITableViewCellAccessoryDisclosureIndicator;
    
    NSMutableArray *array = dataArray[indexPath.section];
    NSMutableDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"value"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    
    if (self.isShowImage && !isShowLogin)
    {
        //设置image
        CGSize newsize = CGSizeMake(30, 30);
        if (indexPath.section == 0 && self.isShowHeadImage)
        {
            cell.accessoryType = self.headImageAccessoryType;//UITableViewCellAccessoryNone;
            newsize = CGSizeMake(60, 60);
            cell.imageView.layer.cornerRadius = 30;
            cell.imageView.layer.masksToBounds = YES;
        }
        cell.imageView.image = [GZPublicMethod scaleToSize:[dic objectForKey:@"image"] newsize:newsize];
    }
    else if (isShowLogin)
    {
        if (indexPath.section == 0)
        {
            CGFloat offset = 0;
            if (self.isShowAccountIcon)
            {
                offset = 45;
                //设置image
                CGSize newsize = CGSizeMake(30, 30);
                if (indexPath.row == 0)//账号
                    cell.imageView.image = [GZPublicMethod scaleToSize:[self.accountInfoDic objectForKey:@"name_image"] newsize:newsize];
                else if (indexPath.row == 1)//密码
                    cell.imageView.image = [GZPublicMethod scaleToSize:[self.accountInfoDic objectForKey:@"password_image"] newsize:newsize];
            }
            
            CGRect frame = CGRectMake(60 + offset, 12, self.frame.size.width - 80 - offset, 20);
            UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.font = [UIFont systemFontOfSize:15];
            textfield.delegate = self;
            textfield.tag = indexPath.section * 100 + indexPath.row;
            
            if (indexPath.row == 0)//账号
            {
                textfield.text = [self.accountInfoDic objectForKey:@"name"];
                textfield.placeholder = @"请输入账号";
            }
            else if (indexPath.row == 1)//密码
            {
                textfield.text = [self.accountInfoDic objectForKey:@"password"];
                textfield.secureTextEntry = YES;
                textfield.placeholder = @"请输入密码";
            }
            //添加textfield值改变时的监视事件
            [textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            [cell addSubview:textfield];
        }
        else if (indexPath.section == dataArray.count - 1)
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

#pragma mark 设置行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFixedCellHeight)//是否固定cell高度
        return self.fixedCellHeight;
    
    if (indexPath.section == 0 && self.isShowHeadImage && !isShowLogin)
        return 90;
    return 44;
}

#pragma mark section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
#pragma mark section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark 选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    [self.selectRowDelegate tableViewGroupedDidSelectRowAtIndexPath:indexPath dataArray:dataArray];
    if (isShowLogin && indexPath.section == 1 && indexPath.row == 0)
    {
        [self.selectRowDelegate tableViewGroupedLoginDidSelectRowAtIndexPath:indexPath dataArray:dataArray accountInfo:self.accountInfoDic];
    }
}

//截获所点击的视图，并决定是否手势继续向下响应: 解决UITapGestureRecognizer手势与UITableView的点击事件的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]])
    {
        return NO;
    }
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}


#pragma mark ---UITextFieldDelegate

//textfield值改变时的监视事件
-(void)textFieldDidChange:(UITextField *)textField
{
    //NSLog(@"textfield: %@; tag: %ld", textField.text, textField.tag);
    
    NSInteger section = textField.tag / 100;
    NSInteger row = textField.tag - section * 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    //设置账号、密码
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)//账号
            [self.accountInfoDic setObject:textField.text forKey:@"name"];
        else if (indexPath.row == 1)//密码
            [self.accountInfoDic setObject:textField.text forKey:@"password"];
    }
}

//按下return隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//关闭键盘
- (void)endEdit:(UIButton *)sender
{
    //[_messageTextView resignFirstResponder];//关闭键盘
    //[_messageTextView becomeFirstResponder];//调用键盘显示
    [self endEditing:YES];//关闭键盘
}

@end
