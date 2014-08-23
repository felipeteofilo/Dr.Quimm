//
//  DQMaletaQuimica.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMaletaQuimica.h"

@implementation DQMaletaQuimica

-(id)initComTamanho: (CGSize)tamanho eDicionarioDaReceita:(NSDictionary *)receita
{
    if(self = [super initWithColor:[UIColor blackColor] size:CGSizeMake(tamanho.width * 0.9, tamanho.height * 0.9)])
    {
        //Ajusta algumas particularidades do SKSpriteNode geral - um quadrado preto que ocupa o 90% da tela
        self.anchorPoint = CGPointZero;
        
        //Cria a imagem de fundo da maleta
        SKSpriteNode *fundo = [[SKSpriteNode alloc] initWithImageNamed:@"fundoMaleta"];
        fundo.anchorPoint = CGPointZero;
        fundo.size = self.frame.size;
        fundo.position = CGPointZero;
        [self addChild:fundo];
        
        //Cria o corpo da maleta
        [self criarMaletaCorpo];
        
        //CRIANDO AS AMOSTRAS
        //Referencia o array das amostras -- Plist
            NSString *url = [[NSBundle mainBundle] pathForResource:@"AmostrasQuimicas" ofType:@"plist"];
            self.arrayDeReferenciaDeAmostras = [[NSArray alloc]initWithContentsOfFile:url];
        //Cria as amostras nas posições corretas
        [self criarAmostras];
        
        //Cria a frente da maleta
        [self criarMaletaFrente];
        
        //Cria o papel de receitas
        self.dicionarioReceita = [[NSDictionary alloc] initWithDictionary:receita];
        [self criarPapelReceitas];
        
        //Cria a instrução de "selecione os ingredientes" e "continue" (deixando o continue apagado)
        [self criarInstrucao];
    }
    
    return self;
}

-(void)criarMaletaCorpo
{
    SKSpriteNode *maletaCorpo = [[SKSpriteNode alloc]initWithImageNamed:@"maletaCorpo"];
    maletaCorpo.anchorPoint = CGPointZero;
    maletaCorpo.size = CGSizeMake(self.size.width, self.size.height * 0.79);
    maletaCorpo.position = CGPointMake(0, self.size.height * 0.2);
    [self addChild:maletaCorpo];
}

-(void)criarMaletaFrente
{
    SKSpriteNode *maletaFente = [[SKSpriteNode alloc]initWithImageNamed:@"maletaFrente"];
    maletaFente.anchorPoint = CGPointZero;
    maletaFente.size = CGSizeMake(self.size.width, self.size.height * 0.22);
    maletaFente.position = CGPointMake(0, 0);
    [self addChild:maletaFente];
}

-(void)criarPapelReceitas
{
    //Cria o papel da receita, passando o dicionario da receita atual e o tamanho da maleta (90% da tela real)
    self.receitaAtual = [[DQReceitaQuimica alloc]initComDicionarioDaReceita:self.dicionarioReceita eTamanho:self.frame.size];
    
    //coloca ele na posição correta
    self.receitaAtual.anchorPoint = CGPointZero;
    self.receitaAtual.position = CGPointMake(self.frame.size.width * 0.545, self.frame.size.height * 0.55);
    [self addChild:self.receitaAtual];
}

-(void)criarAmostras
{
    //inicia o array de amostras
    self.arrayDeAmostras = [[NSMutableArray alloc]init];
    
    //Para cada amostra no array de referência de amostras
    for(int i = 0; i < [self.arrayDeReferenciaDeAmostras count]; i++){
        //Cria uma amostra temporária
        DQAmostraQuimica *amostraTemporaria = [[DQAmostraQuimica alloc]initComDicionario:[self.arrayDeReferenciaDeAmostras objectAtIndex:i]];
        
        //e a adiciona ao array de amostras
        [self.arrayDeAmostras addObject:amostraTemporaria];
    }
    
    //coloca as amostras do array dentro da maleta
    [self adicionarAmostrasNaMaleta];
}

-(void)adicionarAmostrasNaMaleta
{
    float frenteX = self.frame.size.width * 0.06; //amostras de 6 a 12
    float frenteY = self.frame.size.height * 0.13; //amostras de 6 a 12
    
    float atrasX = self.frame.size.width * 0.12; //amostras de 0 a 5
    float atrasY = self.frame.size.height * 0.255; //amostras de 0 a 5
    
    float larguraDaAmostra = 116;
    
    //Passa uma a uma, adicionando no sprite geral e posicionando de acordo com a porcentagem
    for(int i = 0; i < [self.arrayDeAmostras count]; i++)
    {
        //amostras de frente - 7 amostras
        if(i >= 6){
            [[self.arrayDeAmostras objectAtIndex:i] setPosition:CGPointMake(frenteX + (larguraDaAmostra * (i - 6)), frenteY)];
        }
        //amostras da trás - 6 amostras
        else{
            [[self.arrayDeAmostras objectAtIndex:i] setPosition:CGPointMake(atrasX + (larguraDaAmostra * i), atrasY)];
        }
        
        [self addChild:[self.arrayDeAmostras objectAtIndex:i]];
    }
}

-(void)criarInstrucao
{
    //adiciona o primeiro
    self.labelInstrucao1 = [[SKLabelNode alloc]init];
    self.labelInstrucao1.text = @"Selecione os";
    self.labelInstrucao1.fontColor = [UIColor blackColor];
    self.labelInstrucao1.fontSize = 60;
    self.labelInstrucao1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    self.labelInstrucao1.position = CGPointMake(self.frame.size.width * 0.15, self.frame.size.height * 0.75);
    [self addChild:self.labelInstrucao1];
    
    //adiciona o segundo
    self.labelInstrucao2 = [[SKLabelNode alloc]init];
    self.labelInstrucao2.text = @"ingredientes";
    self.labelInstrucao2.fontColor = [UIColor blackColor];
    self.labelInstrucao2.fontSize = 60;
    self.labelInstrucao2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    self.labelInstrucao2.position = CGPointMake(self.frame.size.width * 0.16, self.frame.size.height * 0.67);
    [self addChild:self.labelInstrucao2];
}

@end
