//
//  GCLoginViewController.m
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCLoginViewController.h"

#import "GCLoginManager.h"

@implementation GCLoginViewController
@synthesize _delegate;

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self._navBar setTitleLabelText:@"用户登录"];
    self._navBar._backButton.hidden = TRUE;
    //
    CGRect frame = self.view.frame;
    CGRect navFrame = self._navBar.frame;
    
    float bgOriginX = 0;
    float bgWidth = frame.size.width;
    float bgOriginY = navFrame.origin.y + navFrame.size.height;
    float bgHeight = frame.size.height - bgOriginY;
    UIImageView * bg = [[[UIImageView alloc] initWithFrame:CGRectMake(bgOriginX, bgOriginY, bgWidth, bgHeight)] autorelease];
    [self.view addSubview:bg];
    bg.image = [UIImage imageNamed:@"loginBg.jpg"];
    
    //
    UIButton * coverButton = [[[UIButton alloc] initWithFrame:bg.frame] autorelease];
    [self.view addSubview:coverButton];
    coverButton.backgroundColor = [UIColor clearColor];
    [coverButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //

    float imgWidth = 160;
    float imgOriginX = (frame.size.width - imgWidth) / 2;
    float imgOriginY = bgOriginY + 20;
    float imgHeight = 55;
    
    if(!IS_IPHONE5_OR_LATER)
    {
        imgHeight -= 5;
        imgOriginY -= 10;
    }
    
    UIImageView * img = [[[UIImageView alloc] initWithFrame:CGRectMake(imgOriginX, imgOriginY, imgWidth, imgHeight)] autorelease];
    [self.view addSubview:img];
    img.image = [UIImage imageNamed:@"login_title.png"];
    //
    float containerWidth = 253;
    float containerOriginY = imgOriginY + imgHeight + 20;
    float containerHeight = 86;
    if(!IS_IPHONE5_OR_LATER)
    {
        containerHeight -= 5;
    }
    
    float containerOriginX = (frame.size.width - containerWidth) / 2;
    UIView * container = [[[UIView alloc] initWithFrame:CGRectMake(containerOriginX, containerOriginY, containerWidth, containerHeight)] autorelease];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.layer.cornerRadius = 4;
    //
    float splitHeight = 0.5;
    float splitOriginX = 0;
    float splitWidth = containerWidth;
    float splitOriginY = (containerHeight - splitHeight) / 2;
    UIView * split = [[[UIView alloc] initWithFrame:CGRectMake(splitOriginX, splitOriginY, splitWidth, splitHeight)] autorelease];
    [container addSubview:split];
    split.backgroundColor = RGBA(226, 226, 226, 1);
    //
    NSString * iconImages[2] = {@"login.png",@"password.png"};
    NSString * placeholders[2] = {@"输入用户名",@"输入密码"};
    UITextField * fields[2] = {0};
    float fieldContainerOriginX = 0;
    float fieldContainerWidth = containerWidth;
    float fieldContainerHeight = splitOriginY;
    float fieldContainerOriginY = 0;
    for(int i = 0;i < 2;i++)
    {
        UIView * fieldContainer = [[[UIView alloc] initWithFrame:CGRectMake(fieldContainerOriginX, fieldContainerOriginY, fieldContainerWidth, fieldContainerHeight)] autorelease];
        [container addSubview:fieldContainer];
        //
        UIButton * fieldContainerButton = [[[UIButton alloc] initWithFrame:fieldContainer.bounds] autorelease];
        [fieldContainer addSubview:fieldContainerButton];
        [fieldContainerButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //
        float iconOriginX = 14;
        float iconWidth = 14;
        float iconHeight = iconWidth;
        float iconOriginY = (fieldContainerHeight - iconHeight) / 2;
        UIImageView * icon = [[[UIImageView alloc] initWithFrame:CGRectMake(iconOriginX, iconOriginY, iconWidth, iconHeight)] autorelease];
        [fieldContainer addSubview:icon];
        icon.image = [UIImage imageNamed:iconImages[i]];
        //
        float fieldOriginX = iconWidth + iconOriginX  + 10;
        float fieldOriginY = 0;
        float fieldHeight = fieldContainerHeight;
        float fieldWidth = fieldContainerWidth - fieldOriginX - 10;
        UITextField * field = [[[UITextField alloc] initWithFrame:CGRectMake(fieldOriginX, fieldOriginY, fieldWidth, fieldHeight)] autorelease];
        [fieldContainer addSubview:field];
        field.backgroundColor = [UIColor clearColor];
        field.delegate = self;
        field.keyboardType = UIKeyboardTypeDefault;
        field.returnKeyType = UIReturnKeyNext;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.borderStyle = UITextBorderStyleNone;
        field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        field.font =  [UIFont systemFontOfSize:14];
        field.adjustsFontSizeToFitWidth = TRUE;
        field.textColor = RGBA(107, 107, 107, 1);
        UIColor *placeholderColor = RGBA(107, 107, 107, 1);
        field.attributedPlaceholder = [[[NSAttributedString alloc] initWithString:placeholders[i] attributes:@{NSForegroundColorAttributeName: placeholderColor}] autorelease];
        fields[i] = field;
        
        fieldContainerOriginY += fieldContainerHeight + splitHeight;
    }
    _userName = fields[0];
    _pwd = fields[1];
    _pwd.secureTextEntry = TRUE;
    _pwd.returnKeyType = UIReturnKeyGo;
    
    //
    float loginOriginY = containerOriginY + containerHeight + 10;
    float loginHeight = 42;
    if(!IS_IPHONE5_OR_LATER)
    {
        loginHeight -= 5;
    }
    float loginWidth = 251;
    float loginOriginX = (frame.size.width - loginWidth) / 2;
    UIButton * loginButton = [[[UIButton alloc] initWithFrame:CGRectMake(loginOriginX, loginOriginY, loginWidth, loginHeight)] autorelease];
    [self.view addSubview:loginButton];
    loginButton.layer.cornerRadius = 4;
    loginButton.backgroundColor = RGBA(234, 114, 86, 1);
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    
    //
    float buttonOriginY = loginOriginY + loginHeight + 21;
    float buttonWidth = 65;
    float buttonDisX = 90;
    float buttonHeight = 13;
    float buttonOriginX = (frame.size.width - buttonDisX - buttonWidth * 2) / 2;
    //
    UIButton * getPwdButton = [[[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)] autorelease];
    [self.view addSubview:getPwdButton];
    [getPwdButton addTarget:self action:@selector(getPwdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [getPwdButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [getPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getPwdButton.titleLabel.font = [UIFont systemFontOfSize:13];
    //
    buttonOriginX += buttonWidth + buttonDisX;
    UIButton * registButton = [[[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)] autorelease];
    [self.view addSubview:registButton];
    [registButton addTarget:self action:@selector(registButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:13];
  
    //
    _userName.text = @"smallpay_admin";
    _pwd.text = @"admin";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = TRUE;
}
-(void)coverButtonClicked
{
    [_userName resignFirstResponder];
    [_pwd resignFirstResponder];
}

-(void)loginButtonClicked
{
    [self coverButtonClicked];
    //
    NSString * userName = _userName.text;
    NSString * pwd = _pwd.text;
    if(!(userName && [userName length] > 0))
    {
        [CTUtility alertMessage:@"提示" message:@"请输入用户名"];
    }
    else if(!(pwd && [pwd length] > 0))
    {
        [CTUtility alertMessage:@"提示" message:@"请输入密码"];
    }
    else
    {
        //登录
        [_network logIn:userName pwd:pwd type:0 channelCode:@" "];
    }
}

-(void)getPwdButtonClicked
{
    [self coverButtonClicked];
    //
}
-(void)registButtonClicked
{
    [self coverButtonClicked];
    //
}
#pragma  mark CTNetworkDelegate
-(void)networkStoped:(CTNetwork *)network success:(int)success
{
    if(success == Result_Succeed)
    {
        if(network._netTag == GCNetworkTag_LogIn)
        {
            [GCLoginManager instance]._userName = 0;//self._userName.text;
            [GCLoginManager instance]._isLogin = TRUE;
            [GCLoginManager instance]._userInfo = network._data;
            if(self._delegate)
            {
                [self._delegate loginSuccess:self];
            }

        }
    }
    else
    {
        [super networkStoped:network success:success];
    }
}

#pragma mark UITextFieldDelegate
//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL res = TRUE;
    if (textField == _userName)
    {
        [_pwd becomeFirstResponder];
        res = NO;
    }
    else
    {
        [_pwd resignFirstResponder];
        [self loginButtonClicked];//尝试登录
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL res = TRUE;
    if ([string length]>1 && (textField == _pwd))//避免粘贴
    {
        res = NO;
    }
    if ([string isEqualToString:@" "])
    {
        res = NO;
    }
    return res;
}


@end
