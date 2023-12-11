CREATE TABLE "Insan" (
 "kisiNo" SERIAL,
 "ad" VARCHAR(20) DEFAULT '-',
 "soyad" VARCHAR(20) DEFAULT '-',
 "yas" VARCHAR(3) DEFAULT '-',
 "boy" VARCHAR(8) DEFAULT '-',
 "kilo" VARCHAR(8) DEFAULT '-',
 "kisiTipi" CHAR(1) NOT NULL,
 CONSTRAINT "insanPK" PRIMARY KEY("kisiNo")
);

CREATE TABLE "Ogrenci" (
"kisiNo" INTEGER NOT NULL,
"egitimLevel" VARCHAR(15)  NOT NULL,
CONSTRAINT "ogrenciPK" PRIMARY KEY ("kisiNo")
);
ALTER TABLE "Ogrenci"
ADD CONSTRAINT "InsanOgrenci" FOREIGN KEY ("kisiNo")
REFERENCES "Insan" ("kisiNo")
ON DELETE CASCADE
ON UPDATE CASCADE;

CREATE TABLE "MeslekSahibi" (
"kisiNo" INTEGER NOT NULL,
"meslek" VARCHAR(50)  NOT NULL,
CONSTRAINT "mesleksahibiPK" PRIMARY KEY ("kisiNo")
);
ALTER TABLE "MeslekSahibi"
ADD CONSTRAINT "InsanMeslekSahibi" FOREIGN KEY ("kisiNo")
REFERENCES "Insan" ("kisiNo")
ON DELETE CASCADE
ON UPDATE CASCADE;



CREATE TABLE "Ders" (
 "dersNo" SERIAL,
 "tarih" TIMESTAMP,
 "dersAdi" VARCHAR(25) DEFAULT '-',
 "kacsaatCalistin" REAL DEFAULT '0',
 "neYaptin" TEXT DEFAULT '-',
 "calitigingunSayisi" VARCHAR(8) DEFAULT '-',
 "calismadigingunSayisi" VARCHAR(8) DEFAULT '-',
 "ogrenciNo" INTEGER NOT NULL,
 CONSTRAINT "dersPK" PRIMARY KEY("dersNo"),
 CONSTRAINT "dersFK" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo") 
);

CREATE TABLE "Odev"(
 "odevNo" SERIAL,
 "tarih" TIMESTAMP,
 "odevTuru" VARCHAR(15) DEFAULT '-',
 "konusu" VARCHAR(100) DEFAULT '-',
 "yapabildinmi" VARCHAR(5) DEFAULT '-',
 "yaptiginodevSayisi" VARCHAR(8) DEFAULT '-',
 "yapmadiginodevSayisi" VARCHAR(8) DEFAULT '-',
 "eksikbiraktiginodevSayisi" VARCHAR(8) DEFAULT '-',
 "yapamadiginodevSayisi" VARCHAR(8) DEFAULT '-',
 "ogrenciNo" INTEGER NOT NULL,
 "dersNo" INTEGER NOT NULL,
 CONSTRAINT "odevPK" PRIMARY KEY("odevNo"),
 CONSTRAINT "odevFK" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo"),
 CONSTRAINT "odevFK2" FOREIGN KEY("dersNo") REFERENCES "Ders"("dersNo")
);

CREATE TABLE "Is"(
 "isNo" SERIAL,
 "tarih" TIMESTAMP,
 "kacsaatCalistin" VARCHAR(2) DEFAULT '-',
 "neYaptin" TEXT DEFAULT '-',
 "verimlicalisdigingunSayisi" VARCHAR(8) DEFAULT '-',
 "verimlicalismadigingunSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 CONSTRAINT "isPK" PRIMARY KEY("isNo"),
 CONSTRAINT "evFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo")
);

