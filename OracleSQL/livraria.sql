
create table Cliente(
    idCliente smallint not null primary key ,
    CPF_CNPJ number not null,
    nome varchar(60) not null,
    telefone number not null,
    endereco varchar (500)
);


create table Pontuacao (
    idPonto smallint not null primary key,
    prazo date not null
);


create table Editoras (
    idEdi smallint not null primary key,
    telefone number not null,
    endereco varchar (500),
    nomeGerente varchar (60) not null
);


create table autores (
    idAutor smallint not null primary key,
    nome varchar(80) not null
);


create table Assunto (
    idAssunto smallint not null primary key,
    nome varchar (200) not null
);


create table Livros (
    isbn smallint not null primary key,
    titulo varchar(300) not null,
    estoque number,
    nrEdicao smallint not null,
    idAutor smallint not null,
    idEdi smallint not null,
    idAssunto smallint not null,
    foreign key (idAutor) references autores (idAutor),
    FOREIGN key (idAssunto) references Assunto (idAssunto),
    foreign key (idEdi) references Editoras  (idEdi)
);


create table Compras (
    idCompra smallint not null primary key,
    valor number (14,2) not null,
    dataCompra date not null,
    formaPagamento varchar(100),
    idcliente smallint not null,
    idPonto smallint not null,
    isbn smallint not null,
    foreign key (idcliente) references Cliente (idCliente),
    foreign key (idPonto) references Pontuacao (idPonto),
    foreign key (isbn) references Livros (isbn)
);


