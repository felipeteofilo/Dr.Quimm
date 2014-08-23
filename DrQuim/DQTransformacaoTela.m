//
//  DQTransformacaoTela.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTransformacaoTela.h"

@implementation DQTransformacaoTela

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //inicia mostrando a maleta
        self.transformacaoControle = [[DQTransformacaoControle alloc]initComTamanho:self.frame.size];

        //dicionario da receita
        self.urlReceitas = [[NSBundle mainBundle] pathForResource:@"ReceitasQuimicas" ofType:@"plist"];
        self.arrayReceitas = [[NSArray alloc] initWithContentsOfFile:self.urlReceitas];
        self.dicionarioReceitaAtual = [[NSDictionary alloc] initWithDictionary:[self.arrayReceitas objectAtIndex:0]];

        //inicia a maleta
        self.maletaQuimica = [[DQMaletaQuimica alloc] initComTamanho:self.frame.size eDicionarioDaReceita:self.dicionarioReceitaAtual];
        self.maletaQuimica.position = CGPointMake(self.frame.size.width * 0.05, self.frame.size.height * 0.05);

        //mostra a maleta
        [self addChild:self.maletaQuimica];
        self.mostrandoTelaDeSelecao = YES;

        //Define quais as amostras importantes nessa receita
        //descobre o nome da amostra 1
        self.nomeAmostra1 = [[self.dicionarioReceitaAtual objectForKey:@"Ingredientes"]objectAtIndex:0];

        //descobre o nome da amostra 2
        self.nomeAmostra2 = [[self.dicionarioReceitaAtual objectForKey:@"Ingredientes"]objectAtIndex:1];
    }
    return self;
}

-(void)sairTelaTransformacoes{
    DQVila *vila=[[DQVila alloc]initFase:2 Size:self.view.bounds.size];
    vila.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:vila];
}

