//
//  DQMenuItem.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 23/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuItem.h"

@implementation DQMenuItem

@synthesize opcoesMenu,indexAtual;
-(id)initMenu{
    
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setName:@"Itens"];
        
        [self configuraTitulo];
        
        self.itensColuna=4;
        self.itensLinha=3;
        
        [self listarItens];
        [self exibeItens];
        
        [self setUserInteractionEnabled:YES];
        
    }
    return self;
}

-(void)configuraTitulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:50.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

//Lista os itens que o jogador tem disponivel
-(void)listarItens{
    
    self.jogador =[DQJogador sharedJogador];
    NSMutableArray *arrayItensAdicionar=[NSMutableArray array];
    NSArray *arrayItens=[self.jogador.itens arrayItensJogador];
    
    
    for (int i=0; i< [arrayItens count];i++) {
        //Criado para facilitar leitura
        NSString *itemSelecionado=[arrayItens objectAtIndex:i];
        
        NSString *nomeItem = [[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"nome"];
        
        NSString *descricaoItem = [[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"descricao"];
        
        NSString *categoriaItem = [[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"categoria"];
        
        NSString *imagemItem = [[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"imagem"];
        
        
        DQItem *itemAdicionadar=[[DQItem alloc]initItemNome:nomeItem descricao:descricaoItem categoria:categoriaItem imagem:imagemItem];
        
        [itemAdicionadar setQndeItem:[[self.jogador.itens.dicionarioDeItensJogador objectForKey:itemSelecionado]intValue]];
        
        [arrayItensAdicionar addObject:itemAdicionadar];
    }
    
    self.itens = arrayItensAdicionar;
}

-(void)exibeItens{
    CGVector ajustePosicao=CGVectorMake(90, 350);
    CGSize quadroItem=CGSizeMake(self.frame.size.width/4,self.frame.size.height/5);
    CGPoint posicaoNode=CGPointMake((CGRectGetMinX(self.frame)+ajustePosicao.dx), CGRectGetMaxY(self.frame)-ajustePosicao.dy);
    int posItem=0;
    
    
    for (int i=0; i<self.itensColuna; i++) {
        for (int j=0; j<self.itensLinha; j++) {
            
            if (posItem <[self.itens count]) {
                DQItem *itemMostrar=[self.itens objectAtIndex:posItem];
                
                [itemMostrar setAnchorPoint:CGPointMake(0, 0)];
                [itemMostrar setPosition:posicaoNode];
                [self addChild:itemMostrar];
                
                posicaoNode=CGPointMake((itemMostrar.position.x + quadroItem.width + 10), posicaoNode.y);
                posItem++;
            }
        }
        posicaoNode=CGPointMake(CGRectGetMinX(self.frame)+ajustePosicao.dx, posicaoNode.y - quadroItem.height - 10);
    }
}

-(void)exibeInformacoesItem:(DQItem*)itemExibir{
    
    [self addChild:[self criaCaixaInfoItem:itemExibir]];
    
    //Realca o item selecionado
    SKSpriteNode *destaqueItem=[SKSpriteNode spriteNodeWithImageNamed:@"MarcadorItens"];
    [destaqueItem setAnchorPoint:CGPointMake(0, 0)];
    [destaqueItem setPosition:CGPointMake(itemExibir.position.x, itemExibir.position.y)];
    [destaqueItem setName:@"Destaque"];
    
    [self addChild:destaqueItem];
}

-(SKSpriteNode*)criaCaixaInfoItem:(DQItem*)itemExibir{
    
    SKSpriteNode *detalheItem=[SKSpriteNode spriteNodeWithImageNamed:@"FundoDetalheItem.png"];
    [detalheItem setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [detalheItem setName:@"DetalheItem"];
    
    CGSize sizeNome=CGSizeMake(detalheItem.frame.size.width-60, 70);
    DQTexto *nome=[[DQTexto alloc]initTexto:[itemExibir nome] espacoLimite:sizeNome fonte:30.0];
    [nome alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    [nome mudaCorTexto:[UIColor blackColor]];

    CGSize sizeCategoria=CGSizeMake(detalheItem.frame.size.width-60, 60);
    DQTexto *categoria=[[DQTexto alloc]initTexto:[itemExibir categoria] espacoLimite:sizeCategoria fonte:30.0f];
    [categoria alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    [categoria mudaCorTexto:[UIColor blackColor]];
    
    CGSize sizeDescricaoItem=CGSizeMake(detalheItem.frame.size.width-70, 250);
    DQTexto *descricao=[[DQTexto alloc]initTexto:[itemExibir descricao] espacoLimite:sizeDescricaoItem fonte:30.0f];
    [descricao mudaCorTexto:[UIColor blackColor]];
    
    [detalheItem addChild:nome];
    [detalheItem addChild:categoria];
    [detalheItem addChild:descricao];
    
    [nome setPosition:CGPointMake(CGRectGetMidX(detalheItem.frame),CGRectGetMaxY(detalheItem.frame)-50)];
    [categoria setPosition:CGPointMake(nome.position.x, nome.position.y - 65)];
    [descricao setPosition:CGPointMake(categoria.position.x, categoria.position.y-160)];
    

    [detalheItem setScale:1.5f];
    [detalheItem setZPosition:100];
    return detalheItem;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([self childNodeWithName:@"DetalheItem"]) {
        [[self childNodeWithName:@"DetalheItem"]removeFromParent];
        [[self childNodeWithName:@"Destaque"]removeFromParent];
    }else{
        CGPoint posToque=[[touches anyObject]locationInNode:self];
        NSArray *arrayNodes=[self nodesAtPoint:posToque];
        
        for(int i=0;i<[arrayNodes count];i++){
            if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQItem class]]) {
                DQItem *itemTocado=[arrayNodes objectAtIndex:i];
                
                [self exibeInformacoesItem:itemTocado];
                i= (int)[arrayNodes count];
            }
        }
        
        if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
            [self removeFromParent];
        }
    }
}

-(void)esconderMenu{
    [self removeFromParent];
}
@end
