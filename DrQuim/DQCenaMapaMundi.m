//
//  DQMapaMundi.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 29/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCenaMapaMundi.h"

@implementation DQCenaMapaMundi

-(id)initWithSize:(CGSize)size{
    if (self=[super initWithSize:size]) {
        self.controleMapaMundi =[[DQMapaMundiControle alloc]init];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.controleMapaMundi faseDisponivel:1];
}
@end
