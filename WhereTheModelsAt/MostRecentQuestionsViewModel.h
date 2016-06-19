//
//  QuestionsViewModel.h
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Observable.h"
@class ModelRepository;

// I am making a protocol here because I am too lazy to hand make the Observables
@protocol MostRecentQuestionsViewModelProtocol <NSObject>
- (void)updateTableView;
@end


// I am making the compromise of having UIKit touch this viewModel because
// I don't want to trade VC complexity for theoretical purity (aka no UIKit in ViewModel)
// You can do whatever you want of course
@interface MostRecentQuestionsViewModel : NSObject <QuestionsObserver, UITableViewDataSource>
@property (nonatomic, weak) id<MostRecentQuestionsViewModelProtocol> delegate;
- (instancetype)initWithModelRepository:(ModelRepository *)modelRepository;
- (NSArray<NSString *> *)cellNamesToRegister;
@end
