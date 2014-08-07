//
//  DQVila.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 12/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFase.h"
#import "DQBarraStatus.h"
#import "DQnpc.h"
#import "DQCutsceneControle.h"
#import "DQMissoesJogador.h"

@interface DQVila : DQFase

@property NSMutableArray *escalavel;

//DQMissoesJogador que guarda as informações de missão
@property DQMissoesJogador *missao;

//DQCutsceneControle para controlar as cutscenes e as falas.
@property DQCutsceneControle *controleCutscenes;

//NPCs dessa fase
@property DQnpc *maeDeTodos; //Mãe de todos
@property DQnpc *cacador;    //Caçador
@property DQnpc *curandeiro; //Curandeiro
@property DQnpc *chefe;      //Chefe
@property DQnpc *quimm;      //Dr.Quimm

@end
