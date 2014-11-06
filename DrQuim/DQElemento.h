//
//  DQElemento.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Elemento.h"

@interface DQElemento : SKSpriteNode


@property NSString *nome;
@property NSString *imagem;
@property int numeroEletrons;

-(id)initComEntidadeElemento:(Elemento*)elemento;

@end
