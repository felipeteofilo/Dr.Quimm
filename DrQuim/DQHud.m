//
//  DQHud.m
//  TesteBarraStatus
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQHud.h"

@implementation DQHud

-(id)initHud{
    if (self=[super initWithImageNamed:@"FundoHUD.png"]) {
        //Inicializa HUD
        
        [self setAnchorPoint:CGPointMake(0,1)]; //Canto superior esquerdo
        
        //Inicializa os indicadores
       [self configuraBarras];
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

-(void)atualizarHud{
    [self.barraFome atualizarBarra:[DQHudController valorFome]];
    [self.barraVida atualizarBarra:[DQHudController valorVida]];
    [self.barraSede atualizarBarra:[DQHudController valorSede]];
}
@end
