CREATE OR REPLACE FUNCTION kacbardakyapar(sayilitre REAL)
RETURNS REAL
AS
$$
BEGIN
    RETURN sayilitre/0.2;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insanAra(insanNo INT)
RETURNS TABLE(numara INT, adi VARCHAR(20), soyadi VARCHAR(20),yasi VARCHAR(3),boyu VARCHAR(8),kilosu VARCHAR(8)) 
AS 
$$
BEGIN
    RETURN QUERY SELECT "kisiNo", "ad" , "soyad" , "yas" , "boy" , "kilo" FROM "Insan"
                 WHERE "kisiNo" = insanNo;
END;
$$
LANGUAGE "plpgsql";



CREATE OR REPLACE FUNCTION yemek_enlerin_sayisi( OUT en_az_hata SMALLINT,
OUT en_cok_hata SMALLINT,
OUT en_az_dogru SMALLINT,
OUT en_cok_dogru SMALLINT)
AS $$
begin  
  select min("sagliksizbeslenmeSayisi"),
         max("sagliksizbeslenmeSayisi"),
         min("sagliklibeslenmeSayisi"),
         max("sagliklibeslenmeSayisi")
  into en_az_hata, en_cok_hata,en_az_dogru,en_cok_dogru
  from "Yemek";
END
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION toplam_ders_saati_hesapla(numara INTEGER)
RETURNS REAL
LANGUAGE "plpgsql"
AS
$$
DECLARE
    saat NUMERIC;
BEGIN
    saat := (SELECT SUM("kacsaatCalistin") FROM "Ders" WHERE "ogrenciNo" = numara); 
    RETURN  saat;
END
$$;


CREATE OR REPLACE FUNCTION vucut_kitle_indexi(kilo REAL,boy real)
RETURNS REAL
AS
$$
BEGIN
    RETURN kilo/(boy*boy);
END;
$$
LANGUAGE plpgsql;



--SELECT * FROM kacbardakyapar(1.8);

--SELECT * FROM insanAra(8);

--SELECT * FROM yemek_enlerin_sayisi();

--SELECT toplam_ders_saati_hesapla(4);

--SELECT * FROM vucut_kitle_indexi(59,1.65);




CREATE TABLE "silinenIs" (
 "silinmetarihi" TIMESTAMP,
 "isNo" INTEGER,
 "kayittarihi" TIMESTAMP,
 "kacsaatCalistin" VARCHAR(2) DEFAULT '-',
 "neYaptin" TEXT DEFAULT '-',
 "verimlicalisdigingunSayisi" VARCHAR(8) DEFAULT '-',
 "verimlicalismadigingunSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 CONSTRAINT "issilinenPK" PRIMARY KEY("isNo")
);


CREATE OR REPLACE FUNCTION "IsSilinen"()
RETURNS TRIGGER 
AS
$$
BEGIN
        INSERT INTO "silinenIs"
        ("silinmetarihi","isNo","kayittarihi","kacsaatCalistin", "neYaptin","verimlicalisdigingunSayisi",
        "verimlicalismadigingunSayisi","mesleksahibiNo")
        VALUES(CURRENT_TIMESTAMP::TIMESTAMP,OLD."isNo",OLD."tarih", OLD."kacsaatCalistin", OLD."neYaptin",
        OLD."verimlicalisdigingunSayisi",OLD."verimlicalismadigingunSayisi",OLD."mesleksahibiNo");
        RETURN NEW;
END;
$$
LANGUAGE "plpgsql";


CREATE TRIGGER "Istablosumdankayitsilindiginde"
AFTER DELETE ON "Is"
FOR EACH ROW
EXECUTE PROCEDURE "IsSilinen"();






CREATE TABLE "eklenenInsan" (
 "kisiNo" SERIAL,
 "eklenmeTarihi" TIMESTAMP,
 CONSTRAINT "ekleneninsanPK" PRIMARY KEY("kisiNo")
);


CREATE OR REPLACE FUNCTION "InsanEklenen"()
RETURNS TRIGGER 
AS
$$
BEGIN
        INSERT INTO "eklenenInsan"
        ("kisiNo","eklenmeTarihi")
        VALUES(NEW."kisiNo",CURRENT_TIMESTAMP::TIMESTAMP);
        RETURN NEW;
END;
$$
LANGUAGE "plpgsql";


CREATE TRIGGER "Insantablosunakayiteklendiginde"
AFTER INSERT ON "Insan"
FOR EACH ROW
EXECUTE PROCEDURE "InsanEklenen"();




CREATE TABLE "silinenHobi" (
"silinmeTarihi" TIMESTAMP,
 "hobiNo" INTEGER,
 "kayitTarih" TIMESTAMP,
 "hobiAdi" VARCHAR(25) DEFAULT '-',
 "kacsaatYaptin" VARCHAR(8) DEFAULT '-',
 "toplamyaptiginhobiSayisi" VARCHAR(8) DEFAULT '-',
 "mesleksahibiNo" INTEGER DEFAULT NULL,
 "ogrenciNo" INTEGER DEFAULT NULL,
 CONSTRAINT "silinenhobiPK" PRIMARY KEY("hobiNo")
);


CREATE OR REPLACE FUNCTION "HobiSilinen"()
RETURNS TRIGGER 
AS
$$
BEGIN
        INSERT INTO "silinenHobi"
        ("silinmeTarihi","hobiNo","kayitTarih", "hobiAdi","kacsaatYaptin",
        "toplamyaptiginhobiSayisi","mesleksahibiNo","ogrenciNo")
        VALUES(CURRENT_TIMESTAMP::TIMESTAMP,OLD."hobiNo",OLD."tarih", OLD."hobiAdi", OLD."kacsaatYaptin",
        OLD."toplamyaptiginhobiSayisi",OLD."mesleksahibiNo",OLD."ogrenciNo");
        RETURN NEW;
END;
$$
LANGUAGE "plpgsql";


CREATE TRIGGER "hobitablosundankayitsilindiginde"
AFTER DELETE ON "Hobi"
FOR EACH ROW
EXECUTE PROCEDURE "HobiSilinen"();






CREATE TABLE "eklenenOdev" (
 "ogrenciNo" INTEGER,
 "dersNo" INTEGER,
 "eklenmeTarihi" TIMESTAMP
);


CREATE OR REPLACE FUNCTION "OdevEklenen"()
RETURNS TRIGGER 
AS
$$
BEGIN
        INSERT INTO "eklenenOdev"
        ("ogrenciNo","dersNo","eklenmeTarihi")
        VALUES(NEW."ogrenciNo",NEW."dersNo",CURRENT_TIMESTAMP::TIMESTAMP);
        RETURN NEW;
END;
$$
LANGUAGE "plpgsql";

CREATE TRIGGER "Odevtablosunakayiteklendiginde"
AFTER INSERT ON "Odev"
FOR EACH ROW
EXECUTE PROCEDURE "OdevEklenen"();

