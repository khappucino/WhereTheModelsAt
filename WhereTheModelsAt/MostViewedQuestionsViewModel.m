//
//  MostVotedQuestionsViewModel.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "MostViewedQuestionsViewModel.h"
#import "ModelRepository.h"
#import "Question.h"

@interface MostViewedQuestionsViewModel()
@property (strong, nonatomic) NSArray<Question *> *questions;
@property (strong, nonatomic) ModelRepository *modelRepository;
@end

@implementation MostViewedQuestionsViewModel

#pragma mark - Lifecycle
- (instancetype)initWithModelRepository:(ModelRepository *)modelRepository {
    self = [super init];
    if (self) {
        _modelRepository = modelRepository;
        [_modelRepository addQuestionsSubscriber:self];
    }
    return self;
}


#pragma Public accessors
- (NSAttributedString *)displayableString {
    NSMutableAttributedString *bigString = [[NSMutableAttributedString alloc] init];
    for(Question *question in self.questions) {
        NSMutableAttributedString *viewsString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ - ", question.views] attributes:@{
                                                                                                                                                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                NSBackgroundColorAttributeName: [UIColor clearColor]
                                }];
        [bigString appendAttributedString:viewsString];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:question.title];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, question.title.length)];
        [bigString appendAttributedString:attrString];
        [bigString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    }
    return bigString;
}

#pragma mark - QuestionsObserver protocol
- (void)onNext:(QuestionsModel *)questionsModel {
    // If we were using RX we would just be explicit about what thread the marshalling up happens on
    
    // Discussion point: we could dispatch this to background if the lists took a while to process
    // This might take a while so I don't want to hold up everyone else
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.questions = [questionsModel.allQuestions sortedArrayUsingComparator:^NSComparisonResult(Question *_Nonnull question1, Question *_Nonnull question2) {
            NSNumber *first = question1.views;
            NSNumber *second = question2.views;
            return [second compare:first];
        }];
        // Do stuff with model and update the properties that the View/VC cares about
        [self.delegate updateTextView];
    });
}

- (void)onError:(NSError *)error {
    // errors booooo
}

@end
