//
//  DQVila.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 12/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFase.h"
#import "DQBarraStatus.h"
#import "DQNpc.h"
#import "DQCutsceneControle.h"
#import "DQCenaBronca.h"

@interface DQVila : DQFase

@property NSMutableArray *escalavel;

//NPCs dessa fase
@property NSMutableArray *npcs;

//Usado para definir se irá apresentar a cena da bronca ou não
@property BOOL apresentaCenaBronca;
@end
