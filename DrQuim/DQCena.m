//
//  DQCena.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCena.h"

@implementation DQCena

-(id)initComNomeDaImagem:(NSString *)nomeDaImagem_
{
    self = [super init];
    if(self)
    {
        self.nomeDaImagem = nomeDaImagem_;
    }
    return self;
}


@end
