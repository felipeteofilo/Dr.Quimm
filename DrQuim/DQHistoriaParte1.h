//
//  DQHistoriaParte1.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 13/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCutsceneControle.h"

@interface DQHistoriaParte1 : SKScene

@property int cenaAtual;
@property DQCutsceneControle *cutSceneControle;

@property SKSpriteNode *fundo;
@property SKSpriteNode *caixaDeFala;
@property SKLabelNode *fala;

-(id)initWithSize:(CGSize)size;

-(void)mostrarFundoAtual;
-(void)mostrarCaixaTexto;
-(void)mostrarFalaAtual;

-(void)trocarCena;
-(void)fimDasCenas;

@end
