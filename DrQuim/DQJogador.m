//
//  DQJogador.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQJogador.h"

#define distAndar 100
#define impulsoPulo 210


@implementation DQJogador

//Leonardo 13/06/2014 - Alterado a função de inicialização do node para que carregue o sprite na propriedade spriteNode
//Funcao para iniciar e alocar tudo que for necessario para o player
-(id)initJogadorSprite: (NSString*)name{
    
    if(self = [super init]){
        
        //Leonardo 13/06/2014 - Inicia o sprite
        self.spriteNode=[SKSpriteNode spriteNodeWithImageNamed:name];
        [self.spriteNode setName:@"spriteJogador"];
        
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        [self.spriteNode setSize:CGSizeMake(90, 160)];
        
        [self.spriteNode setZPosition:100.0f];
        
        //Deixar o corpo fisico mais prox ao sprite
        [self configuraCorpoFisico];
        [self addChild:self.spriteNode];
        
        //Seta que ele ainda nao pode escalar
        self.podeEscalar = NO;
        self.estaNoChao = YES;
        //USADO COMO TESTE
        self.fome = 100;
        self.sede = 100;
        self.vida = 100;
        
        //TODO: Remover
        self.respeito = 100;

        //Inicia a instância da classe itensJogador
        self.itens = [[DQItensJogador alloc] init];
        self.armadilhas =[[DQArmadilhasJogador alloc]init];
        self.controleMissoes = [[DQMissaoControle alloc]initCena:self.scene];
        
        [self.controleMissoes iniciarMissao];

//Leonardo- Removido controle de SOM para faz Atualizacao
//        self.controleSom=[[DQControleSom alloc]initControleSom:Jogador];
//        [self addChild:self.controleSom];
        
        [self setName:@"Jogador"];
        [self definePhisicsBody];
        
        [[NSNotificationCenter   defaultCenter]addObserver:self selector:@selector(adicionarFruta:) name:notificacaoFruta object:nil];
    }
    
    //retorna o jogador
    return self;
}

-(void)carregarInformacoesDoJogador:(NSString*)jogador{
    Usuario *infoSave = [DQCoreDataController procurarJogador:jogador];
    if (infoSave !=nil) {
        self.fome = [[infoSave fome]intValue];
        self.sede = [[infoSave sede]intValue];
        self.vida= [[infoSave vida]intValue];
        self.respeito = [[infoSave respeito]intValue];
        
        
        self.itens.dicionarioDeItensJogador = [infoSave itens];
        self.armadilhas.arrayDeArmadilhasJogador = [infoSave armadilhas];
        
        
        NSDictionary *missao = [infoSave missao];
        self.controleMissoes.emMissao = [[missao objectForKey:@"EmMissao"]boolValue];
        self.controleMissoes.parteAtual = [[missao objectForKey:@"ParteAtual"]intValue];
        self.controleMissoes.proximaMissao = [[missao objectForKey:@"MissaoAtual"]intValue];
        
        [self.controleMissoes iniciarMissao];
        
    }
    
}

//TODO: Mover método
-(void)salvarJogoDoJogador:(NSString*)jogador{
    [DQCoreDataController salvarVida:self.vida respeito:self.respeito fome:self.fome sede:self.sede doJogador:jogador];
    
    //DQFase * fase = (DQFase*)self.scene;
    
    //[DQCoreDataController salvarFaseAtual:fase.faseAtual parte:fase.parteFaseAtual doJogador:jogador];
    
    NSMutableDictionary *missao = [[NSMutableDictionary alloc]init];
    
    [missao setObject:[NSNumber numberWithBool:self.controleMissoes.emMissao] forKey:@"EmMissao"];
    [missao setObject:[NSNumber numberWithInt:self.controleMissoes.parteAtual]forKey:@"ParteAtual"];
    
    [missao setObject:[NSNumber numberWithInt:self.controleMissoes.proximaMissao] forKey:@"MissaoAtual"];
    
    
    [DQCoreDataController salvarItens:self.itens.dicionarioDeItensJogador doJogador:jogador];
    
    [DQCoreDataController salvarArmadilhas:self.armadilhas.arrayDeArmadilhasJogador doJogador:jogador];
    
    [DQCoreDataController salvarMissao:missao doJogador:jogador];
    
}

-(void)atualizaEstadoJogador{
    
    if (![DQControleUserDefalts estadoJogadorAtualizado]) {
        [DQControleUserDefalts setEstadoInicialJogador];
    }
    
    NSDictionary *estadoJogador=[DQControleUserDefalts estadosJogador];
    
    self.fome= [[estadoJogador objectForKey:@"Fome"]floatValue];
    self.vida=[[estadoJogador objectForKey:@"Vida"]floatValue];
    self.sede=[[estadoJogador objectForKey:@"Sede"]floatValue];
    self.respeito=[[estadoJogador objectForKey:@"Respeito"]floatValue];
}


