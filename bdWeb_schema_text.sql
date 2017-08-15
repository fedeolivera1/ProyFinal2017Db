drop table DEPARTAMENTO;

drop table LOCALIDAD;

drop table PEDIDO;

drop table PEDIDO_LINEA;

drop table PERSONA;

drop table PERS_FISICA;

drop table PERS_JURIDICA;

drop table PRODUCTO;

drop table TIPO_DOC;

drop table TIPO_PROD;

drop table UNIDAD;

drop table USR_WEB;

/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
create table DEPARTAMENTO (
   ID_DEP               SERIAL               not null,
   NOMBRE               TEXT                 not null,
   constraint PK_DEPARTAMENTO primary key (ID_DEP)
);

/*==============================================================*/
/* Table: LOCALIDAD                                             */
/*==============================================================*/
create table LOCALIDAD (
   ID_LOC               SERIAL               not null,
   NOMBRE               TEXT                 not null,
   ID_DEP               INTEGER              null,
   constraint PK_LOCALIDAD primary key (ID_LOC)
);

/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
create table PEDIDO (
   ID_PERSONA           BIGINT               not null,
   FECHA_HORA           TIMESTAMP            not null,
   ESTADO               CHAR(1)              not null,
   FECHA_PROG           DATE                 null,
   HORA_PROG            TIME                 null,
   ORIGEN               CHAR(1)              not null,
   SUB_TOTAL            NUMERIC(12,2)        not null,
   IVA                  DECIMAL(12,2)        not null,
   TOTAL                NUMERIC(12,2)        not null,
   SINC                 CHAR(1)              not null,
   ULT_ACT              TIMESTAMP            not null,
   constraint PK_PEDIDO primary key (ID_PERSONA, FECHA_HORA),
   constraint CKT_PEDIDO check (SINC in ('S', 'N'))
);

