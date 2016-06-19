//
//  QuestionsViewModel.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "MostRecentQuestionsViewModel.h"
#import "ModelRepository.h"
#import "Question.h"

static NSString *const kCell1 = @"cell1";

@interface MostRecentQuestionsViewModel()
@property (strong, nonatomic) QuestionsModel *questionsModel;
@property (strong, nonatomic) ModelRepository *modelRepository;
@end

@implementation MostRecentQuestionsViewModel

#pragma mark - Lifecycle
- (instancetype)initWithModelRepository:(ModelRepository *)modelRepository {
    self = [super init];
    if (self) {
        _modelRepository = modelRepository;
        [_modelRepository addQuestionsSubscriber:self];
    }
    return self;
}


#pragma mark - Public accessors
- (NSArray<NSString *> *)cellNamesToRegister {
    return @[kCell1];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionsModel numberOfQuestions];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell1 forIndexPath:indexPath];
    
    Question *question = [self.questionsModel questionForIndex:indexPath.row];
    
    // the questions are implicitly in the most recent order so all we need to do is style the data
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:question.title];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, question.title.length)];
    [cell.textLabel setAttributedText:[attrString copy]];
    
    return cell;
}

#pragma mark - QuestionsObserver protocol
- (void)onNext:(QuestionsModel *)questionsModel {
    self.questionsModel = questionsModel;
    // Do stuff with model and update the properties that the View/VC cares about
    
    [self.delegate updateTableView];
}

- (void)onError:(NSError *)error {
    // errors booooo
}

@end
