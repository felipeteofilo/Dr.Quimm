//
//  DQGestoPulo.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQGestoPulo.h"
#import "DQJogador.h"

@implementation DQGestoPulo



-(id)init{
    
    if(self = [super initWithTarget:self action:@selector(pular)]){
        
        [self setDirection:UISwipeGestureRecognizerDirectionUp];
        
        
    }
    return self;
}

-(void)pular{
    
    [[DQJogador sharedJogador] pular];
    
    [[DQJogador sharedJogador]  removeActionForKey:@"andar"];
    [[DQJogador sharedJogador]removeActionForKey:@"animandoAndando"];
}





@end
