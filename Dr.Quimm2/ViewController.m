//
//  ViewController.m
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "DQIntroducao.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    DQIntroducao * scene = [DQIntroducao sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
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
