//
//  UIImageView+AreaComposto.m
//  RotaryWheelProject
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/11/14.
//
//

#import "DQAreaComposto.h"

@implementation DQAreaComposto

-(id)initComFrame:(CGRect)frame eComposto:(NSString *)nomeDoComposto
{
    if(self = [super initWithImage:[UIImage imageNamed:@"recipiente.png"]]){
        self.frame = frame;
        
        //Mudar abaixo para colocar o nome do recipiente e adiquirir sua imagem
        UIImageView *imagemDoComposto = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"elementoTeste"]];
        
        imagemDoComposto.frame = CGRectMake(self.frame.size.width/2 - (self.frame.size.height * 0.15)/2,
                                            self.frame.size.height * 0.15 - (self.frame.size.height * 0.15)/2,
                                            self.frame.size.height * 0.15,
                                            self.frame.size.height * 0.15);
        
        imagemDoComposto.layer.zPosition = -10;
        
        NSLog(@"%.0f | %.0f = %.0f", self.frame.size.height * 0.15, imagemDoComposto.frame.size.height, imagemDoComposto.frame.size.height/2);
        
        [self addSubview:imagemDoComposto];
    }
    return self;
}

@end
