drop table DEPARTAMENTO;

drop table DEPOSITO;

drop table LOCALIDAD;

drop table LOTE;

drop table PEDIDO;

drop table PEDIDO_LINEA;

drop table PERSONA;

drop table PERS_FISICA;

drop table PERS_JURIDICA;

drop table PRODUCTO;

drop table TIPO_DOC;

drop table TIPO_PROD;

drop table TRANSACCION;

drop table TRAN_ESTADO;

drop table TRAN_LINEA;

drop table TRAN_VTA_LOTE;

drop table UNIDAD;

drop table USR_DSK;

drop table UTILIDAD;

/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
create table DEPARTAMENTO (
   ID_DEP               SERIAL not null,
   NOMBRE               TEXT                 not null,
   constraint PK_DEPARTAMENTO primary key (ID_DEP)
);

/*==============================================================*/
/* Table: DEPOSITO                                              */
/*==============================================================*/
create table DEPOSITO (
   NRO_DEP              SERIAL               not null,
   NOMBRE               TEXT                 not null,
   constraint PK_DEPOSITO primary key (NRO_DEP)
);

/*==============================================================*/
/* Table: LOCALIDAD                                             */
/*==============================================================*/
create table LOCALIDAD (
   ID_LOC               SERIAL not null,
   NOMBRE               TEXT                 not null,
   ID_DEP               INTEGER              null,
   constraint PK_LOCALIDAD primary key (ID_LOC)
);

/*==============================================================*/
/* Table: LOTE                                                  */
/*==============================================================*/
create table LOTE (
   ID_LOTE              SERIAL not null,
   NRO_TRANSAC          INTEGER              not null,
   ID_PRODUCTO          INTEGER              not null,
   VENC                 DATE                 null,
   NRO_DEP              INTEGER              null,
   ID_UTIL              INTEGER              null,
   STOCK                INTEGER              not null,
   STOCK_INI            INTEGER              not null,
   constraint PK_LOTE primary key (ID_LOTE)
);

