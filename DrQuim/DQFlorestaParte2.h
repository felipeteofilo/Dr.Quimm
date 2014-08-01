//
//  DQFlorestaParte2.h
//  DrQuim
//
//  Created by Julia Yamamoto on 30/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFase.h"
#import "DQBarraStatus.h"
#import "DQCutsceneControle.h"

@interface DQFlorestaParte2 : DQFase

//DQCutsceneControle para controlar as cutscenes e as falas.
@property DQCutsceneControle *controleCutscenes;

//Booleanos para controle da DQCutsceneControle
@property BOOL cutsceneEstaRodando;
@property BOOL estaFalando;

@end