-(void)iniciarAnimacoes:(NSDictionary*)animacoes{
    
    if (![[animacoes objectForKey:@"Andando"]  isEqual:@""]) {
        framesAndando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Andando"]]];
        
    }
    if (![[animacoes objectForKey:@"Pulando"]  isEqual:@""]) {
        framesPulando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Pulando"]]];
        
    }
    if (![[animacoes objectForKey:@"Parado"]  isEqual:@""]) {
        framesParado = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Parado"]]];
        
    }
    if (![[animacoes objectForKey:@"Escalando"]  isEqual:@""]) {
        framesEscalando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Escalando"]]];
        
    }
    if (![[animacoes objectForKey:@"Caindo"]  isEqual:@""]) {
        framesCaindo = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Caindo"]]];
        
    }
    if (![[animacoes objectForKey:@"Derrapando"]  isEqual:@""]) {
        framesDerrapando = [self lerFrames:[SKTextureAtlas atlasNamed:[animacoes objectForKey:@"Derrapando"]]];
        
    }
    
    //apos ler tudo anima o jogador
    [self animarParado];
    
}
-(NSMutableArray*)lerFrames :(SKTextureAtlas*)pastaFrames{
    NSInteger numImagens = pastaFrames.textureNames.count;
    NSMutableArray *frames =[[NSMutableArray alloc]init];
    
    for (int i=1; i <= numImagens; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [pastaFrames textureNamed:textureName];
        [frames addObject:temp];
    }
    
    return frames;
}

//Singleton do jogador
+(id)sharedJogador
{
    static DQJogador *jogador = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jogador = [[self alloc]initJogadorSprite:@"Jogador"];
    });
    
    return jogador;
}


//funcao para animar o jogador andando
-(void)animarAndando{
    
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]]withKey:@"animandoAndando"];
    
    //TODO: Adicionar controle de som
    //    [self.controleSom tocarSomLooping:[self.controleSom configuraPlayerSom:@"Passo" nLoops:-1]];
    
}

//funcao para animar o jogador derrapando
-(void)animarDerrapando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesDerrapando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoDerrapando"];
}

//funcao para animar o jogador escalando
-(void)animarEscalando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesEscalando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoEscalada"];
}
//anima ele parado
-(void)animarParado{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesParado
                                                                              timePerFrame:0.9f
                                                                                    resize:NO
                                                                                   restore:YES]]withKey:@"animandoParado"];
}
//funcao para animar jogador pulando
-(void)animarPular{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    
    
    
    [self.spriteNode runAction:[SKAction animateWithTextures:framesPulando timePerFrame:0.5f                                           resize:NO restore:YES] withKey:@"animandoPulo"];
    
    
}

//funcao para animar jogador caindo
-(void)animarCaindo{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction animateWithTextures:framesCaindo timePerFrame:0.1f                                           resize:NO restore:YES] withKey:@"animandoCaindo"];
}




//funcao da acao de pulo do jogador
-(void)pular{
    
    //verifica se ele esta no ar, se ja estiver nao pula
    if (self.estaNoChao && ![self.spriteNode actionForKey:@"animandoEscalada"]) {
        
        // aplica um impulso para cima , ou seja o pulo e seta que ele esta no ar
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, impulsoPulo)];
        
        self.estaNoChao = NO;
        
        // anima ele pulando
        [self animarPular];
    }
}

-(BOOL)estaComContadorGeiger{
    return [self estaComItem:@"Contador Geiger"];
}

//TODO:- Melhorar metodo e passar ele p o DQUteis
-(BOOL)estaComItem:(NSString*)nomeItem{
    return [DQUteis array:[self.itens arrayItensJogador] contemString:nomeItem];
}

