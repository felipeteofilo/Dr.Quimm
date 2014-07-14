//
//  DQVila.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 12/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFase.h"
#import "DQEscalavel.h"
#import "DQBarraStatus.h"
#import "DQnpc.h"
#import "DQCutsceneControle.h"

@interface DQVila : DQFase

@property NSMutableArray *escalacel;

//DQCutsceneControle para controlar as cutscenes e as falas.
@property DQCutsceneControle *controleCutscenes;

//Booleanos para controle da DQCutsceneControle
@property BOOL cutsceneEstaRodando;
@property BOOL estaFalando;

//NPCs dessa fase
@property DQnpc *maeDeTodos; //Mãe de todos
@property DQnpc *cacador;    //Caçador
@property DQnpc *curandeiro; //Curandeiro
@property DQnpc *chefe;      //Chefe




@end