-(void)mostrarTelaTransformacao
{
    //CRIA A IMAGEM DE FUNDO
    SKSpriteNode *fundo = [[SKSpriteNode alloc] initWithImageNamed:@"fundoTransformacao"];
    fundo.anchorPoint = CGPointZero;
    fundo.size = self.frame.size;
    fundo.position = CGPointZero;
    fundo.alpha = 0.5f;
    [self addChild:fundo];
    
    
    //CRIA LINHA DO MEIO --> TODO - colocar imagem
    SKSpriteNode *linhaDoMeio = [[SKSpriteNode alloc]initWithColor:[UIColor whiteColor] size:CGSizeMake(self.frame.size.width * 0.001, self.frame.size.height)];
    linhaDoMeio.anchorPoint = CGPointZero;
    linhaDoMeio.position = CGPointMake(self.frame.size.width/2, 0);
    [self addChild:linhaDoMeio];
    
    
    
    //CRIA TEXTO "Reagentes"
    SKLabelNode *labelReagentes = [[SKLabelNode alloc]init];
    labelReagentes.text = @"Reagente";
    labelReagentes.fontSize = 24;
    labelReagentes.fontColor = [UIColor whiteColor];
    labelReagentes.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelReagentes.position = CGPointMake(self.frame.size.width * 0.25, self.frame.size.height - labelReagentes.frame.size.height - 10);
    [self addChild:labelReagentes];
    
    
    
    //CRIA TEXTO "Produto"
    SKLabelNode *labelProduto = [[SKLabelNode alloc]init];
    labelProduto.text = @"Produto";
    labelProduto.fontSize = 24;
    labelProduto.fontColor = [UIColor whiteColor];
    labelProduto.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelProduto.position = CGPointMake(self.frame.size.width * 0.75, self.frame.size.height - labelReagentes.frame.size.height - 10);
    [self addChild:labelProduto];
    
    
    
    //MOSTRAR OS ELEMENTOS DOS DOIS INGREDIENTES DA RECEITA
    //Referenciando as amostras
    NSString *urlAmostras = [[NSBundle mainBundle] pathForResource:@"AmostrasQuimicas" ofType:@"plist"];
    NSArray *arrayAmostras = [[NSArray alloc] initWithContentsOfFile:urlAmostras];
    
    //Definindo quantidade necessária de
    
    //Passa por todas as amostras
    for(int i = 0; i < [arrayAmostras count]; i++){
        //se for a primeira amostra
        if([[[arrayAmostras objectAtIndex:i] objectForKey:@"Nome"] isEqualToString: self.nomeAmostra1]){
            //popula o array de elementos daquela amostra
            self.arrayDeElementosAmostra1 = [[NSArray alloc]initWithArray:[[arrayAmostras objectAtIndex:i] objectForKey:@"Elementos"]];
            
            //popula o array de SKSpriteNodes de elementos daquela amostra
            self.arrayDeSpritesDeElementosAmostra1 = [self popularArrayDeSpritesDeElementos:self.arrayDeElementosAmostra1];
            
            //mostra os elementos daquele array na tela
            for(int j = 0; j < [self.arrayDeSpritesDeElementosAmostra1 count]; j++){
                //cria um SKSpriteNode temporário apenas para armazenar esse SKSprite node
                SKSpriteNode *spriteTemporario = [self.arrayDeSpritesDeElementosAmostra1 objectAtIndex:j];
                spriteTemporario.position = CGPointMake(self.frame.size.width * 0.1,
                                                        (self.frame.size.height * 0.80) - ((self.frame.size.height * 0.85)/10 * j));
                
                //Adiciona-o na scene
                [self addChild:spriteTemporario];
            }
        }
        
        //se for a segunda amostra
        else if([[[arrayAmostras objectAtIndex:i] objectForKey:@"Nome"] isEqualToString: self.nomeAmostra2]){
            //popula o array de elementos daquela amostra
            self.arrayDeElementosAmostra2 = [[NSArray alloc]initWithArray:[[arrayAmostras objectAtIndex:i] objectForKey:@"Elementos"]];
            
            //popula o array de SKSpriteNodes de elementos daquela amostra
            self.arrayDeSpritesDeElementosAmostra2 = [self popularArrayDeSpritesDeElementos:self.arrayDeElementosAmostra2];
            
            //mostra os elementos daquele array na tela
            for(int j = 0; j < [self.arrayDeSpritesDeElementosAmostra2 count]; j++){
                //cria um SKSpriteNode temporário apenas para armazenar esse SKSprite node
                SKSpriteNode *spriteTemporario = [self.arrayDeSpritesDeElementosAmostra2 objectAtIndex:j];
                spriteTemporario.position = CGPointMake(self.frame.size.width * 0.3,
                                                        (self.frame.size.height * 0.80) - ((self.frame.size.height * 0.85)/10 * j));
                
                //Adiciona-o na scene
                [self addChild:spriteTemporario];
            }
            
            //popula o array de SKSpriteNodes de elementos daquela amostra
            self.arrayDeSpritesDeElementosAmostra2 = [self popularArrayDeSpritesDeElementos:self.arrayDeElementosAmostra2];
            
            //mostra os elementos daquele array na tela
            for(int j = 0; j < [self.arrayDeSpritesDeElementosAmostra2 count]; j++){
                //cria um SKSpriteNode temporário apenas para armazenar esse SKSprite node
                SKSpriteNode *spriteTemporario2 = [self.arrayDeSpritesDeElementosAmostra2 objectAtIndex:j];
                spriteTemporario2.position = CGPointMake(self.frame.size.width * 0.3,
                                                         (self.frame.size.height * 0.5) - ((self.frame.size.height * 0.85)/10 * j));
                
                //Adiciona-o na scene
                [self addChild:spriteTemporario2];
            }
        }
    }
    
    
    
    
    //CRIA O LADO DO PRODUTO, COM OS ESPAÇOS PARA AS AMOSTRAS FINAIS
    //Inicia o mutableArray dos nodesDestino
    self.arrayDeSpritesDestino = [[NSMutableArray alloc]init];
    
    //No "arrayReceitas", passa pelo array de resultados
    for(int i = 0; i < [[[self.arrayReceitas objectAtIndex:0] objectForKey:@"Resultado"] count]; i++){
        
        //No "arrayReceitas", passa pelos elementos do resultado atual
        for(int j = 0; j < [[[[[self.arrayReceitas objectAtIndex:0] objectForKey:@"Resultado"] objectAtIndex:i] objectForKey:@"Elementos"] count]; j++){
            //Cria o srpite
            SKSpriteNode *spriteDestinoTemporario = [[SKSpriteNode alloc] initWithImageNamed:@"destino"];
            
            //Define propriedades
            //tamanho
            spriteDestinoTemporario.size = CGSizeMake(75, 75);
            
            //nome
            NSString *stringNome = [NSString stringWithFormat:@"destino_%@", [[[[[self.arrayReceitas objectAtIndex:0] objectForKey:@"Resultado"] objectAtIndex:i] objectForKey:@"Elementos"] objectAtIndex:j]];
            spriteDestinoTemporario.name = stringNome;
            
            //anchorPoint
            spriteDestinoTemporario.anchorPoint = CGPointZero;
            
            //posição
            spriteDestinoTemporario.position = CGPointMake(self.frame.size.width * (0.60 + (i * 0.15)),
                                                           (self.frame.size.height * 0.80) - ((self.frame.size.height * 0.95)/10 * j));
            
            //Adiciona o sprite na cena
            [self addChild:spriteDestinoTemporario];
            
            //Adiciona o sprite no array
            [self.arrayDeSpritesDestino addObject:spriteDestinoTemporario];
        }
    }
    
    
    //MOSTRAR O ROSTO DO DR.QUIMM - TODO(adicionar texto com a carinha do Quimm)
}

