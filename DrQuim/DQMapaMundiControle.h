//
//  DQMapaMundiController.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQConfiguracaoFase.h"
#import "DQControleConfigGeral.h"
#import "DQCoreDataController.h"
#import "DQJogador.h"

@interface DQMapaMundiControle : NSObject

@property  NSArray *fasesConfiguradas;

-(BOOL)faseDisponivel:(int)fase;
@end
