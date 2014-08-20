
//
//  DQReceitaQuimica.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQReceitaQuimica.h"

@implementation DQReceitaQuimica

-(id)initComDicionarioDaReceita: (NSDictionary *)receita eTamanho:(CGSize)tamanhoMaleta;
{
    if(self = [super initWithImageNamed:@"papelReceita"]){
        //Redimensiona o tamanho do sprite
        self.size = CGSizeMake(tamanhoMaleta.width * 0.348, tamanhoMaleta.height * 0.32);
        
        
        
        //CRIA O TITULO DA RECEITA
            //cria
        SKLabelNode *labelTituloReceita = [[SKLabelNode alloc] init];
            //especificações da fonte
        labelTituloReceita.text = [receita objectForKey:@"Nome"];
        labelTituloReceita.fontSize = 24;
        labelTituloReceita.fontColor = [UIColor blackColor];
        labelTituloReceita.fontName = @"Chalkduster";
            //especificações da posição
        labelTituloReceita.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        labelTituloReceita.position = CGPointMake(self.frame.size.width * 0.15, self.frame.size.height * 0.6);
            //adiciona
        [self addChild:labelTituloReceita];
        
        
        
        //CRIA OS INGREDIENTES (TODO - melhorar para quando tiver mais de 2 ingredientes)
            //1
                //cria
            self.labelIngrediente1 = [[SKLabelNode alloc] init];
                //especificações da fonte
            self.labelIngrediente1.text = [[receita objectForKey:@"Ingredientes"]objectAtIndex:0];
            self.labelIngrediente1.fontSize = 14;
            self.labelIngrediente1.fontColor = [UIColor blackColor];
            self.labelIngrediente1.fontName = @"Chalkduster";
                //informações da posição.
            self.labelIngrediente1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            self.labelIngrediente1.position = CGPointMake(self.frame.size.width * 0.25, self.frame.size.height * 0.44);
                //adiciona
            [self addChild:self.labelIngrediente1];
        
            //2
                //cria
            self.labelIngrediente2 = [[SKLabelNode alloc] init];
                //especificações da fonte
            self.labelIngrediente2.text = [[receita objectForKey:@"Ingredientes"]objectAtIndex:1];
            self.labelIngrediente2.fontSize = 14;
            self.labelIngrediente2.fontColor = [UIColor blackColor];
            self.labelIngrediente2.fontName = @"Chalkduster";
                //informações da posição.
            self.labelIngrediente2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            self.labelIngrediente2.position = CGPointMake(self.frame.size.width * 0.25, self.frame.size.height * 0.34);
                //adiciona
            [self addChild:self.labelIngrediente2];
        
        
        
        //COLOCA O RISCO DE OK AO LADO DOS INGREDIENTES
        self.ingredienteConfirmado1 = NO;
        self.ingredienteConfirmado2 = NO;
            //1
        self.spriteConfirmacao1 = [[SKSpriteNode alloc]initWithImageNamed:@"ok"];
        self.spriteConfirmacao1.anchorPoint = CGPointZero;
        self.spriteConfirmacao1.position = CGPointMake(self.frame.size.width * 0.75, self.frame.size.height * 0.44);
        self.spriteConfirmacao1.size = CGSizeMake(25, 25);
        self.spriteConfirmacao1.alpha = 0;
        [self addChild:self.spriteConfirmacao1];
            //2
        self.spriteConfirmacao2 = [[SKSpriteNode alloc]initWithImageNamed:@"ok"];
        self.spriteConfirmacao2.anchorPoint = CGPointZero;
        self.spriteConfirmacao2.position = CGPointMake(self.frame.size.width * 0.75, self.frame.size.height * 0.34);
        self.spriteConfirmacao2.size = CGSizeMake(25, 25);
        self.spriteConfirmacao2.alpha = 0;
        [self addChild:self.spriteConfirmacao2];
        
    }
    
    return self;
}

-(void)confirmaIngrediente: (int)ingrediente
{
    if(ingrediente == 1){
        self.ingredienteConfirmado1 = YES;
        self.spriteConfirmacao1.alpha = 1;
    }
    else if(ingrediente == 2){
        self.ingredienteConfirmado2 = YES;
        self.spriteConfirmacao2.alpha = 1;
    }
}


-(void)desconfirmaIngrediente: (int)ingrediente
{
    if(ingrediente == 1){
        self.ingredienteConfirmado1 = NO;
        self.spriteConfirmacao1.alpha = 0;
    }
    else if(ingrediente == 2){
        self.ingredienteConfirmado2 = NO;
        self.spriteConfirmacao2.alpha = 0;
    }
}

@end
