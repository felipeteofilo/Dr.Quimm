//
//  DQCutsceneTela.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCutsceneControle.h"
#import "DQControleSomScene.h"


@interface DQCutsceneTela : SKScene

@property DQCutsceneControle *controleCutScene;
@property int cutSceneAtual;
@property SKScene *faseApresentar;
@property   DQControleSomScene *controleSomScene;

-(id)initCutScene:(int)cutSceneAtual Fase:(SKScene*)faseApresentar SizeScene:(CGSize)size;
-(void)mostrarCena;
-(void)apresentarFase;
@end
