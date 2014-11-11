//
//  DQPopularCoreData.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQCoreDataController.h"

//Classe usada para pegar as informações dos plist e aplimentar o core data
@interface DQPopularCoreData : NSObject


@property NSDictionary *transformacoesPlist;
@property NSDictionary *TransformacoesRef;

-(void)iniciarReferenciasTransformacoes;




@end
