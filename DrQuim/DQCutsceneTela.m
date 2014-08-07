//
//  DQCutsceneTela.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneTela.h"

@implementation DQCutsceneTela

-(id)initCutScene:(int)cutSceneAtual Fase:(SKScene*)faseApresentar SizeScene:(CGSize)size{
    if (self=[super initWithSize:size]) {
        self.controleCutScene=[[DQCutsceneControlle alloc]initCutscene:cutSceneAtual TamanhoTela:self.frame.size];
        
        self.cutSceneAtual=cutSceneAtual;
        self.faseApresentar=faseApresentar;
        
        if (![self.controleCutScene fimCutScene]) {
            [self mostrarCena];
        }
        
    }
    return self;
}
-(void)mostrarCena{
    //Remove os nodes de cena que possuir
    if ([self childNodeWithName:@"CenaCutScene"]) {
        [[self childNodeWithName:@"CenaCutScene"]removeFromParent];
    }
    
    SKSpriteNode *cenaExibir=[self.controleCutScene montarCena];
    [cenaExibir setName:@"CenaCutScene"];
    
    [cenaExibir setPosition:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame))];
    [cenaExibir setSize:self.frame.size];
    
    [self addChild:cenaExibir];
}

-(void)apresentarFase{
    [self.view presentScene:self.faseApresentar];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //Verifica se tem cena a ser mostrada
    if ([self.controleCutScene fimCutScene]) {
        [self apresentarFase];
    }else{
        [self mostrarCena];
    }
}
@end
