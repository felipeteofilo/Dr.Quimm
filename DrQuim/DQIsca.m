//
//  DQIsca.m
//  criacaoAnimal
//
//  Created by Leonardo de Sousa Mendes on 04/08/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQIsca.h"

@implementation DQIsca

-(id)initIsca :(NSString*)nome Caracterisca:(NSString*)caracteristica{
    if (self=[super init]) {
        self.objeto=nome;
        self.detalhe=caracteristica;
    }
    return self;
}
@end
