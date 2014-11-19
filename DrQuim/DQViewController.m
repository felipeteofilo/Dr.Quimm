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
    //PARA O CIRCULO DE TRANSFORMAÇÃO
    [super viewDidAppear:animated];
    
    SKView * skView = (SKView *)self.view;
    skView.showsPhysics = YES;
    
    DQPopularCoreData *core = [[DQPopularCoreData alloc]init];
    
    [core iniciarReferenciasTransformacoes];
    
    //Array temporarios - substitui pela array de compostos que o jogador possui
    NSArray *arrayDeCompostos = [[NSArray alloc]initWithObjects:@"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", @"Ácido Sulfúrico", nil];
    int numeroDeCompostos = arrayDeCompostos.count;
    
    DQcirculo *circulo = [[DQcirculo alloc]initComFrame:CGRectMake(0, 0, self.view.frame.size.height * 0.5, self.view.frame.size.height * 0.5) comDelegate:self comNumeroDeCompostos:numeroDeCompostos eCompostos:arrayDeCompostos];
    
    circulo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:circulo];
    
    
//    //PARA CENAS DO JOGO
//
//    //DQMenuInicial *fase=[DQMenuInicial sceneWithSize:skView.bounds.size];
//    //DQFlorestaParte1 *fase=[[DQFlorestaParte1 alloc]initFase:1 Size:skView.bounds.size];
//    //DQVila *fase=[[DQVila alloc]initFase:2 Size:skView.bounds.size];
//    DQFlorestaParte2 *fase=[[DQFlorestaParte2 alloc]initFase:3 Size:skView.bounds.size];
//    
//    fase.scaleMode = SKSceneScaleModeAspectFill;
//    
//    [skView presentScene:fase];
}

-(void)viewDidLoad
{
    

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