/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
create table PEDIDO (
   ID_PERSONA           BIGINT               not null,
   FECHA_HORA           TIMESTAMP            not null,
   ESTADO               CHAR                 not null,
   FECHA_PROG           DATE                 null,
   HORA_PROG            TIME                 null,
   ORIGEN               CHAR(1)              not null,
   SUB_TOTAL            NUMERIC(12,2)        not null,
   IVA                  NUMERIC(12,2)        not null,
   TOTAL                NUMERIC(12,2)        not null,
   NOM_USU              TEXT                 null,
   NRO_TRANSAC          INTEGER              null,
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
   IVA                  DECIMAL(12,2)        null,
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
   TIPO                 char(1)              not null,
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
   ID_PRODUCTO          SERIAL not null,
   ID_TIPO_PROD         INTEGER              not null,
   CODIGO               TEXT                 not null,
   NOMBRE               TEXT                 not null,
   DESCRIPCION          TEXT                 null,
   STOCK_MIN            NUMERIC(7,2)         not null,
   APL_IVA              CHAR(1)              not null,
   ID_UNIDAD            INTEGER              not null,
   CANT_UNIDAD          NUMERIC(7,2)         not null,
   PRECIO               NUMERIC(7,2)         not null,
   SINC                 CHAR(1)              not null,
   ULT_ACT              TIMESTAMP            not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO),
   constraint CKT_PRODUCTO check (SINC in ('S', 'N') AND APL_IVA in ('B', 'M', 'E') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: TIPO_DOC                                              */
/*==============================================================*/
create table TIPO_DOC (
   ID_TIPO_DOC          SERIAL not null,
   NOMBRE               TEXT                 null,
   constraint PK_TIPO_DOC primary key (ID_TIPO_DOC)
);

/*==============================================================*/
/* Table: TIPO_PROD                                             */
/*==============================================================*/
create table TIPO_PROD (
   ID_TIPO_PROD         SERIAL not null,
   DESCRIPCION          TEXT                 not null,
   SINC                 CHAR(1)              not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_TIPO_PROD primary key (ID_TIPO_PROD),
   constraint CKT_TIPO_PROD check (SINC in ('S', 'N') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: TRANSACCION                                           */
/*==============================================================*/
create table TRANSACCION (
   NRO_TRANSAC          SERIAL not null,
   ID_PERSONA           BIGINT               null,
   OPERACION            CHAR(1)              not null,
   FECHA_HORA           TIMESTAMP            null,
   SUB_TOTAL            NUMERIC(12,2)        not null,
   IVA                  NUMERIC(12,2)        not null,
   TOTAL                NUMERIC(12,2)        not null,
   ESTADO_ACT           CHAR(1)              null,
   constraint PK_TRANSACCION primary key (NRO_TRANSAC),
   constraint CKT_TRANSACCION check (OPERACION in ('V', 'C'))
);

/*==============================================================*/
/* Table: TRAN_ESTADO                                           */
/*==============================================================*/
create table TRAN_ESTADO (
   NRO_TRANSAC          INTEGER              not null,
   ESTADO               CHAR(1)              not null,
   FECHA_HORA           TIMESTAMP            not null,
   constraint PK_TRAN_ESTADO primary key (NRO_TRANSAC, ESTADO),
   constraint CKT_TRAN_ESTADO check (ESTADO in ('P', 'C', 'A'))
);

/*==============================================================*/
/* Table: TRAN_LINEA                                            */
/*==============================================================*/
create table TRAN_LINEA (
   NRO_TRANSAC          INTEGER              not null,
   ID_PRODUCTO          INTEGER              not null,
   CANTIDAD             INTEGER              not null,
   IVA                  NUMERIC(12,2)        not null,
   PRECIO_UNIT          NUMERIC(12,2)        not null,
   constraint PK_TRAN_LINEA primary key (NRO_TRANSAC, ID_PRODUCTO)
);

/*==============================================================*/
/* Table: TRAN_VTA_LOTE                                         */
/*==============================================================*/
create table TRAN_VTA_LOTE (
   NRO_TRANSAC          INTEGER              not null,
   ID_PRODUCTO          INTEGER              not null,
   ID_LOTE              INTEGER              not null,
   CANTIDAD             INTEGER              not null,
   constraint PK_TRAN_VTA_LOTE primary key (NRO_TRANSAC, ID_PRODUCTO, ID_LOTE)
);

/*==============================================================*/
/* Table: UNIDAD                                                */
/*==============================================================*/
create table UNIDAD (
   ID_UNIDAD            SERIAL not null,
   NOMBRE               TEXT                 not null,
   SINC                 CHAR(1)              not null,
   ACTIVO               NUMERIC(1)           not null,
   constraint PK_UNIDAD primary key (ID_UNIDAD),
   constraint CKT_UNIDAD check (SINC in ('S', 'N') AND ACTIVO in (0,1))
);

/*==============================================================*/
/* Table: USR_DSK                                               */
/*==============================================================*/
create table USR_DSK (
   NOM_USU              TEXT                 not null,
   PASSWD               TEXT                 null,
   TIPO                 CHAR(1)              not null,
   constraint PK_USR_DSK primary key (NOM_USU)
);

/*==============================================================*/
/* Table: UTILIDAD                                              */
/*==============================================================*/
create table UTILIDAD (
   ID_UTIL              SERIAL not null,
   DESCRIPCION          TEXT                 not null,
   PORC                 DECIMAL(5,2)         not null,
   constraint PK_UTILIDAD primary key (ID_UTIL)
);

alter table LOCALIDAD
   add constraint FK_LOCALIDA_REFERENCE_DEPARTAM foreign key (ID_DEP)
      references DEPARTAMENTO (ID_DEP)
      on delete restrict on update restrict;

alter table LOTE
   add constraint FK_LOTE_REFERENCE_DEPOSITO foreign key (NRO_DEP)
      references DEPOSITO (NRO_DEP)
      on delete restrict on update restrict;

alter table LOTE
   add constraint FK_LOTE_REFERENCE_UTILIDAD foreign key (ID_UTIL)
      references UTILIDAD (ID_UTIL)
      on delete restrict on update restrict;

alter table LOTE
   add constraint FK_LOTE_REFERENCE_TRAN_LIN foreign key (NRO_TRANSAC, ID_PRODUCTO)
      references TRAN_LINEA (NRO_TRANSAC, ID_PRODUCTO)
      on delete restrict on update restrict;

alter table PEDIDO
   add constraint FK_PEDIDO_REFERENCE_USR_DSK foreign key (NOM_USU)
      references USR_DSK (NOM_USU)
      on delete restrict on update restrict;

alter table PEDIDO
   add constraint FK_PEDIDO_REFERENCE_TRANSACC foreign key (NRO_TRANSAC)
      references TRANSACCION (NRO_TRANSAC)
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
      on delete cascade on update cascade;

alter table PERS_FISICA
   add constraint FK_PERS_FIS_REFERENCE_TIPO_DOC foreign key (ID_TIPO_DOC)
      references TIPO_DOC (ID_TIPO_DOC)
      on delete restrict on update restrict;

alter table PERS_JURIDICA
   add constraint FK_PERS_JUR_REFERENCE_PERSONA foreign key (RUT)
      references PERSONA (ID_PERSONA)
      on delete cascade on update cascade;

alter table PRODUCTO
   add constraint FK_PRODUCTO_REFERENCE_UNIDAD foreign key (ID_UNIDAD)
      references UNIDAD (ID_UNIDAD)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_REFERENCE_TIPO_PRO foreign key (ID_TIPO_PROD)
      references TIPO_PROD (ID_TIPO_PROD)
      on delete restrict on update restrict;

alter table TRANSACCION
   add constraint FK_TRANSACC_REFERENCE_PERSONA foreign key (ID_PERSONA)
      references PERSONA (ID_PERSONA)
      on delete restrict on update restrict;

alter table TRAN_ESTADO
   add constraint FK_TRAN_EST_REFERENCE_TRANSACC foreign key (NRO_TRANSAC)
      references TRANSACCION (NRO_TRANSAC)
      on delete restrict on update restrict;

alter table TRAN_LINEA
   add constraint FK_TRAN_LIN_REFERENCE_TRANSACC foreign key (NRO_TRANSAC)
      references TRANSACCION (NRO_TRANSAC)
      on delete restrict on update restrict;

alter table TRAN_LINEA
   add constraint FK_TRAN_LIN_REFERENCE_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
      on delete restrict on update restrict;

alter table TRAN_VTA_LOTE
   add constraint FK_TRAN_VTA_REFERENCE_TRAN_LIN foreign key (NRO_TRANSAC, ID_PRODUCTO)
      references TRAN_LINEA (NRO_TRANSAC, ID_PRODUCTO)
      on delete restrict on update restrict;

alter table TRAN_VTA_LOTE
   add constraint FK_TRAN_VTA_REFERENCE_LOTE foreign key (ID_LOTE)
      references LOTE (ID_LOTE)
      on delete restrict on update restrict;
