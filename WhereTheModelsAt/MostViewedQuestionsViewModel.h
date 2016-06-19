//
//  MostVotedQuestionsViewModel.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Observable.h"
@class ModelRepository;

// I am making a protocol here because I am too lazy to hand make the Observables
@protocol MostViewedQuestionsViewModelProtocol <NSObject>
- (void)updateTextView;
@end

@interface MostViewedQuestionsViewModel : NSObject <QuestionsObserver>
@property (nonatomic, weak) id<MostViewedQuestionsViewModelProtocol> delegate;
- (instancetype)initWithModelRepository:(ModelRepository *)modelRepository;
- (NSAttributedString *)displayableString;
@end