//Alterado cabeçalho funçao
-(void)andarParaDirecao:(char)direcao eVelocidade:(float)velocidade{
    if (![self.spriteNode actionForKey:@"animandoEscalada"] ) {
        //variavel SKAction- define a direcao do movimento
        SKAction *movimentar;
        
        //se a direcao for para direita
        if (direcao=='D') {
            
            self.andandoParaDirecao = @"D";
            //Alterado para usar da propriedade
            movimentar=[SKAction moveByX:distAndar+(distAndar * velocidade) y:0 duration:1.0];
            
            if(self.physicsBody.velocity.dx > 10 && self.physicsBody.velocity.dy < -10){
                [self.physicsBody setVelocity:CGVectorMake(10, -10)];
            }
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*1;
        }else{
            
            self.andandoParaDirecao = @"E";
            movimentar=[SKAction moveByX:(distAndar-(distAndar * velocidade))*-1 y:0 duration:1.0];
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*-1;
        }
        
        //verifica se nao esta animando o pulo e anima o jogador andando
        if (![self.spriteNode actionForKey:@"animandoAndando"] && self.estaNoChao && ![self actionForKey:@"animandoCaindo"]) {
            
            //Cria action para animar
            SKAction *animacaoMover = [SKAction runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando timePerFrame:0.09f resize:NO restore:YES]] onChildWithName:self.spriteNode.name];
            
            [self runAction:[SKAction repeatActionForever:[SKAction group:@[movimentar,animacaoMover]]] withKey:@"andar"];
        }else{
            //Esta no alto so move
            [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
            
        }
        
        //Posto uma notificaçao avisando ao controler de som para tocar o som de caminhada do player e falando que será tocado em looping
        [[NSNotificationCenter defaultCenter]postNotificationName:notificacaoJogadorPlaySom object:nil userInfo:[NSDictionary dictionaryWithObjects:@[@"Andar",[NSNumber numberWithInt:-1]] forKeys:@[@"acaoJogador",@"nLoops"]]];
    }
}

-(void)configuraCorpoFisico{
    CGMutablePathRef path=CGPathCreateMutable();
    
    CGPoint primeiroPonto=CGPointMake((CGRectGetMidX(self.spriteNode.frame)+15), CGRectGetMinY(self.spriteNode.frame)+10);
    CGPathMoveToPoint(path, NULL, primeiroPonto.x,primeiroPonto.y);
    
    CGPoint segundoPonto=CGPointMake((CGRectGetMidX(self.spriteNode.frame)-15), CGRectGetMinY(self.spriteNode.frame)+10);
    CGPathAddLineToPoint(path, NULL, segundoPonto.x,segundoPonto.y);
    
    CGPoint terceiroPonto=CGPointMake(CGRectGetMinX(self.spriteNode.frame)+15, CGRectGetMidY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, terceiroPonto.x, terceiroPonto.y);
    
    CGPoint quartoPonto=CGPointMake(CGRectGetMidX(self.spriteNode.frame), CGRectGetMaxY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, quartoPonto.x, quartoPonto.y);
    
    CGPoint quintoPonto=CGPointMake(CGRectGetMaxX(self.spriteNode.frame)-15, CGRectGetMidY(self.spriteNode.frame));
    CGPathAddLineToPoint(path, NULL, quintoPonto.x, quintoPonto.y);
    
    [self setPhysicsBody:[SKPhysicsBody bodyWithPolygonFromPath:path]];
    
    self.physicsBody.usesPreciseCollisionDetection=YES;
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.mass = 0.566667;
    self.physicsBody.restitution = 0;
    
    
}
//Metodo que altera a Fome do jogador
-(void)alterarFomeJogador: (int)fome
{
    
    
    //está ficando com fome
    if(fome > 0){
        if ((self.fome - fome) < 0) {
            [self setFome:0];
        }
        else{
            [self setFome:(self.fome - fome)];
        }
    }
    //está perdendo a fome
    else{
        if ((self.fome -(fome)) >100) {
            [self setFome:100];
        }
        else{
            [self setFome:(self.fome -(fome))];
        }
    }
}

//Metodo que altera a Sede do jogador
-(void)alterarSedeJogador: (int)sede
{
    //está ficando com sede
    if(sede > 0){
        if ((self.sede - sede) < 0) {
            [self setSede:0];
        }
        else{
            [self setSede:(self.sede - sede)];
        }
    }
    //está perdendo a sede
    else{
        if ((self.sede -(sede)) > 100) {
            [self setSede:100];
        }
        else{
            [self setSede:(self.sede -(sede))];
        }
    }
}

//Metodo que altera a Vida do jogador
-(void)alterarVidaJogador: (int)vida
{
    //está ficando sem vida
    if(vida < 0){
        if ((self.vida - vida) < 0) {
            [self setVida:0];
        }
        else{
            [self setSede:(self.vida - vida)];
        }
        //Leonardo- Removido controle de SOM para faz Atualizacao
//        [self.controleSom tocarSom:[self.controleSom configuraPlayerSom:@"somPerdeuVida"]];
    }
    //está ganhando vida
    else{
        if ((self.vida + vida) > 100) {
            [self setVida:100];
        }
        else{
            [self setSede:(self.vida + vida)];
        }
    }
}

