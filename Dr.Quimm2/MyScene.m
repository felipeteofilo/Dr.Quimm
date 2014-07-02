//
//  MyScene.m
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import "MyScene.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        DQJogador *teste = [[DQJogador alloc] init];
        [teste criarAcoesAnimacaoJogador];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
