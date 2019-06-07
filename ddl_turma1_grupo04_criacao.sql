CREATE TABLE cliente (
    cpf CHAR(11),
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    endereco VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    dataNascimento DATE NOT NULL,
    PRIMARY KEY(cpf),
    CONSTRAINT cliente_sexo CHECK (UPPER (sexo) IN ('F','M' ))
    
   
);

--> atributo multivalorado (entidade cliente)<--

CREATE TABLE telefoneCliente(
    telefoneCliente VARCHAR(18),
    cpfCliente CHAR(11),
    PRIMARY KEY(telefoneCliente,cpfCliente),
    FOREIGN KEY (cpfcliente) REFERENCES cliente(cpf)

);

CREATE TABLE quarto(
    valorDiaria FLOAT NOT NULL,
    numero INT,
    vista VARCHAR(40),
    PRIMARY KEY(numero)
);

--> relacionamento hospeda quarto <--
CREATE TABLE hospedaQuartos( 
    diaCheckin DATE NOT NULL,
    diaCheckout DATE NOT NULL, 
    numeroQuarto INT, 
    cpfCliente CHAR(11), 
    CONSTRAINT pk_hospedagem 
    PRIMARY KEY(cpfCliente,numeroQuarto),
    CONSTRAINT fk_clienteHospedagem FOREIGN KEY(numeroQuarto) REFERENCES quarto(numero),
    CONSTRAINT fk_quartoHospedagem FOREIGN KEY(cpfCliente) REFERENCES cliente(cpf), 
    CONSTRAINT ck_hospedaQuartos CHECK (diaCheckout >= diaCheckin)
);

--> relacionamento reserva quarto <--
CREATE TABLE reservaQuarto(
    diaCheckin DATE NOT NULL,
    diaCheckout DATE NOT NULL,
    numeroQuarto INT,
    cpfCliente CHAR(11),
    PRIMARY KEY(cpfCliente,numeroQuarto),
    FOREIGN KEY(numeroQuarto) REFERENCES quarto(numero),
    FOREIGN KEY(cpfCliente) REFERENCES cliente(cpf)
    
);

--> entidade regularizada 5(Funcionario)<--

CREATE TABLE funcionario(
    cpf CHAR(11),
    dataNascimento DATE NOT NULL,
    nome VARCHAR(40) NOT NULL,
    salario FLOAT NOT NULL,
    funcao VARCHAR(25) NOT NULL,
    PRIMARY KEY (cpf)

);


 --> relacionamento manutencao <--
CREATE TABLE manutencao(
    observacao VARCHAR(256),
    tipo VARCHAR(50) NOT NULL,
    data DATE NOT NULL,
    numQuarto INT,
    cpfFuncionario CHAR(11) NOT NULL,
    PRIMARY KEY(cpfFuncionario, numQuarto),
    FOREIGN KEY(cpfFuncionario) REFERENCES funcionario(cpf),
    FOREIGN KEY(numQuarto) REFERENCES quarto(numero)
    
);

--> entidade fraca (Dependente) <--
CREATE TABLE dependente(
    cpfCliente CHAR(11),
    cpfDependente CHAR(11),
    dataNascimento DATE NOT NULL,
    nome VARCHAR(50),
    PRIMARY KEY(cpfCliente,cpfDependente),
    FOREIGN KEY(cpfCliente) REFERENCES cliente(cpf)
    
);
--> entidade regularizada 2(Avaliacao) <--
CREATE TABLE avaliacao(
    id INT,
    data DATE NOT NULL,
    nota FLOAT NOT NULL,
    comentario VARCHAR(256),
    cpfCliente CHAR(11),
    PRIMARY KEY (id)
);


--> atributo multivalorado (entidade quarto)<--
CREATE TABLE equipamentos(
    id INT,
    nomeEquipamento VARCHAR(30) NOT NULL,
    numeroQuarto INT NOT NULL,
    PRIMARY KEY (id, numeroQuarto),
    FOREIGN KEY (numeroQuarto) REFERENCES quarto(numero)
    
);
--> entidade regularizada 4(Produto) <--
CREATE TABLE produto(
    tipo VARCHAR(40) NOT NULL,
    id INT,
    nome VARCHAR(50) NOT NULL,
    valor FLOAT NOT NULL,
    descricao VARCHAR(255),
    PRIMARY KEY(id)

);

--> relacionamento m n (produtos/quartos) <--
CREATE TABLE vendaProdutos(
    numeroDoQuarto INT NOT NUll,
    data DATE NOT NULL,
    quantidade INT NOT NULL,
    idProduto INT,
    PRIMARY KEY(idProduto,numeroDoQuarto),
    FOREIGN KEY(idProduto) REFERENCES produto(id)


);



-->  relacionamento quarto cliente <--
ALTER TABLE quarto
ADD cpfCliente CHAR(11) NOT NULL
ADD diaCheckin DATE NOT NULL
ADD diaCheckout DATE NOT NULL
ADD CONSTRAINT cpfcClienteFk
FOREIGN KEY(cpfCliente) REFERENCES cliente(cpf);

 -- > realcionamento quarto e manutencao
ALTER TABLE quarto
ADD cpfFuncionario CHAR(11)
ADD data DATE NOT NULL
ADD tipo VARCHAR(50) NOT NULL
ADD observacao VARCHAR(256)
ADD CONSTRAINT cpfFuncionarioFk FOREIGN KEY(cpfFuncionario) REFERENCES funcionario(cpf);