/*==============================================================*/
/* Table: PEDIDO_LINEA                                          */
/*==============================================================*/
create table PEDIDO_LINEA (
   ID_PERSONA           BIGINT               not null,
   FECHA_HORA           TIMESTAMP            not null,
   ID_PRODUCTO          INTEGER              not null,
   CANTIDAD             INTEGER              not null,
   IVA                  NUMERIC(12,2)        null,
   PRECIO_UNIT          NUMERIC(12,2)        null,
   constraint PK_PEDIDO_LINEA primary key (ID_PERSONA, FECHA_HORA, ID_PRODUCTO)
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA (
   ID_PERSONA           BIGINT               not null,
   DIRECCION            TEXT                 not null,
   PUERTA               TEXT                 null,
   SOLAR                TEXT                 null,
   MANZANA              TEXT                 null,
   KM                   NUMERIC(7,2)         null,
   COMPLEMENTO          TEXT                 null,
   TELEFONO             TEXT                 null,
   CELULAR              TEXT                 null,
   EMAIL                TEXT                 null,
   FECHA_REG            DATE                 null,
   TIPO                 char(1)              null,
   ID_LOC               INTEGER              null,
   ORIGEN               CHAR(1)              not null,
   SINC                 CHAR(1)              not null,
   ULT_ACT              TIMESTAMP            not null,
   constraint PK_PERSONA primary key (ID_PERSONA),
   constraint CKT_PERSONA check (SINC in ('S', 'N'))
);

/*==============================================================*/
/* Table: PERS_FISICA                                           */
/*==============================================================*/
create table PERS_FISICA (
   DOCUMENTO            BIGINT               not null,
   ID_TIPO_DOC          INTEGER              not null,
   APELLIDO1            TEXT                 null,
   APELLIDO2            TEXT                 null,
   NOMBRE1              TEXT                 null,
   NOMBRE2              TEXT                 null,
   FECHA_NAC            DATE                 null,
   SEXO                 char(1)              null,
   constraint PK_PERS_FISICA primary key (DOCUMENTO),
   constraint CKT_PERS_FISICA check (SEXO in ('M', 'F'))
);

/*==============================================================*/
/* Table: PERS_JURIDICA                                         */
/*==============================================================*/
create table PERS_JURIDICA (
   RUT                  BIGINT               not null,
   NOMBRE               TEXT                 not null,
   RAZON_SOCIAL         TEXT                 null,
   BPS                  TEXT                 null,
   BSE                  TEXT                 null,
   ES_PROV              CHAR(1)              not null,
   constraint PK_PERS_JURIDICA primary key (RUT)
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PRODUCTO          INTEGER              not null,
   CODIGO               TEXT                 not null,
   NOMBRE               TEXT                 not null,
   DESCRIPCION          TEXT                 null,
   STOCK_MIN            NUMERIC(7,2)         not null,
   APL_IVA              CHAR(1)              not null,
   ID_UNIDAD            INTEGER              not null,
   ID_TIPO_PROD         INTEGER              null,
   CANT_UNIDAD          INTEGER              not null,
   PRECIO               NUMERIC(7,2)         not null,
   SINC                 CHAR(1)              not null,
   ULT_ACT              TIMESTAMP            not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO),
   constraint CKT_PRODUCTO check (SINC in ('S', 'N') AND APL_IVA in ('B', 'M', 'X') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: TIPO_DOC                                              */
/*==============================================================*/
create table TIPO_DOC (
   ID_TIPO_DOC          INTEGER              not null,
   NOMBRE               TEXT                 null,
   constraint PK_TIPO_DOC primary key (ID_TIPO_DOC)
);

/*==============================================================*/
/* Table: TIPO_PROD                                             */
/*==============================================================*/
create table TIPO_PROD (
   ID_TIPO_PROD         INTEGER              not null,
   DESCRIPCION          TEXT                 not null,
   SINC                 CHAR(1)              not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_TIPO_PROD primary key (ID_TIPO_PROD),
   constraint CKT_TIPO_PROD check (SINC in ('S', 'N') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: UNIDAD                                                */
/*==============================================================*/
create table UNIDAD (
   ID_UNIDAD            INTEGER              not null,
   NOMBRE               TEXT                 not null,
   SINC                 CHAR(1)              not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_UNIDAD primary key (ID_UNIDAD),
   constraint CKT_UNIDAD check (SINC in ('S', 'N') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: USR_WEB                                               */
/*==============================================================*/
create table USR_WEB (
   NOM_USU              TEXT                 not null,
   PASSWD               TEXT                 not null,
   ID_PERSONA           BIGINT               not null,
   constraint PK_USR_WEB primary key (NOM_USU)
);

alter table LOCALIDAD
   add constraint FK_LOCALIDA_REFERENCE_DEPARTAM foreign key (ID_DEP)
      references DEPARTAMENTO (ID_DEP)
      on delete restrict on update restrict;

alter table PEDIDO
   add constraint FK_PEDIDO_REFERENCE_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA)
      on delete restrict on update restrict;

alter table PEDIDO_LINEA
   add constraint FK_PEDIDO_L_REFERENCE_PEDIDO foreign key (ID_PERSONA, FECHA_HORA)
      references PEDIDO (ID_PERSONA, FECHA_HORA)
      on delete restrict on update restrict;

alter table PEDIDO_LINEA
   add constraint FK_PEDIDO_L_REFERENCE_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
      on delete restrict on update restrict;

alter table PERSONA
   add constraint FK_PERSONA_REFERENCE_LOCALIDA foreign key (ID_LOC)
      references LOCALIDAD (ID_LOC)
      on delete restrict on update restrict;

alter table PERS_FISICA
   add constraint FK_PERS_FIS_REFERENCE_PERSONA foreign key (DOCUMENTO)
      references PERSONA (ID_PERSONA)
      on delete restrict on update restrict;

alter table PERS_FISICA
   add constraint FK_PERS_FIS_REFERENCE_TIPO_DOC foreign key (ID_TIPO_DOC)
      references TIPO_DOC (ID_TIPO_DOC)
      on delete restrict on update restrict;

alter table PERS_JURIDICA
   add constraint FK_PERS_JUR_REFERENCE_PERSONA foreign key (RUT)
      references PERSONA (ID_PERSONA)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_REFERENCE_UNIDAD foreign key (ID_UNIDAD)
      references UNIDAD (ID_UNIDAD)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_REFERENCE_TIPO_PRO foreign key (ID_TIPO_PROD)
      references TIPO_PROD (ID_TIPO_PROD)
      on delete restrict on update restrict;

alter table USR_WEB
   add constraint FK_USR_WEB_REFERENCE_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA)
      on delete restrict on update restrict;
