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
        self.controleCutScene=[[DQCutsceneControle alloc]initCutscene:cutSceneAtual TamanhoTela:self.frame.size];
        
        self.cutSceneAtual=cutSceneAtual;
        self.faseApresentar=faseApresentar;
        self.controleSomScene=[[DQControleSomScene alloc]initControleSomFundo:CutScene nomeSom:[self.controleCutScene somCenaCutScene] indiceCena:self.cutSceneAtual];
        
        if (![self.controleCutScene fimCutScene]) {
            [self mostrarCena];
            [self.controleSomScene tocarMusicaFundo];
        }else{
            [self apresentarFase];
        }
        [self addChild:self.controleSomScene];
        
    }
    return self;
}
-(void)mostrarCena{
    //Remove os nodes de cena que possuir
    if ([self childNodeWithName:@"CenaCutScene"]) {
        [[self childNodeWithName:@"CenaCutScene"]removeFromParent];
    }
    
    //Remove os sons anteriores
    [self.controleSomScene removeAllActions];
    
    NSString *nomeSomCenaCutScene=[self.controleCutScene somCenaCutScene];
    
    if ([nomeSomCenaCutScene length]!=0){
        //Remove o som anteriores
        [self.controleSomScene removeActionForKey:@"tocandoSom"];
        [self.controleSomScene tocarSom:[self.controleSomScene configuraPlayerSom:nomeSomCenaCutScene nLoops:-1]];
        
    }else if ([nomeSomCenaCutScene isEqualToString:@"REMOVERSOM"]){
        [self.controleSomScene.playerMusicaFundo stop];
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
