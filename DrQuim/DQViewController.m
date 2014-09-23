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

    SKView * skView = (SKView *)self.view;

    //DQMenuInicial *menuInicial=[DQMenuInicial sceneWithSize:skView.bounds.size];
    DQVila *menuInicial=[[DQVila alloc]initFase:2 Size:skView.bounds.size];
    
    menuInicial.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:menuInicial];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate{
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