-(NSArray *)popularArrayDeSpritesDeElementos: (NSArray *)arrayDeElementos
{
    NSMutableArray *arrayDeSpritesTemporario = [[NSMutableArray alloc]init];
    
    //para cada elemento, um sprite
    for(int elemento = 0; elemento < [arrayDeElementos count]; elemento++){
        NSString *nomeImagem = [NSString stringWithFormat:@"elemento_%@", [arrayDeElementos objectAtIndex:elemento]];
        
        //cria o spriteNode
        SKSpriteNode *spriteTemporario = [[SKSpriteNode alloc] initWithImageNamed:nomeImagem];
        
        //Definições do sprite
        spriteTemporario.anchorPoint = CGPointZero;
        spriteTemporario.size = CGSizeMake(70, 70);
        spriteTemporario.name = [arrayDeElementos objectAtIndex:elemento];
        
        //Adiciona o sprite no array
        [arrayDeSpritesTemporario addObject:spriteTemporario];
    }
    
    return arrayDeSpritesTemporario;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    //SE ESTIVER NA TELA DE TRANSFORMAÇÃO...
    if(!self.mostrandoTelaDeSelecao){
        //Armazena o toque e a posição dele
        UITouch *toque = [touches anyObject];
        CGPoint posicaoToque = [toque locationInNode:self.scene];
        
        //Salva o node em que tocou
        self.nodeTocado = nil;
        self.nodeTocado = [self.scene nodeAtPoint:posicaoToque];
        
        //TODO - classe elemento
        //Se tocar em um elemento (Pb, N, O, K, I) -- feio, eu sei... .-.
        if([self.nodeTocado.name isEqualToString:@"Pb"] ||
           [self.nodeTocado.name isEqualToString:@"N"]  ||
           [self.nodeTocado.name isEqualToString:@"O"]  ||
           [self.nodeTocado.name isEqualToString:@"K"]  ||
           [self.nodeTocado.name isEqualToString:@"I"]){
            //pode ser movido
            
            //PARA MOVER O NODE
            //self.nodeSelecionado = self.nodeTocado;
            self.posicaoInicial = CGPointMake(self.nodeTocado.frame.origin.x, self.nodeTocado.frame.origin.y);
            self.posicaoDelta = CGPointMake(posicaoToque.x - self.nodeTocado.frame.origin.x, posicaoToque.y - self.nodeTocado.frame.origin.y);
        }
        else{
            self.nodeTocado = nil;
        }
    }
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    //SE ESTIVER NA TELA DE TRANSFORMAÇÃO...
    if(!self.mostrandoTelaDeSelecao){
        //Se o nodetocado não for nil
        if(self.nodeTocado != nil){
            //Armazena o toque e a posição dele
            UITouch *toque = [touches anyObject];
            CGPoint posicaoToque = [toque locationInNode:self.scene];
            
            //Pega posição
            float x = posicaoToque.x - self.posicaoDelta.x;
            float y = posicaoToque.y - self.posicaoDelta.y;
            float largura = self.nodeTocado.frame.size.width;
            float altura = self.nodeTocado.frame.size.height;
            
            //verifica se está dentro da tela
            if(x >= 0 && x+largura <= self.frame.size.width && y >= 0 && y+altura <= self.frame.size.height){
                [self.nodeTocado setPosition:CGPointMake(x, y)];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //SE ESTIVER NA TELA DE SELEÇÃO...
    if(self.mostrandoTelaDeSelecao){
        //Armazena o toque e a posição dele
        UITouch *toque = [touches anyObject];
        CGPoint posicaoToque = [toque locationInNode:self.scene];
        
        //Salva o node em que tocou
        SKNode *nodeTocado = [self.scene nodeAtPoint:posicaoToque];
        
        //Se tocar em uma amostra que conste na receita atual, ela fica selecionada
        //se tocar na amostra 1
        if([nodeTocado.name isEqualToString:self.nomeAmostra1]){
            //Se ela já tiver sido selecionada... faz animação de seleção
            if(!self.amostra1Selecionada){
                [self iniciarAnimcaoSelecao:nodeTocado];
                self.amostra1Selecionada = YES;
                [self.maletaQuimica.receitaAtual confirmaIngrediente:1];
            }
            //Senão... Faz animação de deseleção
            else{
                [self iniciarAnimcaoDeselecao:nodeTocado];
                self.amostra1Selecionada = NO;
                [self.maletaQuimica.receitaAtual desconfirmaIngrediente:1];
            }
        }
        
        //Se tocar na amostra 2 e ela não estiver selecionada
        else if([nodeTocado.name isEqualToString:self.nomeAmostra2]){
            //Verifica se todas as amostras que interessam já foram selecionadas
            if(self.amostra1Selecionada && self.amostra2Selecionada){
                [self iniciarTelaTransformacao];
            }
            
            //Se ela já tiver sido selecionada... faz animação de seleção
            if(!self.amostra2Selecionada){
                [self iniciarAnimcaoSelecao:nodeTocado];
                self.amostra2Selecionada = YES;
                [self.maletaQuimica.receitaAtual confirmaIngrediente:2];
            }
            //Senão... faz animação de deseleção
            else{
                [self iniciarAnimcaoDeselecao:nodeTocado];
                self.amostra2Selecionada = NO;
                [self.maletaQuimica.receitaAtual desconfirmaIngrediente:2];
            }
        }
        
        //Verifica se todas as amostras que interessam já foram selecionadas
        if(self.amostra1Selecionada && self.amostra2Selecionada){
            [self iniciarTelaTransformacao];
        }
    }
    
    //SE ESTIVER NA TELA DE TRANSFORMAÇÃO...
    else{
        //Se tiver algum node tocado...
        if(self.nodeTocado != nil){
            
            //Passa por todos os nodes destino e verifica se houve intersecção com algum deles
            for(int i = 0; i < [self.arrayDeSpritesDestino count]; i++){
                
                //se tiver...
                if(CGRectIntersectsRect(self.nodeTocado.frame, [[self.arrayDeSpritesDestino objectAtIndex:i] frame])){
                    
                    //verifica se o nome do nodeTocado é o mesmo do destino.
                    NSString *nomeNodeTocado = [NSString stringWithFormat:@"destino_%@", self.nodeTocado.name];
                    NSString *nomeNodeDestino = [[self.arrayDeSpritesDestino objectAtIndex:i] name];
                    
                    //Se for...
                    if([nomeNodeTocado isEqualToString:nomeNodeDestino]){
                        //define que aquele é o novo frame dele
                        SKNode *nodeDestino = [self.arrayDeSpritesDestino objectAtIndex:i];
                        [self.nodeTocado setPosition: nodeDestino.position];
                        
                        //deixa o nome do nodeTocado como nil
                        self.nodeTocado.name = nil;
                        
                        //deixa o nome do node de destino como nil
                        [[self.arrayDeSpritesDestino objectAtIndex:i] setName:@" "];
                        
                        //define que o node todado é nil
                        self.nodeTocado = nil;
                    }
                    else{
                        [self.nodeTocado setPosition:self.posicaoInicial];
                        self.nodeTocado = nil;
                    }
                }
            }
        }
        
        [self verificarSeTerminou];
    }
}

-(void)verificarSeTerminou
{
    //Verifica se todos os nodes foram posicionados com seus iguais
    //inicia um booleano com valor de YES. Se algum sprite do array tiver nome ainda, muda para NO
    BOOL terminou = YES;
    
    for(int i = 0; i < [self.arrayDeSpritesDestino count]; i++){
        //Se um deles ainda tiver nome...
        if(![[[self.arrayDeSpritesDestino objectAtIndex:i]name] isEqualToString:@" "]){
            terminou = NO;
        }
    }
    
    //no fim verifica se terminou ainda é YES
    if(terminou){
        //TODO - ADICIONAR ITEM NA LISTA. FECHAR TELA DE TRANSFORMAÇÕES
        SKSpriteNode *quadradoDoFinal = [[SKSpriteNode alloc] initWithColor:[UIColor blueColor] size:self.frame.size];
        quadradoDoFinal.anchorPoint = CGPointZero;
        [self addChild:quadradoDoFinal];
        
        //Fechar tela de transformações
        [self sairTelaTransformacoes];
    }
}


-(void)iniciarAnimcaoSelecao: (SKNode *)nodeSelecionado
{
    NSLog(@"Selecionado: %@", nodeSelecionado.name);
    
    //Ação de selecionar a amostra
    CGFloat posicaoAtual = nodeSelecionado.frame.origin.y;
    SKAction *selecionarAmostra = [SKAction moveToY:posicaoAtual + 40 duration:0.4f];
    [nodeSelecionado runAction:selecionarAmostra];
}

-(void)iniciarAnimcaoDeselecao: (SKNode *)nodeSelecionado
{
    NSLog(@"Deselecionado: %@", nodeSelecionado.name);
    
    //Ação de selecionar a amostra
    CGFloat posicaoAtual = nodeSelecionado.frame.origin.y;
    SKAction *selecionarAmostra = [SKAction moveToY:posicaoAtual - 40 duration:0.4f];
    [nodeSelecionado runAction:selecionarAmostra];
}

-(void)iniciarTelaTransformacao
{
    //Inicia animação de tirar a maleta da tela e mostrar a tela de transformação
    SKAction *trocarDeTela = [SKAction fadeAlphaTo:0 duration:1.0f];
    [self.maletaQuimica runAction:trocarDeTela completion:^{
        self.maletaQuimica.alpha = 0;
        self.mostrandoTelaDeSelecao = NO;
        [self mostrarTelaTransformacao];
    }];
}

@end