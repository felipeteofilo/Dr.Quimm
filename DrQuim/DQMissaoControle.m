//
//  DQMissaoControle.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissaoControle.h"

@implementation DQMissaoControle

-(id)initCena:(SKScene*)cenaRecebida{
    if (self=[super init]) {
        self.cena=cenaRecebida;
    }
    return self;
}

-(BOOL)iniciarNovaMissaoNPC:(NSString*)NPC{
    return NO;
}

-(BOOL)passarParteMissao:(NSString*)NPC item:(NSString*)item{
    return NO;
}

-(void)entregarItem{
    
}
-(void)receberItem{
    
}
-(void)receberEstados{
    
}
-(void)fimDaMissao{
    
}
@end
