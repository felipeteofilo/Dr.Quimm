//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"
#import "DQControleUserDefalts.h"


#define RAIOAPITAR 70
#define RAIOFALAR 20

@implementation DQFlorestaParte1

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.contadorAcao=0;
        
        [self configuracoesFase:1];
        //Esta chamando no metodo didMoveToView da classe mae
        //[self iniciarFase];
    }
    return self;
}


-(void)iniciarFase{
    [super iniciarFase];
    
    self.alertas = [[DQAlertasControle alloc]initComFaseAtual:self.faseAtual];
    
    //Remove o HUD pois o mesmo nao aparece na 1 fase
    [self.hudFase removeFromParent];
   
    [self.jogador setDistAndar:90];
}




//-(void)iniciarTutorial:(NSString*)acao{
//    SKTextureAtlas *atlasTutorial=[SKTextureAtlas atlasNamed:[NSString stringWithFormat:@"tutorial%@",acao]];
//    NSMutableArray *framesTutorial=[NSMutableArray array];
//    
//    for (int i=1;i <= [[atlasTutorial textureNames]count];i++) {
//        SKTexture *temp = [atlasTutorial textureNamed:[NSString stringWithFormat:@"%d", i]];
//        
//        [framesTutorial addObject:temp];
//    }
//    
//    SKSpriteNode *spriteTutorial=[[SKSpriteNode alloc]init];
//    [spriteTutorial setSize:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
//    [spriteTutorial setName:@"Tutorial"];
//    
//    if ([acao isEqualToString:@"Pular"]) {
//        [spriteTutorial setAnchorPoint:CGPointMake(0, 0)];
//        [spriteTutorial setPosition:CGPointMake(0, 0)];
//    }else {
//        [spriteTutorial setAnchorPoint:CGPointMake(0, 0)];
//        [spriteTutorial setPosition:CGPointMake(self.frame.origin.x + self.frame.size.width/2, 0)];
//    }
//    
//    [self animarTutorial:framesTutorial noSpriteNode:spriteTutorial];
//}

//-(void)animarTutorial:(NSArray*)arrayTexturas noSpriteNode:(SKSpriteNode*)spriteTutorial{
//    [self addChild:spriteTutorial];
//    
//    //Desativa a interacao do user
//    [self setUserInteractionEnabled:NO];
//    
//    [spriteTutorial runAction:[SKAction animateWithTextures:arrayTexturas timePerFrame:0.25f] completion:^{
//        //Ativa a interacao do user
//        
//        [self setUserInteractionEnabled:YES];
//        [spriteTutorial removeFromParent];
//        self.contadorAcao=0;
//    }];
//}

//-(void)verificaApresentacaoTurorial:(NSTimeInterval)currentTime{
//    if (self.contadorAcao == 0) {
//        self.contadorAcao = CACurrentMediaTime();
//    }
//    
//    SKNode *node=[self childNodeWithName:@"Tutorial"];
//    
//    if (CACurrentMediaTime()-self.contadorAcao > 2 && !node) {
//        if (!self.andouEsquerda) {
//            [self iniciarTutorial:@"CorrerEsquerda"];
//            
//        }else if (!self.andouDireita){
//            [self iniciarTutorial:@"CorrerDireita"];
//            
//        }else if (!self.pulou){
//            [self iniciarTutorial:@"Pular"];
//        }
//        
//        self.contadorAcao = CACurrentMediaTime();
//    }
//}

//Metodo chamado toda hora pela spriteKit, usado para criar as partes do corpo fisico da fase ==OK==
-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    
    
    //Fazer o jogador sair de perto
    
    
    [self segundaCutScene];
    
    
   // [self verificaApresentacaoTurorial:currentTime];
}





-(void)segundaCutScene{
    CGPoint pontoSegundaCutscene;
    
    //-> segundaCutscene
    pontoSegundaCutscene = CGPointMake(7640, 330);
    //-> segundaCutscene
    //se o jogador chegar ao local da fala, comeca a fala
    
    //Alterado para verificar apenas pelo X
    if( self.jogador.position.x > pontoSegundaCutscene.x){
        
        [self.jogador pararAndar];
        [self mudarFase];
    }
}

//metodo para mudar da fase 1 para vila
-(void)mudarFase{
    DQVila *vila=[DQVila sceneWithSize:self.view.bounds.size];
    
    vila.scaleMode = SKSceneScaleModeAspectFill;
    
    //Cria um cutSceneTela
    DQCutsceneTela *proxCutScene=[[DQCutsceneTela alloc]initCutScene:1 Fase:vila SizeScene:self.view.bounds.size];
    
    [DQControleUserDefalts setRodouCutSceneFase:self.faseAtual+1 Valor:YES];
    
    [proxCutScene setScaleMode:SKSceneScaleModeAspectFill];
    
    [self.view presentScene:proxCutScene];
}




@end
