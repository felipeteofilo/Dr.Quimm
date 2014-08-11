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
        [self configurarBotaoMenu];
        [self configuraContadorGeiger];
        
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
    CGPoint posicaoToqueNode=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posicaoToqueNode];
    
    if ([self childNodeWithName:@"MENU"]) {
        [[self childNodeWithName:@"MENU"]removeFromParent];
    }
    
    for (SKSpriteNode *nodeTocado in arrayNodes) {
        if ([nodeTocado.name isEqualToString:@"botaoMenu"]) {
            if (!self.menu) {
                self.menu=[[DQMenu alloc]initMenu];
                [self.menu setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)-100)];
                
            }
            
            if (![self childNodeWithName:@"MENU"]) {
                [self.parent addChild:self.menu];
                [self.parent setPaused:YES];
            }
            
            break;
        }
    }

}
-(void)configurarBotaoMenu{
    self.botaoMenu=[SKSpriteNode spriteNodeWithImageNamed:@"botaoMenu"];
    [self.botaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMinY(self.frame)+130)];
    
    [self.botaoMenu setName:@"botaoMenu"];
    [self addChild:self.botaoMenu];
}

-(void)configuraContadorGeiger{
    self.contador=[[DQContadorGeiger alloc]initContadorNivelRadicao:0];
    [self.contador setPosition:CGPointMake(CGRectGetMaxX(self.frame)-(self.contador.size.width/4), CGRectGetMinY(self.frame)+130)];
    
    [self addChild:self.contador];
    
}
@end
