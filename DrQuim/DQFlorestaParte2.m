//
//  DQFlorestaParte2.m
//  DrQuim
//
//  Created by Julia Yamamoto on 30/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte2.h"

@implementation DQFlorestaParte2

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:3];
        
        self.hudFase = [[DQHudController alloc]initHud];
        [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
    
        //Inicia com a fase 3
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:3];
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        [self iniciarFase];
        [self addChild:self.hudFase];
    }
    return self;
}

-(void)iniciarFase
{
    [super iniciarFase];
}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
}

//FAZER ESCADAS
-(void)criarParteFase{
    [super criarParteFase];
}

@end
