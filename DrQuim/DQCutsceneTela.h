//
//  DQCutsceneTela.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCutsceneControlle.h"
#import "DQFase.h"

@interface DQCutsceneTela : SKScene

@property DQCutsceneControlle *controleCutScene;
@property int cutSceneAtual;
@property int faseAtual;


-(id)initCutScene:(int)cutSceneAtual Fase:(int)faseAtual SizeScene:(CGSize)size;
-(void)mostrarCena;
-(void)apresentarFase;
@end
