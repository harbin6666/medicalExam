//
//  ItemTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ItemtVC.h"

@implementation ItemTVC

+ (instancetype)createWitleItemVO:(ItemVO *)aVO
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Item" bundle:[NSBundle mainBundle]];
    ItemTVC *vc = nil;
    switch (aVO.type) {
        case ItemTypeChoice:
            vc = [sb instantiateViewControllerWithIdentifier:@"ChoiceItemTVC"];
            break;
        case ItemTypeMultiChoice:
            vc = [sb instantiateViewControllerWithIdentifier:@"MultiChoiceItemTVC"];
            break;
        case ItemTypeCompatibility:
            vc = [sb instantiateViewControllerWithIdentifier:@"CompatibilityItemTVC"];
            break;
        case ItemTypeDecision:
            vc = [sb instantiateViewControllerWithIdentifier:@"DecisionItemTVC"];
            break;
        case ItemTypeSpace:
            vc = [sb instantiateViewControllerWithIdentifier:@"SpaceItemTVC"];
            break;
        default:
            break;
    }
    
    vc.itemVO = aVO;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    if (indexPath.section == 0){
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [[self itemDespretion] boundingRectWithSize:CGSizeMake(270, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 60.f) {
            return 60.f;
        }
        
        return ceil(size.height);
    }
    else if (indexPath.section == 1){
        return 60.f;
    }
    else if (indexPath.section == 2){
        return 44.f;
    }
    else if (indexPath.section == 3){
        if (self.itemVO.canShowNote) {
            return 44.f;
        }
        else {
            return 0.f;
        }
    }
    else if (indexPath.section == 4){
        if (self.itemVO.showAnswer) {
            NSDictionary *attribute = @{NSFontAttributeName: font};
            CGSize size = [[self answerParse] boundingRectWithSize:CGSizeMake(270, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            if (size.height < 80.f) {
                return 80.f;
            }
            
            return ceil(size.height) + 20;
        }
        else {
            return 0.f;
        }
    }
    else if (indexPath.section == 5){
        if (self.showNote) {
            NSDictionary *attribute = @{NSFontAttributeName: font};
            CGSize size = [[self noteParse] boundingRectWithSize:CGSizeMake(270, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            if (size.height < 80.f) {
                return 80.f;
            }
            
            return ceil(size.height) + 40;
        }
        else {
            return 0.f;
        }
    }
    else {
        return 60.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger fontValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"fontValue"];
    UIFont *font = [UIFont systemFontOfSize:fontValue];
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
        cell.textLabel.text = [self itemDespretion];
    }
    else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:999];
        label.text = @"医疗机构药剂人员调配处方时的错误行为是?";
        
        UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jilu"]];
        cell.backgroundView = cellBackgroundView;
    }
    else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"我是选项";
    }
    else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
        cell.hidden = !self.itemVO.canShowNote;
        UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
        if (self.itemVO.hasNote) {
            [btn setTitle:@"更新笔记" forState:UIControlStateNormal];
        }
        else {
            [btn setTitle:@"添加笔记" forState:UIControlStateNormal];
        }
    }
    else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self answerParse];
        
        cell.textLabel.hidden = !self.itemVO.showAnswer;
        cell.detailTextLabel.hidden = !self.itemVO.showAnswer;
        cell.detailTextLabel.font = font;
    }
    else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self noteParse];
        
        cell.textLabel.hidden = !self.showNote;
        cell.detailTextLabel.hidden = !self.showNote;
        cell.detailTextLabel.font = font;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (IBAction)addNote:(UIButton *)sender {
    
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        [[OTSAlertView alertWithMessage:@"您当前无网情况下不能操作" andCompleteBlock:nil] show];
        return ;
    }
    
    WEAK_SELF;
    NSString *title = nil;
    if (self.itemVO.hasNote) {
        title = @"更新笔记";
    }
    else {
        title = @"添加笔记";
    }
    
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:title message:@"" andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            STRONG_SELF;
            NSString *note = [alertView textFieldAtIndex:0].text;
            if (!note.length) {
                return ;
            }
            
            NSMutableDictionary *params = @{}.mutableCopy;
            params[@"token"] = @"addUpdate";
            
            NSMutableDictionary *json = @{}.mutableCopy;
            json[@"titleId"] = self.itemVO.itemId;
            json[@"loginName"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginName"];
            json[@"subjectId"] = self.itemVO.subjectId;
            json[@"outlineId"] = self.itemVO.outlineId;
            json[@"typeId"] = @(self.itemVO.type);
            json[@"note"] = note;
            if (self.itemVO.hasNote) {
                json[@"type"] = @1;
            }
            else {
                json[@"type"] = @0;
            }
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            params[@"json"] = jsonString;
            
            [self showLoading];
            [self getValueWithBeckUrl:@"/front/userNoteAct.htm" params:params CompleteBlock:^(id aResponseObject, NSError *anError) {
                if (!anError) {
                    NSNumber *errorcode = aResponseObject[@"errorcode"];
                    if (errorcode.boolValue) {
                        [[OTSAlertView alertWithMessage:aResponseObject[@"msg"] andCompleteBlock:nil] show];
                    }
                    else {
                        self.itemVO.hasNote = YES;
                        [sender setTitle:@"更新笔记" forState:UIControlStateNormal];
                        [[OTSAlertView alertWithMessage:@"提交笔记成功" andCompleteBlock:nil] show];
                    }
                }
                else {
                    [[OTSAlertView alertWithMessage:@"提交笔记失败" andCompleteBlock:nil] show];
                }
                [self hideLoading];
            }];
        }
    }];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView addButtonWithTitle:@"取消"];
    [alertView show];
}

- (BOOL)showNote
{
    return self.itemVO.showNote;
}

- (BOOL)favorated
{
    return self.itemVO.favorated;
}

- (NSString *)answerParse
{
    return [self.itemVO answerParse] ?: @"无";
}

- (NSString *)noteParse
{
    return self.itemVO.noteString;
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (NSString *)itemDespretion
{
    return @"我是题型描述";
}

- (IBAction)onSelectedChoice:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:[self tableView]];
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
    [self.itemVO setAnswer:nil andIndex:path.row];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpNext" object:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [self.itemVO setAnswer:nil andIndex:indexPath.row];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpNext" object:nil];
    }
}

@end
