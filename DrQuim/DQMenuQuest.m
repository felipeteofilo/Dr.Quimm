//
//  DQMenuQuest.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 28/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuQuest.h"

@implementation DQMenuQuest

-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        [self setName:@"Missões"];
        
        [self configuraTitulo];
        [self listarMissoesJogador];
        [self configuraOpcoesMenuQuest];
    }
    return self;
}

-(void)configuraTitulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:90.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

-(void)configuraNavegacao{
    
}
-(void)navegacao{
    
}
-(void)listarMissoesJogador{
    NSMutableArray *missoesJogador=[NSMutableArray arrayWithArray:[DQReferenciaMissaoJogador arquivoPlist:[DQReferenciaMissaoJogador pathArquivoMissoesJogador]]];
    
    //Remove a missao 0 - Sem missao
    [missoesJogador removeObjectAtIndex:0];
    
    self.opcoesMenu=missoesJogador;
}
-(void)configuraOpcoesMenuQuest{
    float ultimoY=self.titulo.frame.size.height+self.titulo.position.y +500;
    
    for (int i=0; i< [self.opcoesMenu count]; i++) {
        
        //Diminuir o tamanho do nome p facilitar
        NSString *titulo = [[self.opcoesMenu objectAtIndex:i]objectForKey:@"Nome"];
        NSArray *array = [titulo componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
        titulo=[array objectAtIndex:1];
        
        DQOpcaoMenu *opcaoMenu=[[DQOpcaoMenu alloc]initOpcaoTitulo:titulo];
        [opcaoMenu setAnchorPoint:CGPointMake(0.5, 0)];
        [opcaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height - ultimoY)];
        
        [opcaoMenu configuraConteudoQuest:[DQReferenciaMissaoJogador detalharMissaoAtual:i+1]index:i];
        
        [opcaoMenu setName:@"Missao"];
        
        ultimoY= ultimoY + opcaoMenu.frame.size.height + 20;
        [self addChild:opcaoMenu];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    [self.detalheQuest removeFromParent];
    
    for(int i=0;i<[arrayNodes count];i++){
        if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQOpcaoMenu class]]) {
            DQOpcaoMenu *opcaoTocada=[arrayNodes objectAtIndex:i];
            
            [self detalharQuest:opcaoTocada.conteudo.userData];
            i= [arrayNodes count];
            
        }
    }
    
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
}

-(void)controlaNavegacaoMenu{
    
}

-(void)esconderMenu{
    [self removeFromParent];
}

-(void)realcarMenu{
    return;
}

-(void)detalharQuest:(NSDictionary*)missao{
    self.detalheQuest=[SKSpriteNode spriteNodeWithImageNamed:@"FundoQuestDetalhe"];
    [self.detalheQuest setName:@"DetalheQuest"];
    [self.detalheQuest setAlpha:1.0f];
    
    CGSize sizeNome=CGSizeMake(self.detalheQuest.frame.size.width-80, 100);
    DQTexto *nome=[[DQTexto alloc]initTexto:[missao objectForKey:@"Nome"] espacoLimite:sizeNome fonte:45.5f];
    [nome setAnchorPoint:CGPointMake(0, 1)];
    
    CGSize sizeObjetivoAtual=CGSizeMake(sizeNome.width, 500);
    DQTexto *objectivoAtual=[[DQTexto alloc]initTexto:[NSString stringWithFormat:@"Objetivo Atual: %@",[missao objectForKey:@"Objetivo Atual"]] espacoLimite:sizeObjetivoAtual fonte:35.0f];
    
    CGSize sizeRecompensa=CGSizeMake(sizeObjetivoAtual.width, 50);
    DQTexto *recompensa=[[DQTexto alloc]initTexto:[NSString stringWithFormat:@"Recompensa: %@",[missao objectForKey:@"Recompensa"]] espacoLimite:sizeRecompensa fonte:30.0f];
    
    NSNumber *respeitoGanhar=[missao objectForKey:@"Respeito"];
    
    CGSize sizeRespeito=CGSizeMake(sizeNome.width, 50);
    DQTexto *respeito=[[DQTexto alloc]initTexto:[NSString stringWithFormat:@"Respeito: +%i",[respeitoGanhar intValue]] espacoLimite:sizeRespeito fonte:30.0f];
    
    [self addChild:self.detalheQuest];
    [self.detalheQuest addChild:nome];
    [self.detalheQuest addChild:objectivoAtual];
    [self.detalheQuest addChild:recompensa];
    [self.detalheQuest addChild:respeito];
    
    [nome setPosition:CGPointMake(CGRectGetMidX(self.detalheQuest.frame), CGRectGetMaxY(self.detalheQuest.frame)-150)];
    [objectivoAtual setPosition:CGPointMake(CGRectGetMinX(self.detalheQuest.frame)+(CGRectGetWidth(self.detalheQuest.frame)/2), nome.position.y - nome.size.height - (CGRectGetHeight(objectivoAtual.frame)/2))];
    
    [respeito setPosition:CGPointMake(objectivoAtual.position.x-10, CGRectGetMinY(self.detalheQuest.frame)+respeito.frame.size.height)];
    [recompensa setPosition:CGPointMake(respeito.position.x, respeito.position.y +30)];
    
    //Configura as cores
    [nome mudaCorTexto:[UIColor blackColor]];
    [objectivoAtual mudaCorTexto:[UIColor blackColor]];
    [respeito mudaCorTexto:[UIColor blackColor]];
    [recompensa mudaCorTexto:[UIColor blackColor]];
}
@end
