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
        self.lugaresArmados = [[NSMutableDictionary alloc]init];
        [self setUserInteractionEnabled:YES];
        
    }
    return self;
    
}

-(void)atualizarChance{
    self.chance= arc4random()%60;
    
    float animal = arc4random()%[[[[self.scene userData]objectForKey:@"ConfigParte"]objectForKey:@"Animais"]count]-1;
    self.chanceAtual =[NSString stringWithFormat:@"Chance %.0f %%",self.chance];
    self.animalAtual =[[[[self.scene userData]objectForKey:@"ConfigParte"]objectForKey:@"Animais"]objectAtIndex:animal];
    
    
}

-(void)prepararExibicao{
    [self removeAllChildren];
    [self configuraTitulo:self.name];
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
        NSString *imagemFundo = [[self.jogador.armadilhas.dicionarioDeArmadilhasReferencia objectForKey:itemSelecionado] objectForKey:@"ImagemFundo"];
        NSString *animacao = [[self.jogador.armadilhas.dicionarioDeArmadilhasReferencia objectForKey:itemSelecionado] objectForKey:@"Animacao"];
        
        DQArmadilha *armadilha =[[DQArmadilha alloc]initArmadilhaNome:nomeArmadilha descricao:descricaoArmadilha imagem:imagemArmadilha fundo:imagemFundo animacao:animacao];
        
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
    if ([[[[self.scene userData]objectForKey:@"ConfigParte"]objectForKey:@"Animais"]count] > 0 ) {
        
        if (self.parteAtual !=[[[[self.scene userData]objectForKey:@"ConfigParte"]objectForKey:@"Parte"]intValue] ) {
            self.parteAtual =[[[self.scene userData]objectForKey:@"Parte"]intValue];
            [self atualizarChance];
        }
    }
    
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
    
    CGSize sizeCategoria=CGSizeMake(detalheArmadilha.frame.size.width-60, 60);
    DQTexto *chance=[[DQTexto alloc]initTexto:self.chanceAtual espacoLimite:sizeCategoria fonte:30.0f];
    [chance alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    [chance mudaCorTexto:[UIColor blackColor]];

    
    CGSize sizeDescricaoItem=CGSizeMake(detalheArmadilha.frame.size.width-70, 250);
    DQTexto *descricao=[[DQTexto alloc]initTexto:[armadilhaExibir descricao] espacoLimite:sizeDescricaoItem fonte:30.0f];
    [descricao mudaCorTexto:[UIColor blackColor]];
    
    [detalheArmadilha addChild:nome];
    [detalheArmadilha addChild:chance];
    [detalheArmadilha addChild:descricao];
    
    [nome setPosition:CGPointMake(CGRectGetMidX(detalheArmadilha.frame),CGRectGetMaxY(detalheArmadilha.frame)-50)];
    [chance setPosition:CGPointMake(nome.position.x, nome.position.y - 65)];
    [descricao setPosition:CGPointMake(chance.position.x, chance.position.y-160)];
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
-(void)listarItens{
    [self removeAllChildren];
    [self configuraTitulo:@"Iscas"];
    self.jogador =[DQJogador sharedJogador];
    NSMutableArray *arrayItensAdicionar=[NSMutableArray array];
    NSArray *arrayItens=[self.jogador.itens arrayItensJogador];
    
    
    for (int i=0; i< [arrayItens count];i++) {
        //Criado para facilitar leitura
        NSString *itemSelecionado=[arrayItens objectAtIndex:i];
        
        if ([[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"Isca"]) {
            NSString *nomeItem = [[[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado]objectForKey:@"Isca"] objectForKey:@"Nome"];
            
            NSString *caracteristica = [[[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado]objectForKey:@"Isca"] objectForKey:@"Caracteristica"];
            
            NSString *imagemItem = [[self.jogador.itens.dicionarioDeItensReferencia objectForKey:itemSelecionado] objectForKey:@"imagem"];
            
            int quantidade = [[self.jogador.itens.dicionarioDeItensJogador objectForKey:itemSelecionado]intValue];
            
            DQItem *itemAdicionadar=[[DQItem alloc]initItemNome:nomeItem descricao:caracteristica categoria:@"" imagem:imagemItem Quantidade:quantidade];
            
            [arrayItensAdicionar addObject:itemAdicionadar];
        }
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
                SKLabelNode *quantidade = [[SKLabelNode alloc]init];
                [quantidade setText:[NSString stringWithFormat:@"%d",itemMostrar.qndeItem]];
                [quantidade setColor:[UIColor whiteColor]];
                [quantidade setFontSize:45];
                
                [quantidade setPosition:CGPointMake(itemMostrar.position.x + 180, itemMostrar.position.y + 35)];
                
                
                [self addChild:quantidade];
                [self addChild:itemMostrar];
                
                posicaoNode=CGPointMake((itemMostrar.position.x + quadroItem.width + 10), posicaoNode.y);
                posItem++;
            }
        }
        posicaoNode=CGPointMake(CGRectGetMinX(self.frame)+ajustePosicao.dx, posicaoNode.y - quadroItem.height - 10);
    }
}


-(void)configuraTitulo :(NSString*)titulo{
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:titulo];
    [self.titulo setFontSize:50.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

-(void)mensagemDeErro :(NSString*)erro{
    [[self childNodeWithName:@"DetalheArmadilha"]removeFromParent];
    [[self childNodeWithName:@"Destaque"]removeFromParent];
    SKSpriteNode *mensagemDeErro=[SKSpriteNode spriteNodeWithImageNamed:@"FundoDetalheItem.png"];
    [mensagemDeErro setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [mensagemDeErro setName:@"DetalheArmadilha"];
    
    
    
    CGSize sizeCategoria=CGSizeMake(mensagemDeErro.frame.size.width-60, 60);
    
    
    DQTexto *erroDado=[[DQTexto alloc]initTexto:erro espacoLimite:sizeCategoria fonte:30.0f];
    [erroDado alinhaTextoHorizontal:SKLabelHorizontalAlignmentModeCenter];
    [erroDado mudaCorTexto:[UIColor blackColor]];
    [erroDado setPosition:CGPointMake(CGRectGetMidX(mensagemDeErro.frame), CGRectGetMaxY(mensagemDeErro.frame)-80)];
    
    CGSize sizeDescricaoErro=CGSizeMake(mensagemDeErro.frame.size.width-70, 250);
    NSString *mensagem = @"Você nao pode armar uma armadilha aqui";
    DQTexto *descricao=[[DQTexto alloc]initTexto:mensagem espacoLimite:sizeDescricaoErro fonte:30.0f];
    [descricao mudaCorTexto:[UIColor blackColor]];
    [descricao setPosition:CGPointMake(erroDado.position.x, erroDado.position.y-185)];
    
    
    
    [mensagemDeErro addChild:erroDado];
    [mensagemDeErro addChild:descricao];
    [self addChild:mensagemDeErro];
}


-(void)armarArmadilha{
    
    
    NSString *keyDaParte = [NSString stringWithFormat:@"%d",self.parteAtual];
    
    if ([[[[self.scene userData]objectForKey:@"ConfigParte"]objectForKey:@"Animais"]count] <= 0 ) {
        [self mensagemDeErro:@"Sem Animais Próximos"];
        return;
    }
    if ([[self.lugaresArmados objectForKey:keyDaParte]boolValue]) {
        [self mensagemDeErro:@"Lugar Já Usado"];
        return;
    }
    
    
    NSNumber *colocouArmadilha = [NSNumber numberWithBool:YES];
    [self.lugaresArmados setObject:colocouArmadilha forKey:keyDaParte];
    
    [self listarItens];
    [self exibeItens];
}

-(void)armadilhaArmada :(DQItem*)isca{
    
    DQIsca * iscaEscolhida = [[DQIsca alloc]initIsca:isca.nome Caracterisca:isca.descricao Imagem:isca.texture];
    
    
    
    DQArmadilhaAnimacao *animacao = [[DQArmadilhaAnimacao alloc]initArmadilha:self.armadilhaSelecionada animal:@"Coelho" Isca:iscaEscolhida chance:self.chance cenaRetornar:self.scene];
    
    [self.scene.view presentScene:animacao];
    
    [self removeAllChildren];
    [self removeFromParent];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    if ([self childNodeWithName:@"DetalheArmadilha"]) {
        [[self childNodeWithName:@"DetalheArmadilha"]removeFromParent];
        [[self childNodeWithName:@"Destaque"]removeFromParent];
    }
    else{
        for(int i=0;i<[arrayNodes count];i++){
            if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQArmadilha class]]) {
                DQArmadilha *armadilhaTocada=[arrayNodes objectAtIndex:i];
                self.armadilhaSelecionada = armadilhaTocada;
                [self exibeInformacoesArmadilha:armadilhaTocada];
                break;
            }
            if ([[arrayNodes objectAtIndex:i]isKindOfClass:[DQItem class]]) {
                DQItem *iscaEscolhida=[arrayNodes objectAtIndex:i];
                
                [self armadilhaArmada:iscaEscolhida];
                break;
            }
        }
    }
    
    for(int i=0;i<[arrayNodes count];i++){
        if ([[[arrayNodes objectAtIndex:i]name] isEqual:@"Usar"] ) {
            [self armarArmadilha];
            i = (int)[arrayNodes count];
        }
    }
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        if ([self.titulo.text isEqual:@"Iscas"]) {
            NSString *keyDaParte = [NSString stringWithFormat:@"%d",self.parteAtual];
            [self.lugaresArmados removeObjectForKey:keyDaParte];
        }
        [self removeAllChildren];
        [self removeFromParent];
    }
    
}

-(void)esconderMenu{
    [self removeFromParent];
}



@end
