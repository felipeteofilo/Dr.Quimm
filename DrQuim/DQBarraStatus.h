//
//  DQBarraStatus.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQBarraStatus : SKSpriteNode

-(id)initComRed:(CGFloat)_red Green:(CGFloat)_green Blue:(CGFloat)_blue eLargura:(float)largura;
-(id)initComRed:(CGFloat)_red Green:(CGFloat)_green Blue:(CGFloat)_blue size:(CGSize)size;

-(void)atualizarBarra:(float)valor;

@end
