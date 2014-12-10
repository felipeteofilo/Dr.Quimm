//
//  DQFruta.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 10/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFruta.h"

@interface DQFruta()
@property NSString *nomeFruta;

@end

@implementation DQFruta

-(id)initFrutaComNome:(NSString *)nomeFruta{
    if (self=[super initWithImageNamed:[NSString stringWithFormat:@"%@.png",nomeFruta]]) {
        [self setUserInteractionEnabled:YES];
        [self setNomeFruta:nomeFruta];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:notificacaoFruta object:nil userInfo:[NSDictionary dictionaryWithObject:self.nomeFruta forKey:@"NomeFruta"]];
    
    [self removeFromParent];
}
@end