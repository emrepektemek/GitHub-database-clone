CREATE TABLE "Hesap" (
 "hesapNo" SERIAL,
 "kullaniciAdi" VARCHAR(15) NOT NULL,
 "sifre" VARCHAR(20) NOT NULL,
 "eposta" VARCHAR(20) NOT NULL,
 "kayitTarihi" TIMESTAMP DEFAULT '2020-12-03 12:15:49',
 "takipciSayi" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "takipSayi" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "yildizSayi" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "hesapTipi" CHAR(1) NOT NULL,
 CONSTRAINT "hesapPK" PRIMARY KEY("hesapNo"),
 CONSTRAINT "hesapAD" UNIQUE("kullaniciAdi"),
 CONSTRAINT "hesapEposta" UNIQUE("eposta")
);
CREATE TABLE "Depo"(
 "depoNo" SERIAL,
 "depoAdi" VARCHAR(15) NOT NULL,
 "songuncellemeTarihi" TIMESTAMP DEFAULT '2020-12-01 12:15:49',
 "yazilimDili" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "forkSayi" VARCHAR(20) DEFAULT 'Bilinmiyor',
 "yildizSayi" VARCHAR(15) DEFAULT 'Bilinmiyor',
 CONSTRAINT "depoPK" PRIMARY KEY("depoNo")
);
CREATE TABLE "Premium" (
"hesapNo" INTEGER,
"satinalimTarihi" TIMESTAMP NOT NULL,
CONSTRAINT "premiumPK" PRIMARY KEY ("hesapNo")
);
ALTER TABLE "Premium"
ADD CONSTRAINT "HesapPremium" FOREIGN KEY ("hesapNo")
REFERENCES "Hesap" ("hesapNo")
ON DELETE CASCADE
ON UPDATE CASCADE;
CREATE TABLE "Normal" (
"hesapNo" INTEGER,
CONSTRAINT "normalPK" PRIMARY KEY ("hesapNo")
);
ALTER TABLE "Normal"
ADD CONSTRAINT "HesapNormal" FOREIGN KEY ("hesapNo")
REFERENCES "Hesap" ("hesapNo")
ON DELETE CASCADE
ON UPDATE CASCADE;
CREATE TABLE "Fatura" (
 "faturaNo" SERIAL,
 "aylikFatura" money,
 "premiumbitisTarihi" TIMESTAMP,
 "hesapNo" INTEGER NOT NULL,
 CONSTRAINT "faturaPK" PRIMARY KEY("faturaNo"),
 CONSTRAINT "faturaFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo")
);
CREATE TABLE "Takip"(
 "takipNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "takipedilenhesapNo" INTEGER NOT NULL,
 "takipTarihi" TIMESTAMP,
 CONSTRAINT "takipPK" PRIMARY KEY("takipNo"),
 CONSTRAINT "guvenlikFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "guvenlikFK2" FOREIGN KEY("takipedilenhesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "takipUNIQUE" UNIQUE("hesapNo", "takipedilenhesapNo")
);
CREATE TABLE "Takipci"(
 "takipciNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "takipcihesapNo" INTEGER NOT NULL,
 CONSTRAINT "takipciPK" PRIMARY KEY("takipciNo"),
 CONSTRAINT "guvenlikFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "guvenlikFK2" FOREIGN KEY("takipcihesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "takipciUNIQUE" UNIQUE("hesapNo", "takipcihesapNo")
);
CREATE TABLE "Engel"(
 "engelNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "engelhesapNo" INTEGER NOT NULL,
 "engelTarihi" TIMESTAMP, 
 CONSTRAINT "engelPK" PRIMARY KEY("engelNo"),
 CONSTRAINT "guvenlikFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "guvenlikFK2" FOREIGN KEY("engelhesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "engelUNIQUE" UNIQUE("hesapNo", "engelhesapNo")
);
CREATE TABLE "GuvenlikGunlugu"(
 "guvenlikNo" SERIAL,
 "ip" cidr NOT NULL,
 "yer" VARCHAR(15) NOT NULL,
 "tarih" TIMESTAMP NOT NULL,
 "hesapNo" INTEGER NOT NULL,
 CONSTRAINT "guvenlikPK" PRIMARY KEY("guvenlikNo"),
 CONSTRAINT "guvenlikFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo")
);
CREATE TABLE "Profil" (
 "profilNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "isim" VARCHAR(20) DEFAULT 'Bilinmiyor' ,
 "bio" TEXT DEFAULT 'Bilinmiyor',
 "url" VARCHAR(100) DEFAULT 'Bilinmiyor',
 "twitterkullaniciAdi" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "sirket" VARCHAR(15) DEFAULT 'Bilinmiyor',
 "geneleposta" VARCHAR(50) DEFAULT 'Bilinmiyor',
 CONSTRAINT "profilPK" PRIMARY KEY("profilNo"),
 CONSTRAINT "twitterUNIQUE" UNIQUE("twitterkullaniciAdi"),
 CONSTRAINT "hesapnoUNIQUE" UNIQUE("hesapNo"),
 CONSTRAINT "profilkFK" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo")
);
CREATE TABLE "DepoOlustur"(
 "olusturNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "depoNo" INTEGER NOT NULL,
 "olusturmaTarihi" TIMESTAMP,
 CONSTRAINT "depoolusturPK" PRIMARY KEY("olusturNo"),
 CONSTRAINT "depoolusturFK" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "depoolusturFK2" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "depoUNIQUE" UNIQUE("depoNo")
);
CREATE TABLE "VersiyonOlustur"(
 "versiyonNo" SERIAL,
 "versiyon" VARCHAR(5) NOT NULL,
 "depoNo" INTEGER NOT NULL,
 "olusturmaTarihi" TIMESTAMP,
 CONSTRAINT "versiyonPK" PRIMARY KEY("versiyonNo"),
 CONSTRAINT "versiyonFK" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "versiyonUNIQUE" UNIQUE("versiyon","depoNo")
);
CREATE TABLE "VersiyonUlas"(
 "ulasimNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "depoNo" INTEGER NOT NULL,
 "versiyon" VARCHAR(5) NOT NULL,
 "ulasimTarihi" TIMESTAMP,
 CONSTRAINT "versiyonulasPK" PRIMARY KEY("ulasimNo"),
 CONSTRAINT "versiyonulasFK1" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "versiyonulasFK2" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "versiyonulasUNIQUE" UNIQUE("hesapNo","depoNo","versiyon")
);
CREATE TABLE "Yildiz"(
 "yildizNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "depoNo" INTEGER NOT NULL,
 "yildizTarihi" TIMESTAMP,
 CONSTRAINT "yildizPK" PRIMARY KEY("yildizNo"),
 CONSTRAINT "yildizFK" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "yildizFK2" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "yildizUNIQUE" UNIQUE("hesapNo","depoNo")
);
CREATE TABLE "Fork"(
 "forkNo" SERIAL,
 "hesapNo" INTEGER NOT NULL,
 "depoNo" INTEGER NOT NULL,
 "kopyalanmaTarihi" TIMESTAMP,
 CONSTRAINT "forkPK" PRIMARY KEY("forkNo"),
 CONSTRAINT "forkFK" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "forkFK2" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo"),
 CONSTRAINT "forkUNIQUE" UNIQUE("hesapNo","depoNo")
);
CREATE TABLE "Klasor"(
 "klasorNo" SERIAL,
 "klasorismi" VARCHAR(20) NOT NULL,
 "eklenmeTarihi" TIMESTAMP,
 "hesapNo" INTEGER NOT NULL,
 "depoNo" INTEGER NOT NULL,
 CONSTRAINT "klasorPK" PRIMARY KEY("klasorNo"),
 CONSTRAINT "klasorFK" FOREIGN KEY("depoNo") REFERENCES "Depo"("depoNo"),
 CONSTRAINT "klasorFK2" FOREIGN KEY("hesapNo") REFERENCES "Hesap"("hesapNo")
);
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","yildizSayi","hesapTipi")
VALUES
('black', 'sreyjry465.','black12@hotmail.com','2020-04-15 16:47:01','1','1','1','N');
INSERT INTO "Normal"("hesapNo")
VALUES (1);
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","yildizSayi","hesapTipi")
VALUES
('red', 'xvnyter78','red15@hotmail.com','2020-04-17 23:02:15','2','0','0','N');
INSERT INTO "Normal"("hesapNo")
VALUES (2);
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","yildizSayi","hesapTipi")
VALUES
('blue', 'werthvb','blue16@hotmail.com','2020-04-18 02:50:34','1','0','1','P');
INSERT INTO "Premium"("hesapNo","satinalimTarihi")
VALUES (3,'2020-04-15 16:47:01');
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","yildizSayi","hesapTipi")
VALUES
('green', 'adwqhtr','green@hotmail.com','2020-04-18 03:32:49','0','2','1','N');
INSERT INTO "Normal"("hesapNo")
VALUES (4);
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","yildizSayi","hesapTipi")
VALUES
('yellow', 'eryrsqds','yellow6@hotmail.com','2020-05-01 12:50:08','1','2','2','P');
INSERT INTO "Premium"("hesapNo","satinalimTarihi")
VALUES (5,'2020-04-18 03:32:49');
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","yildizSayi","hesapTipi")
VALUES
('white', 'wqkjh48931','white@hotmail.com','2020-05-02 13:20:02','1','P');
INSERT INTO "Premium"("hesapNo","satinalimTarihi")
VALUES (6,'2020-05-02 13:37:59');
INSERT INTO "Hesap"
("kullaniciAdi", "sifre", "eposta","kayitTarihi","takipciSayi","takipSayi","hesapTipi")
VALUES
('purple', 'qw4813213','purple01@hotmail.com','2020-05-02 13:37:59','1','0','N');
INSERT INTO "Normal"("hesapNo")
VALUES (7);
INSERT INTO "Fatura"
("aylikFatura","hesapNo")
VALUES
(0,1);
INSERT INTO "Fatura"
("aylikFatura","hesapNo")
VALUES
(0,2);
INSERT INTO "Fatura"
("aylikFatura","hesapNo")
VALUES
(0,4);
INSERT INTO "Fatura"
("aylikFatura","hesapNo")
VALUES
(0,7);
INSERT INTO "Fatura"
("aylikFatura","premiumbitisTarihi","hesapNo")
VALUES
(5.00,'2020-05-15 16:47:01',3);
INSERT INTO "Fatura"
("aylikFatura","premiumbitisTarihi","hesapNo")
VALUES
(5.00,'2020-05-18 03:32:49',5);
INSERT INTO "Fatura"
("aylikFatura","premiumbitisTarihi","hesapNo")
VALUES
(5.00,'2020-06-02 13:37:59',6);
INSERT INTO "Takip"
("hesapNo","takipedilenhesapNo","takipTarihi")
VALUES
(2,4,'2020-05-01 12:50:08');
INSERT INTO "Takip"
("hesapNo","takipedilenhesapNo","takipTarihi")
VALUES
(2,7,'2020-04-17 23:02:15');
INSERT INTO "Takip"
("hesapNo","takipedilenhesapNo","takipTarihi")
VALUES
(5,3,'2020-04-18 02:50:34');
INSERT INTO "Takip"
("hesapNo","takipedilenhesapNo","takipTarihi")
VALUES
(5,2,'2020-05-02 13:20:02');
INSERT INTO "Takip"
("hesapNo","takipedilenhesapNo","takipTarihi")
VALUES
(7,2,'2020-04-15 16:47:01');
INSERT INTO "Takipci"
("hesapNo","takipcihesapNo")
VALUES
(4,2);
INSERT INTO "Takipci"
("hesapNo","takipcihesapNo")
VALUES
(7,2);
INSERT INTO "Takipci"
("hesapNo","takipcihesapNo")
VALUES
(3,5);
INSERT INTO "Takipci"
("hesapNo","takipcihesapNo")
VALUES
(2,5);
INSERT INTO "Takipci"
("hesapNo","takipcihesapNo")
VALUES
(2,7);
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(2,5,'2020-04-15 16:47:01');
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(5,2,'2020-04-15 16:47:01');
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(6,1,'2020-04-18 03:32:49');
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(1,6,'2020-04-18 03:32:49');
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(1,4,'2020-05-02 13:37:59');
INSERT INTO "Engel"
("hesapNo","engelhesapNo","engelTarihi")
VALUES
(4,1,'2020-05-02 13:37:59');
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('120.7','ANTALYA','2020-12-05 16:22:57',1);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('120.7','ANTALYA','2020-12-06 00:39:04',1);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('179.6','İSTANBUL','2020-11-17 23:59:01',2);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('138.1','ANKARA','2020-12-07 03:10:55',3);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('138.1','ANKARA','2020-12-07 03:18:35',3);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('158.7','SAKARYA','2020-12-11 19:05:48',4);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('158.7','SAKARYA','2020-12-11 01:24:20',4);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('158.7','SAKARYA','2020-12-12 20:59:12',4);
INSERT INTO "GuvenlikGunlugu"
("ip","yer","tarih","hesapNo")
VALUES
('158.7','SAKARYA','2020-12-13 07:41:50',4);
INSERT INTO "Profil"
("hesapNo","isim","bio","url","twitterkullaniciAdi","sirket","geneleposta")
VALUES
(1,'Emre','Merhaba ben Emre Bilgisayar
Mühendisiyim','https://www.youtube.com/?hl=tr&gl=TR','emre54','Google','emre_black@hotmail.com');
INSERT INTO "Profil"
("hesapNo","isim","bio","url","twitterkullaniciAdi","sirket","geneleposta")
VALUES
(2,'Mete','Merhaba ben Mete Elektronik
Mühendisiyim','https://www.youtube.com/?hl=tr&gl=TR','mete01','SpaceX','mete_red@hotmail.com');
INSERT INTO "Profil"
("hesapNo","twitterkullaniciAdi")
VALUES
(3,'ali6517');
INSERT INTO "Profil"
("hesapNo","isim","bio","sirket","geneleposta")
VALUES
(7,'Mehmet','Merhaba ben Mehmet Yazılım Mühendisiyim','CD Projekt','mehmet_blue@hotmail.com');
INSERT INTO "Depo"
("depoAdi","songuncellemeTarihi","yazilimDili","forkSayi","yildizSayi")
VALUES
('kod', '2020-12-01 12:15:49','c++','2','2');
INSERT INTO "Depo"
("depoAdi","songuncellemeTarihi","yazilimDili","forkSayi","yildizSayi")
VALUES
('uygulama', '2020-12-01 15:39:06','c#','0','1');
INSERT INTO "Depo"
("depoAdi","songuncellemeTarihi","yazilimDili","forkSayi","yildizSayi")
VALUES
('önemli', '2020-12-04 22:08:29','java','1','1');
INSERT INTO "Depo" 
("depoAdi","songuncellemeTarihi","yazilimDili","yildizSayi")
VALUES
('kod', '2020-12-05 01:42:30','c++','1');
INSERT INTO "Depo"
("depoAdi","songuncellemeTarihi","yazilimDili","forkSayi","yildizSayi")
VALUES
('uygulama', '2020-12-09 18:27:06','python','1','2');
INSERT INTO "Depo"
("depoAdi","songuncellemeTarihi","yazilimDili","forkSayi","yildizSayi")
VALUES
('oyunlarım', '2020-12-10 02:39:14','c#','0','0');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(1,5,'2020-11-03 07:09:40');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(4,2,'2020-11-30 15:15:42');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(1,6,'2020-12-11 19:05:48');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(3,1,'2020-12-25 23:14:20');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(2,3,'2020-12-01 12:15:49');
INSERT INTO "DepoOlustur"
("hesapNo","depoNo","olusturmaTarihi")
VALUES
(7,4,'2020-12-06 00:39:04');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.5,3,'2020-12-04 09:15:34');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.7,3,'2020-12-05 16:22:57');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.8,3,'2020-12-26 09:50:13');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(1.2,3,'2020-12-29 11:36:28');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.1,1,'2020-11-05 18:08:39');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.3,1,'2020-11-17 23:59:01');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.5,1,'2020-12-01 00:45:30');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.5,6,'2020-12-07 03:10:55');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(1.2,6,'2020-12-29 09:46:29');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.5,4,'2020-10-18 14:00:33');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.7,4,'2020-11-03 07:09:40');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.9,4,'2020-11-30 15:15:42');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(0.9,2,'2020-12-11 19:05:48');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(1.2,5,'2020-12-25 23:14:20');
INSERT INTO "VersiyonOlustur"
("versiyon","depoNo","olusturmaTarihi")
VALUES
(1.4,5,'2021-01-26 04:17:00');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(1,3,0.7,'2020-11-03 07:09:40');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(1,4,0.9,'2020-11-04 07:52:10');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(2,6,1.2,'2020-12-26 09:50:13');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(2,5,1.4,'2020-12-07 03:10:55');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(2,3,0.8,'2020-12-11 19:05:48');
INSERT INTO "VersiyonUlas"
("hesapNo","depoNo",versiyon,"ulasimTarihi")
VALUES
(5,1,0.3,'2021-01-26 04:17:00');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(1,5,'2020-12-26 09:50:13');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(1,6,'2020-11-05 18:08:39');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(2,1,'2020-12-07 03:10:55');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(2,3,'2020-12-04 09:15:34');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(2,6,'2020-10-18 14:00:33');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(4,2,'2020-11-03 07:09:40');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(4,3,'2020-12-25 23:14:20');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(6,6,'2021-01-26 04:17:00');
INSERT INTO "Yildiz"
("hesapNo","depoNo","yildizTarihi")
VALUES
(6,5,'2020-10-18 14:00:33');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(1,5,'2020-12-01 00:45:30');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(1,6,'2020-12-07 03:10:55');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(2,3,'2020-12-29 09:46:29');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(3,3,'2020-10-18 14:00:33');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(4,5,'2020-11-03 07:09:40');
INSERT INTO "Fork"
("hesapNo","depoNo","kopyalanmaTarihi")
VALUES
(6,6,'2020-11-30 15:15:42');
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('ihtiyaçlar','2020-12-01 00:45:30',1,2);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('kodlar','2020-12-07 03:10:55',1,2);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('fotoğraflar','2020-12-29 09:46:29',3,5);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('ers1','2020-10-18 14:00:33',3,5);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('sff3','2020-11-03 07:09:40',7,1);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('kodlar','2020-11-30 15:15:42',7,1);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('ihtiyaçlar','2020-12-11 19:05:48',7,1);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('önemli','2020-12-25 23:14:20',7,1);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('resim','2021-01-26 04:17:00',4,3);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('rapor','2020-12-04 09:15:34',4,3);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('ödev','2020-12-05 16:22:57',4,3);
INSERT INTO "Klasor"
("klasorismi","eklenmeTarihi","hesapNo","depoNo")
VALUES
('görev','2020-12-26 09:50:13',2,6);