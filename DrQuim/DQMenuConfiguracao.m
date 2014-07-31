//
//  DQMenuConfiguracao.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuConfiguracao.h"

@implementation DQMenuConfiguracao
-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        [self setName:@"Configurações"];
    }
    return self;
}
@end
