//
//  DQMenuArmadilhas.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMenuArmadilhas.h"

@implementation DQMenuArmadilhas

-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setName:@"Armadilhas"];
        self.itensColuna=4;
        self.itensLinha=3;
        
        
        [self setUserInteractionEnabled:YES];
        
    }
    return self;
    
}
-(void)prepararExibicao{
    [self removeAllChildren];
    [self configuraTitulo];
    [self listarArmadilhas];
    [self exibeArmadilhas];
}

-(void)listarArmadilhas{
    
    self.jogador =[DQJogador sharedJogador];
    NSMutableArray *arrayArmadilhasAdicionar=[NSMutableArray array];
    NSArray *arrayItens=[self.jogador.armadilhas arrayArmadilhasJogador];
    
    
    for (int i=0; i< [arrayItens count];i++) {
        //Criado para facilitar leitura
        NSString *itemSelecionado=[arrayItens objectAtIndex:i];
        
        NSString *nomeArmadilha= [[self.jogador.armadilhas.dicionarioDeArmadilhasReferencia objectForKey:itemSelecionado] objectForKey:@"nome"];
        
        NSString *descricaoArmadilha = [[self.jogador.armadilhas.dicionarioDeArmadilhasReferencia objectForKey:itemSelecionado] objectForKey:@"descricao"];
        
        
        
        NSString *imagemArmadilha = [[self.jogador.armadilhas.dicionarioDeArmadilhasReferencia objectForKey:itemSelecionado] objectForKey:@"imagem"];
        
        DQArmadilha *armadilha =[[DQArmadilha alloc]initArmadilhaNome:nomeArmadilha descricao:descricaoArmadilha imagem:imagemArmadilha];
        
        [arrayArmadilhasAdicionar addObject:armadilha];
    }
    
    self.armadilhas = arrayArmadilhasAdicionar;
}
-(void)exibeArmadilhas{
    CGVector ajustePosicao=CGVectorMake(90, 350);
    CGSize quadroItem=CGSizeMake(self.frame.size.width/4,self.frame.size.height/5);
    CGPoint posicaoNode=CGPointMake((CGRectGetMinX(self.frame)+ajustePosicao.dx), CGRectGetMaxY(self.frame)-ajustePosicao.dy);
    int posItem=0;
    
    
    for (int i=0; i<self.itensColuna; i++) {
        for (int j=0; j<self.itensLinha; j++) {
            
            if (posItem <[self.armadilhas count]) {
                DQArmadilha *armadilhaMostrar=[self.armadilhas objectAtIndex:posItem];
                
                [armadilhaMostrar setAnchorPoint:CGPointMake(0, 0)];
                [armadilhaMostrar setPosition:posicaoNode];
                
                
                [self addChild:armadilhaMostrar];
                
                posicaoNode=CGPointMake((armadilhaMostrar.position.x + quadroItem.width + 10), posicaoNode.y);
                posItem++;
            }
            
        }
        posicaoNode=CGPointMake(CGRectGetMinX(self.frame)+ajustePosicao.dx, posicaoNode.y - quadroItem.height - 10);
    }
}
-(void)exibeInformacoesArmadilha:(DQArmadilha*)armadilhaExibir{
    
    [self addChild:[self criaCaixaInfoArmadilha:armadilhaExibir]];
    
    //Realca o item selecionado
    SKSpriteNode *destaqueArmadilha=[SKSpriteNode spriteNodeWithImageNamed:@"MarcadorItens"];
    [destaqueArmadilha setAnchorPoint:CGPointMake(0, 0)];
    [destaqueArmadilha setPosition:CGPointMake(armadilhaExibir.position.x, armadilhaExibir.position.y)];
    [destaqueArmadilha setName:@"Destaque"];
    
    [self addChild:destaqueArmadilha];
}

-(SKSpriteNode*)criaCaixaInfoArmadilha:(DQArmadilha*)armadilhaExibir{
    
    SKSpriteNode *detalheArmadilha=[SKSpriteNode spriteNodeWithImageNamed:@"FundoDetalheItem.png"];
    [detalheArmadilha setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [detalheArmadilha setName:@"DetalheArmadilha"];
    
    CGSize sizeNome=CGSizeMake(detalheArmadilha.frame.size.width-60, 70);
    DQTexto *nome=[[DQTexto alloc]initTexto:[armadilhaExibir nome] espacoLimite:sizeNome fonte:30.0];
    [nome alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    [nome mudaCorTexto:[UIColor blackColor]];
    
    CGSize sizeDescricaoItem=CGSizeMake(detalheArmadilha.frame.size.width-70, 250);
    DQTexto *descricao=[[DQTexto alloc]initTexto:[armadilhaExibir descricao] espacoLimite:sizeDescricaoItem fonte:30.0f];
    [descricao mudaCorTexto:[UIColor blackColor]];
    
    [detalheArmadilha addChild:nome];
    [detalheArmadilha addChild:descricao];
    
    [nome setPosition:CGPointMake(CGRectGetMidX(detalheArmadilha.frame),CGRectGetMaxY(detalheArmadilha.frame)-50)];
    
    [descricao setPosition:CGPointMake(nome.position.x, nome.position.y-225)];
    SKSpriteNode *botaoUsar = [SKSpriteNode spriteNodeWithImageNamed:@"FundoOpcao"];
    [botaoUsar setName:@"Usar"];
    [botaoUsar setSize:CGSizeMake(125, 50)];
    
    [botaoUsar setPosition:CGPointMake(descricao.position.x, descricao.position.y-50)];
    
    SKLabelNode *tituloBotao = [[SKLabelNode alloc]initWithFontNamed:[DQConfigMenu fonteMenu]];
    [tituloBotao setText:@"Usar"];
    [tituloBotao setFontSize:40];
    [tituloBotao setPosition:CGPointMake(2, -10)];
    [botaoUsar addChild:tituloBotao];
    
    [detalheArmadilha addChild:botaoUsar];
    
    [detalheArmadilha setScale:1.5f];
    [detalheArmadilha setZPosition:100];
    return detalheArmadilha;
}


-(void)configuraTitulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:50.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    for(int i=0;i<[arrayNodes count];i++){
        if ([[[arrayNodes objectAtIndex:i]name] isEqual:@"Usar"] ) {
            NSLog(@"foi");
            i = (int)[arrayNodes count];
        }
    }
    if ([self childNodeWithName:@"DetalheArmadilha"]) {
        [[self childNodeWithName:@"DetalheArmadilha"]removeFromParent];
        [[self childNodeWithName:@"Destaque"]removeFromParent];
    }
    else{
        for(int i=0;i<[arrayNodes count];i++){
            if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQArmadilha class]]) {
                DQArmadilha *ArmadilhaTocada=[arrayNodes objectAtIndex:i];
                
                [self exibeInformacoesArmadilha:ArmadilhaTocada];
                i = (int)[arrayNodes count];
            }
        }
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self removeFromParent];
    }
    
}

-(void)esconderMenu{
    [self removeFromParent];
}



@end
