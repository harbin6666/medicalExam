//
//  ItemTVC.m
//  Beck
//
//  Created by Aimy on 10/12/14.
//  Copyright (c) 2014 Aimy. All rights reserved.
//

#import "ItemtVC.h"

@interface ItemTVC ()

- (NSString *)answerParse;
- (NSString *)noteParse;

@end

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
    vc.canShowNote = YES;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    if (indexPath.section == 0){
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.f]};
        CGSize size = [[self itemDespretion] boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        if (size.height < 60.f) {
            return 60.f;
        }
        
        return size.height;
    }
    else if (indexPath.section == 1){
        return 60.f;
    }
    else if (indexPath.section == 2){
        return 44.f;
    }
    else if (indexPath.section == 3){
        if (self.canShowNote) {
            return 44.f;
        }
        else {
            return 0.f;
        }
    }
    else if (indexPath.section == 4){
        if (self.showAnswer) {
            return 80.f;
        }
        else {
            return 0.f;
        }
    }
    else if (indexPath.section == 5){
        if (self.showNote) {
            return 80.f;
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
        cell.hidden = !self.canShowNote;
    }
    else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self answerParse];
        
        cell.textLabel.hidden = !self.showAnswer;
        cell.detailTextLabel.hidden = !self.showAnswer;
    }
    else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
        cell.detailTextLabel.text = [self noteParse];
        
        cell.textLabel.hidden = !self.showNote;
        cell.detailTextLabel.hidden = !self.showNote;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (IBAction)addNote:(id)sender {
    WEAK_SELF;
    OTSAlertView *alertView = [OTSAlertView alertWithTitle:@"添加笔记" message:@"" andCompleteBlock:^(OTSAlertView *alertView, NSInteger buttonIndex) {
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
            json[@"subjectId"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"subjectId"];
            json[@"outlineId"] = self.itemVO.outlineId;
            json[@"typeId"] = @(self.itemVO.type);
            json[@"note"] = note;
            json[@"type"] = @0;
            
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
    return @"我是笔记";
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [self.itemVO setAnswer:nil andIndex:indexPath.row];
    }
}

@end