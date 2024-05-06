-- Here you can add any sql you want such as queries to create tables, insert data, etc.
-- The file will only be executed when you change anything in it and will run only once.
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "ban_mapas_md1" (
	"id_md1"	INTEGER NOT NULL UNIQUE,
	"id_partida"	INTEGER,
	"id_time"	INTEGER,
	"ban1"	INTEGER,
	"ban2"	INTEGER,
	"ban3"	INTEGER,
	"ban4"	INTEGER,
	"pick"	INTEGER,
	FOREIGN KEY("ban2") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("ban4") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("ban1") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_time") REFERENCES "time"("id_time"),
	FOREIGN KEY("pick") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("ban3") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_partida") REFERENCES "partida"("id_partida"),
	PRIMARY KEY("id_md1" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ban_mapas_md3" (
	"id_md3"	INTEGER NOT NULL UNIQUE,
	"id_partida"	INTEGER,
	"id_time"	INTEGER,
	"ban1"	INTEGER,
	"ban2"	INTEGER,
	"pick"	INTEGER,
	"ban3"	INTEGER,
	"decider"	INTEGER,
	FOREIGN KEY("pick") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("ban1") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("decider") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_time") REFERENCES "partida"("id_partida"),
	FOREIGN KEY("id_partida") REFERENCES "partida"("id_partida"),
	FOREIGN KEY("ban3") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("ban2") REFERENCES "mapa"("id_mapa"),
	PRIMARY KEY("id_md3" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ban_operador" (
	"id_ban"	INTEGER NOT NULL UNIQUE,
	"id_partida"	INTEGER,
	"id_time"	INTEGER,
	"ban1"	INTEGER,
	"ban2"	INTEGER,
	FOREIGN KEY("id_time") REFERENCES "time"("id_time"),
	FOREIGN KEY("id_partida") REFERENCES "partida"("id_partida"),
	FOREIGN KEY("ban1") REFERENCES "operador"("id_operador"),
	FOREIGN KEY("ban2") REFERENCES "operador"("id_operador"),
	PRIMARY KEY("id_ban" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "jogador" (
	"id_jogador"	INTEGER NOT NULL UNIQUE,
	"nome_jogador"	INTEGER,
	"foto"	BLOB,
	"id_time"	INTEGER,
	PRIMARY KEY("id_jogador" AUTOINCREMENT),
	FOREIGN KEY("id_time") REFERENCES "time"("id_time")
);
CREATE TABLE IF NOT EXISTS "jogador_partida" (
	"id_jogador_partida"	INTEGER NOT NULL UNIQUE,
	"id_jogador"	INTEGER,
	"id_partida"	INTEGER,
	"id_time"	INTEGER,
	"kills"	INTEGER,
	"deaths"	INTEGER,
	"plants"	INTEGER,
	"disarms"	INTEGER,
	"1vX"	INTEGER,
	"HS"	INTEGER,
	"id_operador_atk"	INTEGER,
	"id_operador_def"	INTEGER,
	"open_kill"	INTEGER,
	"open_death"	INTEGER,
	PRIMARY KEY("id_jogador_partida" AUTOINCREMENT),
	FOREIGN KEY("id_jogador") REFERENCES "jogador"("id_jogador"),
	FOREIGN KEY("id_time") REFERENCES "time"("id_time"),
	FOREIGN KEY("id_operador_def") REFERENCES "operador"("id_operador"),
	FOREIGN KEY("id_operador_atk") REFERENCES "operador"("id_operador"),
	FOREIGN KEY("id_partida") REFERENCES "partida"("id_partida")
);
CREATE TABLE IF NOT EXISTS "mapa" (
	"id_mapa"	INTEGER NOT NULL UNIQUE,
	"map_name"	TEXT,
	"nome_mapa"	TEXT,
	"foto"	BLOB,
	PRIMARY KEY("id_mapa" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "operador" (
	"id_operador"	INTEGER NOT NULL UNIQUE,
	"nome_operador"	TEXT,
	"lado_operador"	TEXT(3),
	"icone"	BLOB,
	"foto"	BLOB,
	PRIMARY KEY("id_operador" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "partida" (
	"id_partida"	INTEGER NOT NULL UNIQUE,
	"id_regiao"	INTEGER NOT NULL,
	"data"	TEXT,
	"md1"	INTEGER(1),
	"md3"	INTEGER(1),
	"id_md1"	INTEGER,
	"id_md3"	INTEGER,
	"id_ban1"	INTEGER,
	"id_ban2"	INTEGER,
	"id_mapa1"	INTEGER NOT NULL,
	"id_mapa2"	INTEGER,
	"id_mapa3"	INTEGER,
	"id_time1"	INTEGER,
	"id_time2"	INTEGER,
	"qtd_rounds"	INTEGER,
	PRIMARY KEY("id_partida" AUTOINCREMENT),
	FOREIGN KEY("id_ban1") REFERENCES "ban_operador"("id_ban"),
	FOREIGN KEY("id_mapa2") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_time1") REFERENCES "time_partida"("id_time_partida"),
	FOREIGN KEY("id_md3") REFERENCES "ban_mapas_md3"("id_md3"),
	FOREIGN KEY("id_md1") REFERENCES "ban_mapas_md1"("id_md1"),
	FOREIGN KEY("id_mapa3") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_time2") REFERENCES "time_partida"("id_time_partida"),
	FOREIGN KEY("id_regiao") REFERENCES "regiao"("id_regiao"),
	FOREIGN KEY("id_mapa1") REFERENCES "mapa"("id_mapa"),
	FOREIGN KEY("id_ban2") REFERENCES "ban_operador"("id_ban")
);
CREATE TABLE IF NOT EXISTS "regiao" (
	"id_regiao"	INTEGER NOT NULL UNIQUE,
	"nome_regiao"	TEXT,
	"foto"	BLOB,
	PRIMARY KEY("id_regiao" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "staff" (
	"id_staff"	INTEGER NOT NULL UNIQUE,
	"nome_staff"	TEXT,
	"id_time"	INTEGER,
	"funcao"	TEXT,
	"foto"	BLOB,
	PRIMARY KEY("id_staff" AUTOINCREMENT),
	FOREIGN KEY("id_time") REFERENCES "time"("id_time")
);
CREATE TABLE IF NOT EXISTS "time" (
	"id_time"	INTEGER NOT NULL UNIQUE,
	"nome_time"	TEXT,
	"foto"	BLOB,
	"id_regiao"	INTEGER,
	PRIMARY KEY("id_time" AUTOINCREMENT),
	FOREIGN KEY("id_regiao") REFERENCES "regiao"("id_regiao")
);
CREATE TABLE IF NOT EXISTS "time_partida" (
	"id_time_partida"	INTEGER NOT NULL UNIQUE,
	"id_time"	INTEGER,
	"id_partida"	INTEGER,
	"vitoria"	INTEGER,
	"rounds_vencidos"	INTEGER,
	"rounds_perdidos"	INTEGER,
	PRIMARY KEY("id_time_partida" AUTOINCREMENT),
	FOREIGN KEY("id_partida") REFERENCES "partida"("id_partida"),
	FOREIGN KEY("id_time") REFERENCES "time"("id_time")
);
COMMIT;
