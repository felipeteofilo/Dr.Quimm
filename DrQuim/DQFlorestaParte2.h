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
#import "DQVila.h"


@interface DQFlorestaParte2 : DQFase

//DQCutsceneControle para controlar as cutscenes e as falas.
@property DQCutsceneControle *controleCutscenes;

@property SKScene *vila;

//Booleanos para controle da DQCutsceneControle
//@property BOOL falouRadiacaoLeopardinho;

//funcao que salva referencia da vila
-(void)salvarCenaVila :(SKScene*)vila;
@end
