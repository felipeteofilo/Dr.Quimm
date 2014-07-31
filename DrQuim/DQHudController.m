//
//  DQHudController.m
//  TesteBarraStatus
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQHudController.h"

@implementation DQHudController

-(id)initHud{
    if (self=[super initWithImageNamed:@"FundoHUD.png"]) {
        //Inicializa HUD
        
        [self setAnchorPoint:CGPointMake(0,1)]; //Canto superior esquerdo
        
        //Inicializa os indicadores
        [self configuraBarras];
        
        self.botaoMenu=[SKSpriteNode spriteNodeWithImageNamed:@"rostoCientista"];
        [self.botaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame), -10)];
//        [self.botaoMenu setZPosition:100];
        [self.botaoMenu setName:@"MENU"];
        [self addChild:self.botaoMenu];
        
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)configuraBarras{
    self.barraFome=[[DQBarraStatus alloc]initComRed:241 Green:118 Blue:21 eLargura:237];
    self.barraSede=[[DQBarraStatus alloc]initComRed:0 Green:119 Blue:201 eLargura:256];
    self.barraVida=[[DQBarraStatus alloc]initComRed:191 Green:16 Blue:21 eLargura:257];
    
    [self.barraVida setPosition:CGPointMake(90, -98)];
    [self.barraFome setPosition:CGPointMake(431, -98)];
    [self.barraSede setPosition:CGPointMake(739, -98)];
    
    
    [self addChild:self.barraFome];
    [self addChild:self.barraSede];
    [self addChild:self.barraVida];
}

-(void)atualizarBarraStatus{
    [self.barraFome atualizarBarra:[[DQJogador sharedJogador]fome]];
    [self.barraSede atualizarBarra:[[DQJogador sharedJogador]sede]];
    [self.barraVida atualizarBarra:[[DQJogador sharedJogador]vida]];
}

-(void)atualizarHud{
    //quebrado o método pois podemos ter mais informações na HUD
    [self atualizarBarraStatus];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    if ([self childNodeWithName:@"MENU"]) {
        return;
    }
    
    for (SKSpriteNode *nodeTocado in arrayNodes) {
        if ([nodeTocado.name isEqualToString:@"MENU"]) {
            if (!self.menu) {
                self.menu=[[DQMenu alloc]initMenu];
                [self.menu setPosition:CGPointMake(500, 500)];
                [self.menu setZPosition:100];
            }
            
            [self addChild:self.menu];
            break;
        }
    }
}
@end
