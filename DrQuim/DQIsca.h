//
//  DQIsca.h
//  criacaoAnimal
//
//  Created by Leonardo de Sousa Mendes on 04/08/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface DQIsca : NSObject

@property NSString *objeto;
@property NSString *detalhe;
@property SKTexture *imagem;

-(id)initIsca :(NSString*)nome Caracterisca:(NSString*)caracteristica Imagem:(SKTexture*)imagem;
@end