CREATE TABLE "Su"(
 "suNo" SERIAL,
 "tarih" TIMESTAMP,
 "nekadaricmelisin" REAL DEFAULT '0',
 "nekadarictin" REAL DEFAULT '0',
 "sudisindaneictin" VARCHAR(50) DEFAULT '-',
 "yaptiginYanlislar" TEXT DEFAULT '-',
 "yaptiginDogrular" TEXT DEFAULT '-',
 "yeterincesuicdigingunSayisi" VARCHAR(8) DEFAULT '-',
 "yeterincesuicmedigingunSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "suPK" PRIMARY KEY("suNo"),
 CONSTRAINT "suFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "suFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "Yemek"(
 "yemekNo" SERIAL,
 "tarih" TIMESTAMP,
 "neYemelisin" VARCHAR(25) DEFAULT '-',
 "neYedin" VARCHAR(25) DEFAULT '-',
 "yaptiginYanlislar" TEXT DEFAULT '-',
 "yaptiginDogrular" TEXT DEFAULT '-',
 "sagliklibeslenmeSayisi" SMALLINT DEFAULT '0',
 "sagliksizbeslenmeSayisi" SMALLINT DEFAULT '0',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "yemekPK" PRIMARY KEY("yemekNo"),
 CONSTRAINT "yemekFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "yemekFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "Uyku"(
 "uykuNo" SERIAL,
 "tarih" TIMESTAMP,
 "kacsaatUyumalisin" VARCHAR(8) DEFAULT '-',
 "kacsaatUyudun" VARCHAR(8) DEFAULT '-',
 "uyanabildinmi" VARCHAR(5) DEFAULT '-',
 "yaptiginYanlislar" TEXT DEFAULT '-',
 "yaptiginDogrular" TEXT DEFAULT '-',
 "uyanmaSayisi" VARCHAR(6) DEFAULT '-',
 "uyanamamaSayisi" VARCHAR(6) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "uykuPK" PRIMARY KEY("uykuNo"),
 CONSTRAINT "uykuFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "uykuFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "Ev"(
 "evNo" SERIAL,
 "tarih" TIMESTAMP,
 "tamamladinmi" VARCHAR(5) DEFAULT '-',
 "neyieksikBiraktin" TEXT DEFAULT '-',
 "tamyapmaSayisi" VARCHAR(6) DEFAULT '-',
 "eksikbirakmaSayisi" VARCHAR(6) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "evPK" PRIMARY KEY("evNo"),
 CONSTRAINT "evFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "evFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "Spor"(
 "sporNo" SERIAL,
 "tarih" TIMESTAMP,
 "neYaptin" TEXT DEFAULT '-',
 "yeterinceyaptinmi" VARCHAR(5) DEFAULT '-',
 "tamyapmaSayisi" VARCHAR(8) DEFAULT '-',
 "eksikyapmaSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "sporPK" PRIMARY KEY("sporNo"),
 CONSTRAINT "sporFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "sporFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "SosyalMedya"(
 "sosyalmedyaNo" SERIAL,
 "tarih" TIMESTAMP,
 "sosyalmedyaAd" VARCHAR(25) DEFAULT '-',
 "kacsaatKullandin" REAL DEFAULT '0',
 "toplamSaat" REAL DEFAULT '0',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "sosyalmedyaPK" PRIMARY KEY("sosyalmedyaNo"),
 CONSTRAINT "sosyalmedyaFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "sosyalmedyaFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "BilgisayarOyunu"(
 "oyunNo" SERIAL,
 "tarih" TIMESTAMP,
 "oyunAd" VARCHAR(25) DEFAULT '-',
 "kacsaatOynadin" VARCHAR(8) DEFAULT '-',
 "toplamoyunSaat" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "bilgisayaroyunPK" PRIMARY KEY("oyunNo"),
 CONSTRAINT "bilgisayaroyunFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "bilgisayaroyunFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "SosyalAktivite"(
 "aktiviteNo" SERIAL,
 "tarih" TIMESTAMP,
 "neYaptin" TEXT DEFAULT '-',
 "kacsaatYaptin" VARCHAR(8) DEFAULT '-',
 "toplamaktiviteSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "sosyalaktivitePK" PRIMARY KEY("aktiviteNo"),
 CONSTRAINT "sosyalaktiviteFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "sosyalaktiviteFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);

CREATE TABLE "Hobi"(
 "hobiNo" SERIAL,
 "tarih" TIMESTAMP,
 "hobiAdi" VARCHAR(25) DEFAULT '-',
 "kacsaatYaptin" VARCHAR(8) DEFAULT '-',
 "toplamyaptiginhobiSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "hobiPK" PRIMARY KEY("hobiNo"),
 CONSTRAINT "hobiFK" FOREIGN KEY("mesleksahibiNo") REFERENCES "MeslekSahibi"("kisiNo"),
 CONSTRAINT "hobiFK2" FOREIGN KEY("ogrenciNo") REFERENCES "Ogrenci"("kisiNo")
);




INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Metin', 'Keskin','19','1.75cm','68','O');
INSERT INTO "Ogrenci"("kisiNo","egitimLevel")
VALUES (1,'Üniversite');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Ahmet', 'Demir','22','1.79cm','74','O');
INSERT INTO "Ogrenci"("kisiNo","egitimLevel")
VALUES (2,'Üniversite');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Hüseyin', 'Tekin','28','1.71cm','62','M');
INSERT INTO "MeslekSahibi"("kisiNo","meslek")
VALUES (3,'Elektrik Mühendisi');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Duman', 'Çakır','16','1.83cm','79','O');
INSERT INTO "Ogrenci"("kisiNo","egitimLevel")
VALUES (4,'Lise');

INSERT INTO "Insan"
("ad", "yas","boy","kilo","kisiTipi")
VALUES
('Oğuz','35','1.87cm','80','M');
INSERT INTO "MeslekSahibi"("kisiNo","meslek")
VALUES (5,'Avukat');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Yusuf', 'Canlı','41','1.69cm','65','M');
INSERT INTO "MeslekSahibi"("kisiNo","meslek")
VALUES (6,'Öğretmen');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Emir', 'Haylaz','12','1.57cm','38','O');
INSERT INTO "Ogrenci"("kisiNo","egitimLevel")
VALUES (7,'Ortaokul');

INSERT INTO "Insan"
("ad", "soyad", "yas","boy","kilo","kisiTipi")
VALUES
('Hakan', 'Uğur','36','1.72cm','63','M');
INSERT INTO "MeslekSahibi"("kisiNo","meslek")
VALUES (8,'Bilgisayar Mühendisi');


INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-12-01 00:45:30','Veri Yapıları',3,'İkili ağaçlarda arama konusunu anlamaya çalıştım','14','9',1);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-12-07 03:10:55','Veritabanı',4,'SQL komutları ile veritabanı yazmaya çalıştım',
'7','2',2);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-12-29 09:46:29','Biyoloji',5,'İlk olarak youtubedan video izledim bitki anotomisi üzerine sonra test çözdüm',
'9','1',4);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-10-18 14:00:33','Matematik',2,'Karekök ile ilgili test çözdüm','3','18',7);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-11-03 07:09:40','Fizik',6,'Kara cisim ışımasını araştırdım ve ödevimi yaptım','10','1',4);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-11-30 15:15:42','Matematik',3,'Trigonometri formüllerini ezberleyeme çalıştım ardından bu konu hakkında test çözdüm',
'11','1',4);

INSERT INTO "Ders"
("tarih", "dersAdi", "kacsaatCalistin","neYaptin","calitigingunSayisi","calismadigingunSayisi","ogrenciNo")
VALUES
('2020-12-11 19:05:48','Türkçe',1,'Yazım kurallarına biraz göz gezdirdim',
'4','18',7);


INSERT INTO "Odev"
("tarih", "odevTuru", "konusu","yapabildinmi","yaptiginodevSayisi","yapmadiginodevSayisi","eksikbiraktiginodevSayisi","yapamadiginodevSayisi","ogrenciNo","dersNo")
VALUES
('2020-12-25 23:14:20','2.ödev','İkili ağaç oluşturmam gerekiyor','evet','3','0','1','0',1,1);

INSERT INTO "Odev"
("tarih", "odevTuru", "konusu","yapabildinmi","yaptiginodevSayisi","yapmadiginodevSayisi","eksikbiraktiginodevSayisi","yapamadiginodevSayisi","ogrenciNo","dersNo")
VALUES
('2021-01-26 04:17:00','Proje','Gerçek hayat problemi ile ilgili bir veritabanı oluşturmak','evet','2','1','0','1',2,2);

INSERT INTO "Odev"
("tarih", "odevTuru", "konusu","yapabildinmi","yaptiginodevSayisi","yapmadiginodevSayisi","eksikbiraktiginodevSayisi","yapamadiginodevSayisi","ogrenciNo","dersNo")
VALUES
('2020-12-04 09:15:34','Performans','Verilen soruları çözmek','hayır','3','1','1','0',4,5);

INSERT INTO "Odev"
("tarih", "odevTuru", "konusu","yapabildinmi","yaptiginodevSayisi","yapmadiginodevSayisi","eksikbiraktiginodevSayisi","yapamadiginodevSayisi","ogrenciNo","dersNo")
VALUES
('2020-12-04 09:15:34','Performans','Verilen metinde yazım yanlışlarını bulmak','hayır','3','5','0','0',7,7);


INSERT INTO "Is"
("tarih", "kacsaatCalistin", "neYaptin","verimlicalisdigingunSayisi","verimlicalismadigingunSayisi","mesleksahibiNo")
VALUES
('2020-12-05 16:22:57','10','Elektrikli alet tasarımı üzerine çalıştım','8','0',3);

INSERT INTO "Is"
("tarih", "kacsaatCalistin", "neYaptin","verimlicalisdigingunSayisi","verimlicalismadigingunSayisi","mesleksahibiNo")
VALUES
('2020-12-26 09:50:13','8','Dava dosyası üzerine çalıştım','14','1',5);

INSERT INTO "Is"
("tarih", "kacsaatCalistin", "neYaptin","verimlicalisdigingunSayisi","verimlicalismadigingunSayisi","mesleksahibiNo")
VALUES
('2020-12-01 00:45:30','8','Çocuklarla test çözdüm','45','4',6);

INSERT INTO "Is"
("tarih", "kacsaatCalistin", "neYaptin","verimlicalisdigingunSayisi","verimlicalismadigingunSayisi","mesleksahibiNo")
VALUES
('2020-12-07 03:10:55','14','Uygulama geliştirdim','35','5',8);



INSERT INTO "Su"
("tarih", "nekadaricmelisin", "nekadarictin","sudisindaneictin","yaptiginYanlislar","yaptiginDogrular","yeterincesuicdigingunSayisi","yeterincesuicmedigingunSayisi","ogrenciNo")
VALUES
('2020-11-30 15:15:42',1.6,1,'Kola','kola içmek','14','5','2',1);

INSERT INTO "Su"
("tarih", "nekadaricmelisin", "nekadarictin","sudisindaneictin","yaptiginYanlislar","yaptiginDogrular","yeterincesuicdigingunSayisi","yeterincesuicmedigingunSayisi","ogrenciNo")
VALUES
('2020-12-25 23:14:20',2,2,'-','-','Su dışında bir şey içmedim','48','3',2);

INSERT INTO "Su"
("tarih", "nekadaricmelisin", "nekadarictin","sudisindaneictin","yaptiginYanlislar","yaptiginDogrular","yeterincesuicdigingunSayisi","yeterincesuicmedigingunSayisi","ogrenciNo")
VALUES
('2020-12-05 16:22:57',1.8,1,'Hazır meyvesuyu,2 tane çay','hazır meyvesuyu içmek','-','23','19',4);

INSERT INTO "Su"
("tarih", "nekadaricmelisin", "nekadarictin","sudisindaneictin","yaptiginYanlislar","yaptiginDogrular","yeterincesuicdigingunSayisi","yeterincesuicmedigingunSayisi","mesleksahibiNo")
VALUES
('2020-04-10 00:23:04',2,1.4,'Kahve','-','-','33','9',5);

INSERT INTO "Su"
("tarih", "nekadaricmelisin", "nekadarictin","sudisindaneictin","yaptiginYanlislar","yaptiginDogrular","yeterincesuicdigingunSayisi","yeterincesuicmedigingunSayisi","mesleksahibiNo")
VALUES
('2020-11-30 15:15:42',1.8,1.6,'Limonlu soda','-','-','26','1',8);



INSERT INTO "Yemek"
("tarih", "neYemelisin", "neYedin","yaptiginYanlislar","yaptiginDogrular","sagliklibeslenmeSayisi","sagliksizbeslenmeSayisi","ogrenciNo")
VALUES
('2020-12-29 09:46:29','Balık','Pizza','Pizza yememeliydim','Sabah omlet yedim',5,4,1);

INSERT INTO "Yemek"
("tarih", "neYemelisin", "neYedin","yaptiginYanlislar","yaptiginDogrular","sagliklibeslenmeSayisi","sagliksizbeslenmeSayisi","ogrenciNo")
VALUES
('2020-11-30 15:15:42','Peynir','Peynir','-','Bugün sağlıklı beslendim',6,0,7);

INSERT INTO "Yemek"
("tarih", "neYemelisin", "neYedin","yaptiginYanlislar","yaptiginDogrular","sagliklibeslenmeSayisi","sagliksizbeslenmeSayisi","mesleksahibiNo")
VALUES
('2020-12-11 19:05:48','-','-','Bugün sağlıksız beslendim','-',2,9,3);

INSERT INTO "Yemek"
("tarih", "neYemelisin", "neYedin","yaptiginYanlislar","yaptiginDogrular","sagliklibeslenmeSayisi","sagliksizbeslenmeSayisi","mesleksahibiNo")
VALUES
('2020-12-25 23:14:20','Meyve','Kıymalı pide','-','-',2,1,6);

INSERT INTO "Yemek"
("tarih", "neYemelisin", "neYedin","yaptiginYanlislar","yaptiginDogrular","sagliklibeslenmeSayisi","sagliksizbeslenmeSayisi","mesleksahibiNo")
VALUES
('2021-01-26 04:17:00','-','Pilav','Bugün çok yağlı yemek tükettim','-',5,5,8);



INSERT INTO "Uyku"
("tarih", "kacsaatUyumalisin", "kacsaatUyudun","uyanabildinmi","yaptiginYanlislar","yaptiginDogrular","uyanmaSayisi","uyanamamaSayisi","ogrenciNo")
VALUES
('2020-12-04 09:15:34','8','9','evet','-','Erken yattım','2','9',2);

INSERT INTO "Uyku"
("tarih", "kacsaatUyumalisin", "kacsaatUyudun","uyanabildinmi","yaptiginYanlislar","yaptiginDogrular","uyanmaSayisi","uyanamamaSayisi","ogrenciNo")
VALUES
('2020-12-05 16:22:57','7','8','hayır','Alarm kurmayı unutmuşum','-','6','6',4);

INSERT INTO "Uyku"
("tarih", "kacsaatUyumalisin", "kacsaatUyudun","uyanabildinmi","yaptiginYanlislar","yaptiginDogrular","uyanmaSayisi","uyanamamaSayisi","ogrenciNo")
VALUES
('2020-12-26 09:50:13','7','7','evet','-','Erken saatte yattım','2','15',7);

INSERT INTO "Uyku"
("tarih", "kacsaatUyumalisin", "kacsaatUyudun","uyanabildinmi","yaptiginYanlislar","yaptiginDogrular","uyanmaSayisi","uyanamamaSayisi","mesleksahibiNo")
VALUES
('2020-11-30 15:15:42','8','6','evet','-','İşimi zamanında bitirebilmek için az uyudum','5','8',8);



INSERT INTO "Ev"
("tarih", "tamamladinmi", "neyieksikBiraktin","tamyapmaSayisi","eksikbirakmaSayisi","mesleksahibiNo")
VALUES
('2020-12-29 09:46:29','evet','-','8','0',3);

INSERT INTO "Ev"
("tarih", "tamamladinmi", "neyieksikBiraktin","tamyapmaSayisi","eksikbirakmaSayisi","mesleksahibiNo")
VALUES
('2020-12-11 19:05:48','hayır','Evi süpürmedim','3','4',5);

INSERT INTO "Ev"
("tarih", "tamamladinmi", "neyieksikBiraktin","tamyapmaSayisi","eksikbirakmaSayisi","mesleksahibiNo")
VALUES
('2021-01-26 04:17:00','hayır','Bulaşıkları toparlamadım','9','2',6);

INSERT INTO "Ev"
("tarih", "tamamladinmi", "neyieksikBiraktin","tamyapmaSayisi","eksikbirakmaSayisi","mesleksahibiNo")
VALUES
('2020-12-05 16:22:57','evet','-','3','1',8);



INSERT INTO "Spor"
("tarih", "neYaptin", "yeterinceyaptinmi","tamyapmaSayisi","eksikyapmaSayisi","mesleksahibiNo")
VALUES
('2020-12-01 00:45:30','1000 metre koşu yaptım','evet','15','2',8);

INSERT INTO "Spor"
("tarih", "neYaptin", "yeterinceyaptinmi","tamyapmaSayisi","eksikyapmaSayisi","mesleksahibiNo")
VALUES
('2020-12-07 03:10:55','100 şınav çektim','hayır','6','7',5);

INSERT INTO "Spor"
("tarih", "neYaptin", "yeterinceyaptinmi","tamyapmaSayisi","eksikyapmaSayisi","ogrenciNo")
VALUES
('2020-12-29 09:46:29','-','evet','23','0',4);

INSERT INTO "Spor"
("tarih", "neYaptin", "yeterinceyaptinmi","tamyapmaSayisi","eksikyapmaSayisi","ogrenciNo")
VALUES
('2020-10-18 14:00:33','1 saat bisiklet sürdüm','hayır','21','14',7);



INSERT INTO "SosyalMedya"
("tarih", "sosyalmedyaAd", "kacsaatKullandin","toplamSaat","ogrenciNo")
VALUES
('2020-11-03 07:09:40','İnstagram','3.5','104',1);

INSERT INTO "SosyalMedya"
("tarih", "sosyalmedyaAd", "kacsaatKullandin","toplamSaat","ogrenciNo")
VALUES
('2020-11-30 15:15:42','-',2,47,2);

INSERT INTO "SosyalMedya"
("tarih", "sosyalmedyaAd", "kacsaatKullandin","toplamSaat","mesleksahibiNo")
VALUES
('2020-12-25 23:14:20','Facebook',1,26,5);

INSERT INTO "SosyalMedya"
("tarih", "sosyalmedyaAd", "kacsaatKullandin","toplamSaat","mesleksahibiNo")
VALUES
('2021-01-26 04:17:00','Twitter',0.5,29,3);



INSERT INTO "BilgisayarOyunu"
("tarih", "oyunAd", "kacsaatOynadin","toplamoyunSaat","ogrenciNo")
VALUES
('2020-12-04 09:15:34','-','4','150',2);

INSERT INTO "BilgisayarOyunu"
("tarih", "oyunAd", "kacsaatOynadin","toplamoyunSaat","ogrenciNo")
VALUES
('2020-12-05 16:22:57','Witcher 3','5','69',4);

INSERT INTO "BilgisayarOyunu"
("tarih", "oyunAd", "kacsaatOynadin","toplamoyunSaat","ogrenciNo")
VALUES
('2020-12-26 09:50:13','Witcher 3','6','75',4);


INSERT INTO "BilgisayarOyunu"
("tarih", "oyunAd", "kacsaatOynadin","toplamoyunSaat","mesleksahibiNo")
VALUES
('2020-12-07 03:10:55','cyberpunk 2077','4.5','48',6);



INSERT INTO "SosyalAktivite"
("tarih", "neYaptin", "kacsaatYaptin","toplamaktiviteSayisi","ogrenciNo")
VALUES
('2020-10-18 14:00:33','Arkadaşlarımla kafede buluştum','6','45',1);

INSERT INTO "SosyalAktivite"
("tarih", "neYaptin", "kacsaatYaptin","toplamaktiviteSayisi","mesleksahibiNo")
VALUES
('2020-11-03 07:09:40','Eşimle sinemaya gittik','3','59',3);

INSERT INTO "SosyalAktivite"
("tarih", "neYaptin", "kacsaatYaptin","toplamaktiviteSayisi","mesleksahibiNo")
VALUES
('2020-11-30 15:15:42','-','-','63',5);

INSERT INTO "SosyalAktivite"
("tarih", "neYaptin", "kacsaatYaptin","toplamaktiviteSayisi","mesleksahibiNo")
VALUES
('2020-12-11 19:05:48','Mangal yaptık','8','20',6);



INSERT INTO "Hobi"
("tarih", "hobiAdi", "kacsaatYaptin","toplamyaptiginhobiSayisi","ogrenciNo")
VALUES
('2020-12-25 23:14:20','Yapboz çözmek','2.5','98',7);

INSERT INTO "Hobi"
("tarih", "hobiAdi", "kacsaatYaptin","toplamyaptiginhobiSayisi","ogrenciNo")
VALUES
('2021-01-26 04:17:00','Yapboz çözmek','3.5','101.5',7);

INSERT INTO "Hobi"
("tarih", "hobiAdi", "kacsaatYaptin","toplamyaptiginhobiSayisi","mesleksahibiNo")
VALUES
('2020-12-04 09:15:34','Balık tutmak','5','49',8);

INSERT INTO "Hobi"
("tarih", "hobiAdi", "kacsaatYaptin","toplamyaptiginhobiSayisi","mesleksahibiNo")
VALUES
('2020-12-26 09:50:13','Yüzmek','1.5','21',3);