//Método para parar de andar
-(void)pararAndar{
    self.andandoParaDirecao =@"";
    //remove as acoes de andar e animarAndando
    [self removeActionForKey:@"andar"];
    [self.spriteNode removeActionForKey:@"animandoAndando"];
    
    if (![self.spriteNode actionForKey:@"animandoEscalada"] && ![self.spriteNode actionForKey:@"animandoPulo"] && ![self.spriteNode actionForKey:@"animandoDerrapando"]&& ![self.spriteNode actionForKey:@"animandoCaindo"]) {
        [self.spriteNode removeAllActions];
        
        [self animarParado];
    }
    //Leonardo- Removido controle de SOM para faz Atualizacao
//    [self.controleSom pararSom];
    
    //Posta msg para o controlador parar o som
    [[NSNotificationCenter defaultCenter]postNotificationName:notificacaoJogadorStopSom object:nil userInfo:nil];
}

//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(char)direcao{
    //se puder escalar
    if (self.podeEscalar) {
        SKAction *escalar=[[SKAction alloc]init];
        
        //Desliga a gravidade para o Node
        self.physicsBody.dynamic=NO;
        // verifica para qual direcao sera a escalada
        if (direcao=='C') {
            //Sobe
            escalar =[SKAction moveByX:0.0f y:90.0f duration:1.0];
            
        }else if(direcao=='B'){
            //Desce
            escalar =[SKAction moveByX:0.0f y:-90.0f duration:1.0];
        }
        //anima o jogador escalando
        [self animarEscalando];
        // move o jogador
        [self runAction:[SKAction repeatActionForever:escalar]withKey:@"escalar"];
        
    }
}
//Funcao para parar de derrapar
-(void)pararDerrapar{
    [self.spriteNode removeActionForKey:@"animandoDerrapando"];
}

//funcao para parar a escalada do jogador
-(void)pararEscalar{
    self.podeEscalar = NO;
    if (![self.physicsBody isDynamic]) {
        self.physicsBody.dynamic = YES;
    }
    [self.spriteNode removeActionForKey:@"animandoEscalada"];
    [self removeActionForKey:@"escalar"];
}

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada{
    [[self.spriteNode actionForKey:@"animandoEscalada"]setSpeed:0];
    [self removeActionForKey:@"escalar"];
}

//funcao que atualiza o status da missao
-(void)atualizarStatusMissao :(DQFalasNoJogoControle*)controleFalas{
    if(self.controleMissoes.emMissao){
        [self interagirComNPC:@"Piloto" ControleDeFalas:controleFalas];
    }
    
    [self.controleMissoes atualizarCena:self.scene];
    [self.controleMissoes colocarBalaoDeMissao];
    
    if(![self.scene childNodeWithName:@"falasDoJogo"]){
        [self.controleMissoes mudarFase];
    }
    
    
}


//funcao a fazer para ele interagir com pessoas
-(void)interagirComNPC:(NSString*)nomeNPC ControleDeFalas:(DQFalasNoJogoControle*)controleDeFalas{
    
    //Se nao estiver em missao
    if (!self.controleMissoes.emMissao) {
        //Senao esta iniciando uma nova  missao
        if (![self.controleMissoes iniciarNovaMissaoNPC:nomeNPC]) {
            //Cria uma caixa de fala com as falas de respeito e a adiciona na cena
            NSString *keyDaParte = [NSString stringWithFormat:@"Respeito%i", (self.respeito/10)*10];
            
            SKSpriteNode *caixaDeFala =[controleDeFalas mostrarFalaComNPC:nomeNPC KeyDaFala:keyDaParte Missao:nil Tamanho:self.scene.size];
            [self.scene addChild:caixaDeFala];
        }
    }
    //Se esta em missao
    if (self.controleMissoes.emMissao) {
        NSString *keyDaParte;
        NSString *missao = self.controleMissoes.missao.ID;
        //Se é o NPC que passa a parte da missao
        if ([self.controleMissoes passarParteMissao:nomeNPC inventario:[self.itens arrayItensJogador]posicao:self.position]) {
            //Cria a key de uma fala principal da missao
            keyDaParte = [NSString stringWithFormat:@"Parte%i", self.controleMissoes.parteAtual-1];
            
            [self entregarItem];
            [self receberItem];
            [self alterarEstados];
            if(self.controleMissoes.parteAtual+1 > self.controleMissoes.missao.quantidadeDePartes){
                [self.controleMissoes fimDaMissao];
            }
            
        }
        //Se nao é o NPC que passa a parte da missao ou nao tem o item
        else if(![nomeNPC isEqualToString:@"Piloto"]){
            //Cria uma key de uma fala secundaria da missao
            keyDaParte = [NSString stringWithFormat:@"Parte%iR", self.controleMissoes.parteAtual];
        }
        if (keyDaParte != nil) {
            
            
            //Cria a caixa de fala com as key obtidas e a adiciona na tela
            SKSpriteNode *caixaDeFala = [controleDeFalas mostrarFalaComNPC:nomeNPC KeyDaFala:keyDaParte Missao:missao Tamanho:self.scene.size];
            
            [self.scene addChild:caixaDeFala];
        }
    }
}


