//
//  MostViewedTextView.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/19/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "MostViewedTextView.h"

@interface MostViewedTextView()
@property (strong, nonatomic) MostViewedQuestionsViewModel *viewModel;
@end

@implementation MostViewedTextView

- (void)bindTo:(MostViewedQuestionsViewModel *)viewModel {
    self.viewModel = viewModel;
    self.viewModel.delegate = self;
}

#pragma mark - MostViewedQuestionsViewModelProtocol
- (void)updateTextView {
    // Since we are not using RX we have to make sure things are on right thread
    // Since we don't really know what thread the underlying system is using
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setAttributedText:[self.viewModel displayableString]];
    });
}

@end
