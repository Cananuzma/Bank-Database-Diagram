CREATE TABLE Ulke(
ID INT NOT NULL PRIMARY KEY,
UlkeAdi varchar(20) NOT NULL
)

CREATE TABLE Il(
ID INT NOT NULL PRIMARY KEY,
IlAd varchar(20) NOT NULL,

UlkeID INT NOT NULL FOREIGN KEY REFERENCES Ulke(ID)
)

CREATE TABLE Ilce(
ID INT NOT NULL PRIMARY KEY,
IlceAd varchar(20) NOT NULL,

IlID INT NOT NULL FOREIGN KEY REFERENCES Il(ID)
)

CREATE TABLE Mahalle(
ID INT NOT NULL PRIMARY KEY,
MahalleAd varchar(20) NOT NULL,

 IlceID INT NOT NULL FOREIGN KEY REFERENCES Ilce(ID)
)

CREATE TABLE Sokak(
ID INT NOT NULL PRIMARY KEY,
SokakAd varchar(20) NOT NULL,

MahalleID INT NOT NULL FOREIGN KEY REFERENCES Mahalle(ID)
)


CREATE TABLE Adres(
 ID INT PRIMARY KEY IDENTITY(1,1),
 IckapiNo VARCHAR(3) NOT NULL,
 DisKapiNo VARCHAR(3) NOT NULL,
 Aciklama TEXT,
 
 UlkeID INT NOT NULL FOREIGN KEY REFERENCES Ulke(ID),
 IlID INT NOT NULL FOREIGN KEY REFERENCES Il(ID),
 IlceID INT NOT NULL FOREIGN KEY REFERENCES Ilce(ID),
 MahalleID INT NOT NULL FOREIGN KEY REFERENCES Mahalle(ID),
 SokakID INT NOT NULL FOREIGN KEY REFERENCES Sokak(ID),
) 

CREATE TABLE Banka(
 ID INT PRIMARY KEY IDENTITY(1,1),
 Banka_Ad VARCHAR(20) NOT NULL,
 WebSite VARCHAR(20) NOT NULL,
 TelNo  VARCHAR(10) NOT NULL,
 KurulusTarih DATE
)


CREATE TABLE Sube(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   SubeAD VARCHAR(20) NOT NULL,
   TelNo VARCHAR(20)  NOT NULL,

   BankaID INT NOT NULL FOREIGN KEY REFERENCES Banka(ID),
   AdresID INT NOT NULL FOREIGN KEY REFERENCES Adres(ID)
)



CREATE TABLE Doviz(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   DovizTutar MONEY NOT NULL,
   DovizCinsi  VARCHAR(10) NOT NULL,
   TlTutar MONEY NOT NULL
)

CREATE TABLE HesapTuru(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   HesapTurAd VARCHAR(10) NOT NULL,

)


CREATE TABLE  Musteri(

ID INT  IDENTITY(1,1) PRIMARY KEY,
TelNo VARCHAR(20) NOT NULL,
EMail VARCHAR(50) NOT NULL,
MusteriNo INT NOT NULL,
Verg_No INT NOT NULL
)

CREATE TABLE KurumsalMusteri(
ID INT IDENTITY(1,1) PRIMARY KEY,
KurulusTarih DATE NOT NULL,
FirmaAd VARCHAR(30) NOT NULL,
MusteriID INT NOT NULL FOREIGN KEY REFERENCES Musteri(ID)
)


CREATE TABLE BireyselMusteri(
ID INT IDENTITY(1,1) PRIMARY KEY,
TCNo VARCHAR(11) UNIQUE NOT NULL,
Ad VARCHAR(20) NOT NULL,
SoyAd VARCHAR(20) NOT NULL,
Cinsiyet BIT NOT NULL,
DogumTarihi DATE NOT NULL,
Yas AS DATEDIFF(YEAR,GETDATE(),DogumTarihi) ,
MusteriID INT NOT NULL FOREIGN KEY REFERENCES Musteri(ID)
)


CREATE TABLE Hesap(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   IbanNo VARCHAR(26) UNIQUE NOT NULL,
   Bakiye MONEY NOT NULL,
   AcilisTarih DATE NOT NULL,
   KapanisTarih DATE ,

   DovizID INT NOT NULL FOREIGN KEY REFERENCES Doviz(ID),
   HesapTuruID INT NOT NULL FOREIGN KEY REFERENCES HesapTuru(ID),
   MusteriID INT NOT NULL FOREIGN KEY REFERENCES Musteri(ID),
   SubeID INT NOT NULL FOREIGN KEY REFERENCES Sube(ID),
)


CREATE TABLE IslemTuru(
    ID  INT PRIMARY KEY  IDENTITY(1,1),
    Ad  VARCHAR(20) NOT NULL
)


CREATE TABLE Islem(
    ID INT PRIMARY KEY  IDENTITY(1,1),
    HareketTipi SMALLINT NOT NULL,
    IslemTarihi DATETIME NOT NULL,
    AliciIban VARCHAR(26) NOT NULL,
    Tutar MONEY NOT NULL,
    Aciklama VARCHAR(50),

    HesapID INT NOT NULL FOREIGN KEY REFERENCES Hesap(ID),
    IslemTuru INT NOT NULL FOREIGN KEY REFERENCES IslemTuru(ID)
)


CREATE TABLE Kart(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   KartNO VARCHAR(20) NOT NULL,
   KartTuru VARCHAR(20) NOT NULL,
   KartSifre CHAR(4) NOT NULL,
   HesapKesimTarih DATE NOT NULL,
   Limit MONEY ,
   LimitSuresi DATETIME NOT NULL,
   Aktiflik BIT NOT NULL,
   SonKullanmaTarih DATE NOT NULL,
   Bakiye MONEY NOT NULL,
   Puan INT   DEFAULT 0,
   FaizOrani DECIMAL(5,2),
   CVVNo CHAR(3) NOT NULL,

   MusteriID INT FOREIGN KEY REFERENCES Musteri(ID),
   HesapID INT FOREIGN KEY REFERENCES Hesap(ID)
)


CREATE TABLE Ekstre(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   ToplamBorc MONEY NOT NULL,
   AsgariBorc MONEY NOT NULL,
   OdenmesiGerekenTarih DATE NOT NULL,
   OdenenTarih DATE,

   KartID INT NOT NULL FOREIGN KEY REFERENCES Kart(ID)
)


CREATE TABLE HareketTuru(

   ID INT PRIMARY KEY  IDENTITY(1,1),
   Ad VARCHAR(20) NOT NULL,
)



CREATE TABLE EksrteHareketi(
   ID INT PRIMARY KEY  IDENTITY(1,1),
   IslemTarihi DATETIME NOT NULL,
   Tutar MONEY NOT NULL,
   HareketTuru VARCHAR(20) NOT NULL,
   FirmaAdi VARCHAR(50) NOT NULL,

   EkstreID INT NOT NULL FOREIGN KEY REFERENCES Ekstre(ID),
   HareketTuruID INT  NOT NULL FOREIGN KEY REFERENCES HareketTuru(ID),
   EksrteHareketiID INT FOREIGN KEY REFERENCES EksrteHareketi(ID)
   )