//Método chamado quando a missão descreve que um item deve ser entregue
-(void)entregarItem{
    
    if ([[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ArmadilhasEntregue"]) {
        NSMutableArray*armadilhasParaEntregar = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ArmadilhasEntregue"];
        for (int i = 0; i< armadilhasParaEntregar.count; i++) {
            NSString *nomeArmadilha = [armadilhasParaEntregar objectAtIndex:i];
            
            
            [self.armadilhas receberArmadilha:nomeArmadilha];
        }
    }
    
    
    NSMutableArray*itemsParaEntregar = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ItemEntregue"];
    
    for (int i = 0; i< itemsParaEntregar.count; i++) {
        NSString *nomeItem = [[itemsParaEntregar objectAtIndex:i]objectForKey:@"Nome"];
        int quantidade = [[[itemsParaEntregar objectAtIndex:i]objectForKey:@"Quantidade"]intValue];
        
        [self.itens entregarItem:nomeItem  quantidade:quantidade];
    }
}


//Método chamado quando a missão descreve que um item deve ser recebido
-(void)receberItem{
    NSMutableArray*itemsParaReceber = [[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]objectForKey:@"ItemRecebido"];
    
    for (int i = 0; i< itemsParaReceber.count; i++) {
        NSString *nomeItem = [[itemsParaReceber objectAtIndex:i]objectForKey:@"Nome"];
        int quantidade = [[[itemsParaReceber objectAtIndex:i]objectForKey:@"Quantidade"]intValue];
        
        [self.itens receberItem:nomeItem  quantidade:quantidade];
    }
    
}

//Metodo para alterar os estados do jogador em missao
-(void)alterarEstados{
    
    NSDictionary *dicionario = [[NSDictionary alloc] initWithDictionary:[self.controleMissoes.missao.arrayPartes objectAtIndex:self.controleMissoes.parteAtual-1]];
    
    //Ver se muda os estados
    //fome
    int fome = [[dicionario objectForKey:@"Fome"] intValue];
    if(fome != 0){
        [self alterarFomeJogador:fome];
    }
    
    //sede
    int sede = [[dicionario objectForKey:@"Sede"] intValue];
    if(sede != 0){
        [self alterarSedeJogador:sede];
    }
    
    //vida
    int vida = [[dicionario objectForKey:@"Vida"] intValue];
    if(vida != 0){
        [self alterarVidaJogador:vida];
    }
}
-(void)definePhisicsBody{
    //Chao Categoria
    self.physicsBody.categoryBitMask=JogadorCategoria;
    self.physicsBody.collisionBitMask=ChaoCategoria | PlataformaAtivadaCategoria;
    self.physicsBody.contactTestBitMask= PlataformaDesativadaCategoria;
    self.physicsBody.usesPreciseCollisionDetection=YES;
}

-(void)verificarAnimacaoCaindo{
    //se esta caindo de uma distancia muito grande anima ele caindo
    if (self.physicsBody.velocity.dy < -535 && ![self.spriteNode actionForKey:@"animandoCaindo"]) {
        [self animarCaindo];
    }
}
-(void)verificarAnimacaoDerrapagem{
    //se jogador esta derrapando anima ele derrapando
    if (self.estaNoChao && (self.physicsBody.velocity.dx < -10 || self.physicsBody.velocity.dx > 10) && ![self.spriteNode actionForKey:@"animandoAndando"] && ![self.spriteNode actionForKey:@"animandoDerrapando"]) {
        [self animarDerrapando];
    }
    //se nao retira a animacao
    if ([self.spriteNode actionForKey:@"animandoDerrapando"] && self.physicsBody.velocity.dx < 10 && self.physicsBody.velocity.dx > -10 ) {
        [self pararDerrapar];
    }
}

//Adiciona a fruta com o nome igual ao recebido no dicionario ao inventario do jogador
-(void)adicionarFruta:(NSNotification*)notification{
    NSString *nomeFruta=[notification.userInfo objectForKey:@"NomeFruta"];
    
    //TODO:- Decidir como fazer com frutas e legumes :P
    //[self.itens receberItem:nomeFruta quantidade:1];
}
@end
