//
//  DQViewController.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQViewController.h"
#import "DQPopularCoreData.h"
#import "DQComposto.h"
#import "DQElemento.h"
#import "DQReceita.h"
#import "DQTelaInfoComposto.h"


@implementation DQViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


//   SKView * skView = (SKView *)self.view;
//   skView.showsPhysics = YES;
//
//   //DQMenuInicial *menuInicial=[DQMenuInicial sceneWithSize:skView.bounds.size];
//    // DQVila *menuInicial=[[DQVila alloc]initFase:2 Size:skView.bounds.size];
//   //DQSceneTeste *menuInicial=[[DQSceneTeste alloc]initWithSize:skView.bounds.size];
//    
//    DQFlorestaParte1 *menuInicial = [[DQFlorestaParte1 alloc]initFase:1 Size:skView.bounds.size];
//   
//    menuInicial.scaleMode = SKSceneScaleModeAspectFill;
//  
//   [skView presentScene:menuInicial];
    
    DQPopularCoreData *core = [[DQPopularCoreData alloc]init];
    
    
    [core iniciarReferenciasTransformacoes];
    
//    DQElemento * elemento =[[DQElemento alloc]initComEntidadeElemento:[DQCoreDataController procurarElemento:@"Elemento"]];
//    
    DQComposto *composto = [[DQComposto alloc]initComEntidadeComposto:[DQCoreDataController procurarComposto:@"Nome"]];
//    DQReceita *receita = [[DQReceita alloc]initComReceita:[DQCoreDataController procurarReceita:@"Receita"]];
    
    
    
    
//    DQTelaInfoComposto *info = [[DQTelaInfoComposto alloc]initNaPosicao:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2) tamanho:self.view.frame.size];
    
    
    
   // [self.view addSubview:info];
    [self.view addSubview:composto];


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
