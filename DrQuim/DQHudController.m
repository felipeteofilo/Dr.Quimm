//
//  DQHudController.m
//  TesteBarraStatus
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQHudController.h"

@implementation DQHudController

+(float)valorFome{
    return [[DQJogador sharedJogador] fome];
}
+(float)valorSede{
    return [[DQJogador sharedJogador] sede];
}
+(float)valorVida{
    return [[DQJogador sharedJogador] vida];
}
@end
