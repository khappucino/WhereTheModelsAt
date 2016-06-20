//
//  ViewController.m
//  WhereTheModelsAt
//
//  Created by spacehomunculus on 6/18/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "ViewController.h"
#import "MostViewedQuestionsViewModel.h"
#import "ModelRepository.h"
#import "RecentQuestionsTableView.h"
#import "MostViewedTextView.h"
#import "MostRecentQuestionsViewModel.h"
#import "MostViewedQuestionsViewModel.h"

@interface ViewController ()

@property (strong, nonatomic) ModelRepository *modelRepository;
@property (weak, nonatomic) IBOutlet RecentQuestionsTableView *tableView;
@property (weak, nonatomic) IBOutlet MostViewedTextView *textView;
@property (strong, nonatomic) MostRecentQuestionsViewModel *recentQuestionsViewModel;
@property (strong, nonatomic) MostViewedQuestionsViewModel *mostViewedQuestionsViewModel;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

// These injections are because of the way typhoon creates it's object graph
// If I try to inject the viewModel directly into the RecentQuestionsTableView
// (during the storyboard load) it gives me a TOTALLY different instance for the
// ModelRepository. This injection and later bindTo: is so that this ViewController
// and the viewModels all get the same instance of the modelRepository,
// This is because during the resolution of the ViewController it makes all the
// ModelRepositories the same. This does not appear to happen when letting the
// Storyboard initialize the tableview and textview (and property injecting)
- (void)injectRecentViewModel:(MostRecentQuestionsViewModel *)recentViewModel {
    self.recentQuestionsViewModel = recentViewModel;
}
- (void)injectMostViewModel:(MostViewedQuestionsViewModel *)mostViewModel {
    self.mostViewedQuestionsViewModel = mostViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView bindTo:self.recentQuestionsViewModel];
    [self.textView bindTo:self.mostViewedQuestionsViewModel];
    [self.modelRepository fetch];
}







@end
