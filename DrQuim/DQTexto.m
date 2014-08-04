//
//  DQTexto.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQTexto.h"

@implementation DQTexto


-(id)initTexto:(NSString *)texto espacoLimite:(CGSize)espacoLimite fonte:(float)fonte{
    if (self =[super initWithColor:nil size:espacoLimite]) {
        
        [self configuraTexto:texto limite:espacoLimite fonte:fonte];
        [self adicionaTexto];
    }
    return self;
}

-(id)initTexto:(NSString *)texto espacoLimite:(CGSize)espacoLimite fonte:(float)fonte anchorPoint:(CGPoint)anchorPoint{
    if (self=[super initWithColor:nil size:espacoLimite]) {
        
        [self setAnchorPoint:anchorPoint];
        [self configuraTexto:texto limite:espacoLimite fonte:fonte];
    }
    return self;
}

-(void)configuraTexto:(NSString *)texto limite:(CGSize)limite fonte:(float)fonte{
    //Indica de qual posicao do array a sklabel deve ser pega
    int posLabelArray=0;
    
    //Diminuir o tamanho do nome p facilitar
    NSArray *palavrasTexto = [texto componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    SKLabelNode *primeiraLabel=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    [primeiraLabel setFontSize:fonte];
    
    //Pega a primeira palavra do texto
    [primeiraLabel setText:[palavrasTexto objectAtIndex:0]];

    
    //Cria o array que guardará as label`s
    NSMutableArray *arrayLabel=[NSMutableArray array];
    
    //Adiciona a primeira label
    [arrayLabel addObject:primeiraLabel];
    
    for (int i=1; i<[palavrasTexto count]; i++) {
        //Pega a label que será trabalhada
        SKLabelNode *labelAnalizar=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
        
        //String da label anterior
        SKLabelNode *labelAnterior=[arrayLabel objectAtIndex:posLabelArray];
        
        //Contem a junçao do texto já adicionado na label + o a prox palavra do texto recebido
        NSString *juncaoTexto=[NSString stringWithFormat:@"%@ %@",[labelAnterior text],[palavrasTexto objectAtIndex:i]];
        
        //Adiciona a palavra no label
        [labelAnalizar setText:juncaoTexto];
        [labelAnalizar setFontSize:fonte];
        
        if (labelAnalizar.frame.size.width <limite.width - 30) {
            //Se mesmo com a nova palavra ainda couber no frame eu substituo a label do array
            [arrayLabel removeObjectAtIndex:posLabelArray];
            [arrayLabel insertObject:labelAnalizar atIndex:posLabelArray];
        }else{
            SKLabelNode *novaLabel=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];

            //Atualizo o texto do label texto, e o adiciono no array, atualizando a pos a ser analisada no prox for
            [novaLabel setText:[palavrasTexto objectAtIndex:i]];
            [novaLabel setFontSize:fonte];
            
            //Insere a nova label no array
            [arrayLabel addObject:novaLabel];
            posLabelArray++;
        }
    }
    
    self.labelstexto=arrayLabel;
}

-(void)adicionaTexto{
    CGFloat offSetX = self.frame.size.width * self.anchorPoint.x;
    CGFloat offSetY = self.frame.size.height * self.anchorPoint.y;
    CGPoint posicaoAdicionar=CGPointMake(0 - offSetX,0 + offSetY);
    //Depois adiciona a(s) label
    
    for (int i=0; i<[self.labelstexto count]; i++) {
        SKLabelNode *labelAdd=[self.labelstexto objectAtIndex:i];
        [labelAdd setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [labelAdd setVerticalAlignmentMode:SKLabelVerticalAlignmentModeBaseline];
        
        [labelAdd setName:nomeTexto];
        //[labelAdd setFontSize:130.0f];
        //Acerta a posicao das label
        posicaoAdicionar=CGPointMake(posicaoAdicionar.x, posicaoAdicionar.y-labelAdd.frame.size.height);
        
        [labelAdd setPosition:posicaoAdicionar];
        [self addChild:labelAdd];
    }
}

-(void)mudaCorTexto:(UIColor*)cor{
    for (SKLabelNode *label in [self children]) {
        [label setFontColor:cor];
    }
}

-(void)alinhaTextoHorizontal:(SKLabelHorizontalAlignmentMode)alinhamento{
    for (SKLabelNode *label in [self children]) {
        [label setPosition:CGPointMake(CGRectGetMidX(self.frame), label.position.y)];
        [label setHorizontalAlignmentMode:alinhamento];
    }
}

-(void)alinhaTextoVertical:(SKLabelVerticalAlignmentMode)alinhamento{
    for (SKLabelNode *label in [self children]) {
        //[label setPosition:CGPointMake(CGRectGetMidX(self.frame), label.position.y)];
        [label setVerticalAlignmentMode:alinhamento];
    }
}
@end
