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
#import "DQFlorestaParte2.h"
#import "DQTransformacaoTela.h"
#import "DQControleUserDefalts.h"

#import "DQViewControllerInfoTransformacao.h"



@interface DQVila : DQFase

@property NSMutableArray *escalavel;

@property CGPoint posicaoJogador;
//NPCs dessa fase
@property NSMutableArray *npcs;

//Usado para definir se irá apresentar a cena da bronca ou não
@property BOOL apresentouTransformacao;
@property BOOL apresentouVila;
@property BOOL mostrandoContador;



@property BOOL falouCurandeiroCacadaCoelho;
@end
