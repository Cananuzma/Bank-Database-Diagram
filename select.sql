

/* 2.Tüm hesap türlerinde hesabu olan bütün müþterilerin TC kimlik numaralarýn ve son eksrterline ait borç tutarý
 X isimli hesap türünüe baðlý kredi kartý sayýlarý
 */
SELECT BM.TCNo, HT.HesapTurAd, COUNT(K.ID) AS KrediKartiSayisi, SUM(E.ToplamBorc) AS ToplamBorç
FROM Musteri AS M
INNER JOIN BireyselMusteri AS BM ON BM.MusteriID = M.ID
INNER JOIN Hesap AS H ON H.MusteriID = M.ID
INNER JOIN HesapTuru HT ON HT.ID = H.HesapTuruID
LEFT JOIN Kart AS K ON K.HesapID = H.ID AND K.KartTuru = 'Kredi'
LEFT JOIN Ekstre AS E ON E.KartID = K.ID
WHERE M.ID IN (
    SELECT M.ID FROM Musteri AS M
    INNER JOIN BireyselMusteri AS BM ON BM.MusteriID = M.ID
    INNER JOIN Hesap AS H ON H.MusteriID = M.ID
    INNER JOIN HesapTuru HT ON HT.ID = H.HesapTuruID
    GROUP BY M.ID
    HAVING COUNT(M.ID) = (SELECT COUNT(*) FROM HesapTuru)
)
GROUP BY BM.TCNo, HT.HesapTurAd



-------------------------------------------------------------------------------------------------------------------------
/*Yalova ilindeki hesaplada geçen yýlki  tüm EFT çýkýþ iþlemlerinin toplam aylýk ortalama tutarý dikkate alýnarak bu yýlýn
ilk 3 ayýnda o rakamandan daha yüksek EFT iþlemi gerçekleþtirilmiþ olan þubelerin ismi hangi ay olduðu ve EFT iþlemi Tutarýný
getiren sorguyu yazýnýz.Sýrlama tutar >1000 ise  þube ismine göre z-a deðilse a-z */
SELECT SubeAD,MONTH(IslemTarihi) AS Ay,Islem.Tutar FROM Sube 
            INNER JOIN Hesap ON HESAP.SubeID = Sube.ID
            INNER JOIN Islem ON Islem.HesapID = Hesap.ID 
            WHERE  YEAR(IslemTarihi) = YEAR(GETDATE()) AND MONTH(IslemTarihi) <= 3
            GROUP BY  IslemTarihi ,SubeAD  , Islem.Tutar
            HAVING Islem.Tutar > (SELECT SUM(Islem.Tutar)/12 FROM Hesap as H
                                  INNER JOIN Sube AS S ON H.SubeID = S.ID 
                                  LEFT JOIN Adres AS A ON A.ID = H.ID
                                  LEFT JOIN Il AS I ON I.ID = A.IlID
                                  LEFT JOIN Islem ON Islem.HesapID = H.ID
         WHERE I.ID = 1 AND Islem.HareketTipi = 1 AND IslemTuruID = 1 AND  YEAR(IslemTarihi) = YEAR(GETDATE()) - 1) 
         ORDER BY CASE 
           WHEN (SELECT SUM(Islem.Tutar)/12 FROM Hesap as H
                                  INNER JOIN Sube AS S ON H.SubeID = S.ID 
                                  LEFT JOIN Adres AS A ON A.ID = H.ID
                                  LEFT JOIN Il AS I ON I.ID = A.IlID
                                  LEFT JOIN Islem ON Islem.HesapID = H.ID
         WHERE I.ID = 1 AND Islem.HareketTipi = 1 AND IslemTuruID = 1 AND  YEAR(IslemTarihi) = YEAR(GETDATE()) - 1) > 1000 THEN SubeAD END DESC,
           SubeAD ASC 



