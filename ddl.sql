/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     5/30/2022 3:45:14 PM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GAMES') and o.name = 'FK_GAMES_ADD_GAMES_ADMINS')
alter table GAMES
   drop constraint FK_GAMES_ADD_GAMES_ADMINS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GAMES') and o.name = 'FK_GAMES_DEVELOP_G_VENDORS')
alter table GAMES
   drop constraint FK_GAMES_DEVELOP_G_VENDORS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTS') and o.name = 'FK_RENTS_RELATIONS_CLIENTS')
alter table RENTS
   drop constraint FK_RENTS_RELATIONS_CLIENTS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTS') and o.name = 'FK_RENTS_RELATIONS_GAMES')
alter table RENTS
   drop constraint FK_RENTS_RELATIONS_GAMES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ADMINS')
            and   type = 'U')
   drop table ADMINS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTS')
            and   type = 'U')
   drop table CLIENTS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GAMES')
            and   name  = 'DEVELOP_GAMES_FK'
            and   indid > 0
            and   indid < 255)
   drop index GAMES.DEVELOP_GAMES_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GAMES')
            and   name  = 'ADD_GAMES_FK'
            and   indid > 0
            and   indid < 255)
   drop index GAMES.ADD_GAMES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GAMES')
            and   type = 'U')
   drop table GAMES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTS')
            and   name  = 'RELATIONSHIP_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTS.RELATIONSHIP_6_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTS')
            and   name  = 'RELATIONSHIP_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTS.RELATIONSHIP_5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RENTS')
            and   type = 'U')
   drop table RENTS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VENDORS')
            and   type = 'U')
   drop table VENDORS
go

/*==============================================================*/
/* Table: ADMINS                                                */
/*==============================================================*/
create table ADMINS (
   ADMIN_ID             int                  not null,
   ADMIN_FIRST_NAME     varchar(15)          not null,
   ADMIN_LAST_NAME      varchar(15)          not null,
   ADMIN_EMAIL          varchar(40)          not null,
   ADMIN_PASSWORD       varchar(20)          null,
   constraint PK_ADMINS primary key nonclustered (ADMIN_ID)
)
go

/*==============================================================*/
/* Table: CLIENTS                                               */
/*==============================================================*/
create table CLIENTS (
   CLIENT_ID            int                  not null,
   CLIENT_FIRST_NAME    varchar(15)          not null,
   CLIENT_LAST_NAME     varchar(15)          not null,
   CLIENT_EMAIL         varchar(40)          not null,
   CLIENT_PASSWORD      varchar(20)          null,
   CLIENT_RENTS         int                  null,
   constraint PK_CLIENTS primary key nonclustered (CLIENT_ID)
)
go

/*==============================================================*/
/* Table: GAMES                                                 */
/*==============================================================*/
create table GAMES (
   GAME_ID              int                  not null,
   VENDOR_ID            int                  not null,
   ADMIN_ID             int                  not null,
   GAME_NAME            varchar(40)          not null,
   YEAR                 numeric(4)           not null,
   RENT_PRICE           numeric(5)           null,
   NUMBER_OF_RENTERS    int                  null,
   constraint PK_GAMES primary key nonclustered (GAME_ID)
)
go

/*==============================================================*/
/* Index: ADD_GAMES_FK                                          */
/*==============================================================*/
create index ADD_GAMES_FK on GAMES (
ADMIN_ID ASC
)
go

/*==============================================================*/
/* Index: DEVELOP_GAMES_FK                                      */
/*==============================================================*/
create index DEVELOP_GAMES_FK on GAMES (
VENDOR_ID ASC
)
go

/*==============================================================*/
/* Table: RENTS                                                 */
/*==============================================================*/
create table RENTS (
   CLIENT_ID            int                  not null,
   GAME_ID              int                  not null,
   MONTH                numeric(2)           null,
   constraint PK_RENTS primary key (CLIENT_ID, GAME_ID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on RENTS (
CLIENT_ID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on RENTS (
GAME_ID ASC
)
go

/*==============================================================*/
/* Table: VENDORS                                               */
/*==============================================================*/
create table VENDORS (
   VENDOR_ID            int                  not null,
   VENDOR_FIRST_NAME    varchar(15)          not null,
   VENDOR_LAST_NAME     varchar(15)          not null,
   VENDOR_RENTS         int                  null,
   constraint PK_VENDORS primary key nonclustered (VENDOR_ID)
)
go

alter table GAMES
   add constraint FK_GAMES_ADD_GAMES_ADMINS foreign key (ADMIN_ID)
      references ADMINS (ADMIN_ID)
go

alter table GAMES
   add constraint FK_GAMES_DEVELOP_G_VENDORS foreign key (VENDOR_ID)
      references VENDORS (VENDOR_ID)
go

alter table RENTS
   add constraint FK_RENTS_RELATIONS_CLIENTS foreign key (CLIENT_ID)
      references CLIENTS (CLIENT_ID)
go

alter table RENTS
   add constraint FK_RENTS_RELATIONS_GAMES foreign key (GAME_ID)
      references GAMES (GAME_ID)
go

