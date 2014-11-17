//
//  UIControl+DQcirculo.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 17/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQcirculo.h"

@implementation DQcirculo

-(id)initComFrame: (CGRect)frame comDelegate:(id)del comNumeroDeCompostos:(int)numeroDeCompostos eCompostos:(NSArray *)arrayDeCompostos
{
    if(self = [super initWithFrame:frame]){
        self.arrayDeCompostos = [[NSArray alloc]initWithArray:arrayDeCompostos];
        self.tagImagemSelecionada = 0;
        
        self.compostoAtual = 0;
        self.numeroDeCompostos = numeroDeCompostos;
        self.delegate = del;
        
        [self desenharCirculo];
    }
    return self;
}

-(void)desenharCirculo
{
    self.base = [[UIView alloc] initWithFrame:self.frame];
    CGFloat tamanhoAngulo = 2 * M_PI / self.numeroDeCompostos;
    
    for(int i = 0; i < self.numeroDeCompostos; i++){
        DQAreaComposto *areaComposto = [[DQAreaComposto alloc]initComFrame:CGRectMake(self.base.bounds.size.width/2, self.base.bounds.size.height/2, self.base.bounds.size.height * 0.5f, self.base.bounds.size.height * 0.5f) eComposto:[self.arrayDeCompostos objectAtIndex:i]];
    
        areaComposto.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
        areaComposto.contentMode = UIViewContentModeScaleAspectFit;
        areaComposto.layer.position = CGPointMake(self.base., <#CGFloat y#>)
    }
}

@end
