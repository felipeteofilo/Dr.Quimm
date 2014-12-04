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
#import "DQTelaInfoReceitas.h"



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
    NSArray *arrayDeCompostos = [[NSArray alloc]initWithObjects:@"Ácido Sulfúrico", @"Açúcar (Sacarose)", @"Glicerina", @"Permanganato de potássio", @"Nitrato de chumbo II", @"Sulfato de potássio", @"Iodeto de Potássio", @"Nitrato de Potássio", @"Sulfato de Magnésio", @"Cloreto de sódio",@"Nitrato de Chumbo", nil];
    int numeroDeCompostos = arrayDeCompostos.count;
    
    DQcirculo *circulo = [[DQcirculo alloc]initComFrame:CGRectMake(0, 0, self.view.bounds.size.height * 0.5, self.view.bounds.size.height * 0.5) comDelegate:self comNumeroDeCompostos:numeroDeCompostos eCompostos:arrayDeCompostos];
    
    circulo.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:circulo];
    
    [circulo mostrarInfoComposto];
    
  
    NSArray *arrayReceitas = [[NSArray alloc]initWithObjects:@"Líquido Amarelo",@"Pequenas Explosões",@"Fogo",@"Carbono",@"Polvora", nil];
    
    
    DQTelaInfoReceitas * infoReceitas = [[DQTelaInfoReceitas alloc]initComReceitas:arrayReceitas frame:self.view.bounds];
    
    [self.view addSubview:infoReceitas];
    
    
//    DQViewCompostosMix *mix = [[DQViewCompostosMix alloc]initComTamanho:self.view.bounds];
//    
//    
//    [self.view addSubview:mix];
//    
//    [mix mostrarBotaoMix];
    
    
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
