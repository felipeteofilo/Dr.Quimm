//
//  DQFala.h
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQFala : NSObject

@property NSString *sujeito;
@property NSString *texto;

//Metodo para inicia a classe com Sujeito e Texto do que diz
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_;

@end
