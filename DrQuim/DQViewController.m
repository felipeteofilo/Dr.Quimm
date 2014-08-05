//
//  DQViewController.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQViewController.h"

@implementation DQViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.showsPhysics=YES;
    
    // Create and configure the scene.
    //DQFlorestaParte1 *floresta = [DQFlorestaParte1 sceneWithSize:skView.bounds.size];
    DQVila *floresta=[DQVila sceneWithSize:skView.bounds.size];
    //DQFlorestaParte2 *floresta = [DQFlorestaParte2 sceneWithSize:skView.bounds.size];
    
    floresta.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:floresta];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
