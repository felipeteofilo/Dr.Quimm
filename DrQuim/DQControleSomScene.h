//
//  DQControleSomScene.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleSom.h"
#import "DQConfiguracaoFase.h"
#import "DQCutsceneControle.h"

typedef NS_ENUM(int, TipoCena){
    Fase=0,
    CutScene=1,
};

@interface DQControleSomScene : DQControleSom

@property TipoCena tipoCenaConfigurado;
@property NSString *musicaFundo;
@property int indiceScene;

-(id)initControleSomScene:(TipoCena)tipoCena indiceCena:(int)indiceCena;
@end
