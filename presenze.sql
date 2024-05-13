create table uscita
(
    id     int unsigned auto_increment
        primary key,
    motivo varchar(50) null
);

create table utente
(
    id       int unsigned auto_increment
        primary key,
    nome     varchar(100) not null,
    cognome  varchar(100) not null,
    username varchar(100) not null,
    password varchar(100) not null,
    constraint studente_pk_2
        unique (username)
);

create table presenza
(
    id           int unsigned auto_increment
        primary key,
    id_utente    int(11) unsigned not null,
    inizio_turno datetime         null,
    fine_turno   datetime         null,
    entrata      tinyint(1)       null,
    id_uscita    int(11) unsigned null,
    constraint id_uscita
        foreign key (id_uscita) references uscita (id),
    constraint id_utente
        foreign key (id_utente) references utente (id)
);


