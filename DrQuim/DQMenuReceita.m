//
//  DQMenuReceita.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuReceita.h"

@implementation DQMenuReceita

-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        [self setName:@"Livro de Receitas"];
        [self configuraTitulo];
        [self recuperarReceita];
        [self exibirOpcoes];
    }
    return self;
}

-(void)configuraTitulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:85.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

-(void)recuperarReceita{
    self.opcoesMenu=[NSArray arrayWithArray:[DQControleReceita receitasConfiguradas]];
}
-(void)exibirOpcoes{
    float ultimoY=self.titulo.frame.size.height+self.titulo.position.y +500;
    
    for (int i=0; i< [self.opcoesMenu count]; i++) {
        
        //Diminuir o tamanho do nome p facilitar
        NSString *titulo = [[self.opcoesMenu objectAtIndex:i]objectForKey:@"Nome"];
        
        DQOpcaoMenu *opcaoMenu=[[DQOpcaoMenu alloc]initOpcaoTitulo:titulo];
        [opcaoMenu setAnchorPoint:CGPointMake(0.5, 0)];
        [opcaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height - ultimoY)];
        
        [opcaoMenu configuraConteudoReceita:[self.opcoesMenu objectAtIndex:i]  index:i];
        
        ultimoY= ultimoY + opcaoMenu.frame.size.height + 20;
        [self addChild:opcaoMenu];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    [self.detalheReceita removeFromParent];
    
    for(int i=0;i<[arrayNodes count];i++){
        if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQOpcaoMenu class]]) {
            DQOpcaoMenu *opcaoTocada=[arrayNodes objectAtIndex:i];
            
            [self detalharReceita:opcaoTocada.conteudo.userData];
            NSNumber *indexOpcao=[opcaoTocada.conteudo.userData objectForKey:@"indexOpcao"];

            //Será util ao fazer a navegacao
            [self setIndexSelecionado:[indexOpcao intValue]];
            
            i= [arrayNodes count];
            
        }
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
}

-(void)detalharReceita:(NSDictionary*)receita{
    self.detalheReceita=[SKSpriteNode spriteNodeWithImageNamed:@"FundoQuestDetalhe"];
    [self.detalheReceita setName:@"DetalheReceita"];

    CGSize sizeNome=CGSizeMake(self.detalheReceita.frame.size.width-80, 100);
    DQTexto *nome=[[DQTexto alloc]initTexto:[receita objectForKey:@"Nome"] espacoLimite:sizeNome fonte:45.5f];
    [nome alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    
    //Altera a cor da fonte
    [nome mudaCorTexto:[UIColor blackColor]];

    
    NSArray *array=[NSArray arrayWithArray:[receita objectForKey:@"Ingredientes"]];
    
    CGSize sizeTexto=CGSizeMake(self.detalheReceita.frame.size.width-80,60);
    
    //Adiciona os nodes
    [self addChild:self.detalheReceita];
    [self.detalheReceita addChild:nome];
    
    //Posiciona os nodes
    [nome setPosition:CGPointMake(CGRectGetMidX(self.detalheReceita.frame), CGRectGetMaxY(self.detalheReceita.frame)-150)];
    
    
    CGPoint posTexto= CGPointMake(nome.position.x, nome.position.y-nome.size.height + 30);
    
    //For para os ingredientes
    for (NSString *strIngrediente in array) {
        DQTexto *ingrediente=[[DQTexto alloc]initTexto:strIngrediente espacoLimite:sizeTexto fonte:30.0];
        
        [ingrediente setPosition:posTexto];
        
        [ingrediente alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
        [ingrediente mudaCorTexto:[UIColor blackColor]];
        
        //Atualiza a posicao
        posTexto=CGPointMake(posTexto.x, posTexto.y - ingrediente.size.height);
        
        [self.detalheReceita addChild:ingrediente];
    }
    
    //Da um espaco entre as frases
    posTexto=CGPointMake(posTexto.x, posTexto.y-40);
    
    //Adiciona um titulo p requisitos
    SKLabelNode *requer=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    [requer setText:@"Requer: "];
    [requer setFontSize:45.5f];
    [requer setFontColor:[UIColor blackColor]];
    
    [requer setPosition:posTexto];
    
    [self.detalheReceita addChild:requer];
    
    //Mais espaco entre as frases p eh hora dos requisitos
    posTexto=CGPointMake(posTexto.x, posTexto.y-requer.frame.size.height-20);
    
    //FOR para os requisitos
    array=[NSArray arrayWithArray:[receita objectForKey:@"Requisitos"]];

    for (NSString *strRequisito in array) {
        DQTexto *requisito=[[DQTexto alloc]initTexto:strRequisito espacoLimite:sizeTexto fonte:30.0];
        
        [requisito setPosition:posTexto];
        
        [requisito alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
        [requisito mudaCorTexto:[UIColor blackColor]];
        
        //Atualiza a posicao
        posTexto=CGPointMake(posTexto.x, posTexto.y - requisito.size.height);
        
        [self.detalheReceita addChild:requisito];
    }
    
}

-(void)esconderMenu{
    [self removeFromParent];
}

@end
