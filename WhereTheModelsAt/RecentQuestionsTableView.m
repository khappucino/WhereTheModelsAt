//
//  RecentQuestionsTableView.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "RecentQuestionsTableView.h"

@interface RecentQuestionsTableView()
@property (strong, nonatomic) MostRecentQuestionsViewModel *viewModel;
@end

@implementation RecentQuestionsTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}


- (void)bindTo:(MostRecentQuestionsViewModel *)viewModel {
    self.viewModel = viewModel;
    self.viewModel.delegate = self;
    self.dataSource = self.viewModel;
    for(NSString *cellNames in [self.viewModel cellNamesToRegister]) {
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellNames];
    }
}

#pragma mark - MostRecentQuestionsViewModelProtocol
- (void)updateTableView {
    // Since we are not using RX we have to make sure things are on right thread
    // Since we don't really know what thread the underlying system is using
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

@end
