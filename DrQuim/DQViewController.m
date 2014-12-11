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

    //Inicia controladores de som
    self.controleSomEfeitos =[[DQControleSom alloc]initControleSom];
    self.controleSomScenes =[[DQControleSomScene alloc]initControleSomCena];
    
    SKView * skView = (SKView *)self.view;
    
    skView.showsPhysics = YES;

    //DQMenuInicial *fase=[DQMenuInicial sceneWithSize:skView.bounds.size];
//    DQFlorestaParte1 *fase=[[DQFlorestaParte1 alloc]initFase:1 Size:skView.bounds.size];
    DQVila *fase=[[DQVila alloc]initFase:2 Size:skView.bounds.size];
//    DQFlorestaParte2 *fase=[[DQFlorestaParte2 alloc]initFase:3 Size:skView.bounds.size];
    
    fase.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:fase];
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
