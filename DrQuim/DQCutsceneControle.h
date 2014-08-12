//
//  DQCutsceneControlle.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQFala.h"

@interface DQCutsceneControle : NSObject

@property DQFala *falaCena;
@property NSArray *cenasCutScene;
@property int cenaAtual;
@property CGSize tamanhoTela;

-(id)initCutscene:(int)cutSceneAtual TamanhoTela:(CGSize)_tamanho;

-(SKSpriteNode*)montarCena;
-(BOOL)fimCutScene;
@end
