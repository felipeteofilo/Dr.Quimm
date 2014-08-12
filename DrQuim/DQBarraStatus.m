//
//  DQBarraStatus.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQBarraStatus.h"

@implementation DQBarraStatus

-(id)initComRed:(CGFloat)_red Green:(CGFloat)_green Blue:(CGFloat)_blue eLargura:(float)largura{
    
    if (self=[super initWithColor:[UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:1.0] size:CGSizeMake(largura, 60)]) {
        
        //Seta o anchor point, para qndo for cortar, tirar apenas do final
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setZPosition:-50.0];
    }
    
    return self;
}

-(id)initComRed:(CGFloat)_red Green:(CGFloat)_green Blue:(CGFloat)_blue size:(CGSize)size{
    if (self=[super initWithColor:[UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:1.0] size:size]) {
        
        //Seta o anchor point, para qndo for cortar, tirar apenas do final
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setZPosition:-50.0];
    }
    
    return self;
}

-(void)atualizarBarra:(float)valor{
    //Faz a conversão para valores decimais    
    self.xScale= valor/100;

}

@end
