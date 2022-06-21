# Adatbázisok projekt

## Az adatbázis

A mi adatbázisunk egy börtön adatbázis architektúráját igyekszi szimulálni.

Az adatbázisban kilenc tábla található.

Börtönkomplexusok, cellák, alkalmazottak, beosztások, börtönrabok, fegyver raktár és bűncselekmények. Ezekről tárol adatokat a mi adatbázisunk. 

(És van két tábla, amit triggerek hatására használ az adatbázis loggolás szempontból)

![DB Diagram.png](https://i.postimg.cc/ZqP0sV6z/DB-Diagram.png)

## Tárolt eljárások

A projektünk öt tárolt eljárást tartalmaz, amelyek közül vannak egyszerűbbek és egészen összetettek is:

- **Személyzet felvétele**
    
    Ez a tárolt eljárás három paramétert fogad be
    
    - a felvenni kívánt alkalmazott neve
    - az épület azonosító száma
    - a szerep, amibe felvenni kívánjuk
    
    Az eljárás először is kikeresi a beosztás ID-ját a megadott neve szerint, ha nem talál ID-t a név alapján, akkor a hibakezelő kiír egy ennek megfelelő üzenetet. Ezután a ***STAFF*** táblába kerül a felvenni kívánt alkalmazott.
    
    Miután ez megtörtént, az eljárás visszajelez, hogy sikeresen megtörtént az adatbevitel az alábbi módon:
    
    ```sql
    BEGIN
        addStaff('Istenes Mátyás', 4, 'Guard');
    end;
    ```
    
    ```markdown
    C##INFO3> BEGIN
                  addStaff('Istenes Mátyás', 4, 'Guard');
              end;
    [2022-06-21 19:37:17] completed in 119 ms
    Istenes Mátyás assigned to BARANYA MEGYEI BÜNTETÉS-VÉGREHAJTÁSI INTÉZET as Guard
    ```
    
- **Fegyver kiosztás**
    
    Ezzel a tárolt eljárással fel tudjuk fegyverezni a börtön őreit, ami majd a börtönrab felvételnél lesz hasznos.
    
    Az eljárás paraméterei:
    
    - az őr neve, akinek fegyvert szeretnénk adni
    - a fegyver “halálossági szintje”
    
    Az eljárás a megadott név alapján kikeresi az illetőről, hogy őr-e vagy sem, ha nem őr, akkor feldob egy ennek megfelelő hibaüzenetet, majd “halálossági szinttől” függően keres egy az őrnek megfelelő fegyvert. Ha sikerült az eljárásnak találnia egy megfelelő fegyvert, akkor hozzárendeli annak az ID-ját az őrhöz, majd a fegyver raktárból kivon egyet a fegyver darabszámából.
    
    Az eljárás kezeli azon eseteket, ahol 
    
    - nem őrt adtunk meg
    - nem megfelelő “halálossági szintet” adtunk meg
    - olyan nevet adtunk meg, ami nem szerepel az adatbázisban
    - ha nincs a raktárban elegendő fegyver
    
    ```sql
    BEGIN
        assignWeaponSingle('Ferencz Szilárd', 3);
    end;
    
    -- Példa helytelen értékekre:
    BEGIN
        assignWeaponSingle('Pityi Palkó', 3);
    end;
    ```
    
    ```markdown
    C##INFO3> BEGIN
                  assignWeaponSingle('Pityi Palkó', 3);
              end;
    [2022-06-21 19:47:29] completed in 134 ms
    The guard doesnt exist
    ```
    
- **Személyzeti tag elbocsájtása**
    
    Ezzel az eljárással személyzeti tagokat tudunk elbocsájtani (igazgatói posztban levő embert nem tudunk elbocsájtani és olyat sem, aki már be van osztva egy rabhoz).
    
    Az eljárás paramétereként megadjuk az elbocsájtani kívánt személy nevét.
    
    Kezdetben megnézi az eljárás, hogy mi a beosztása az elbocsájtani kívánt személynek. Ha nem igazgató és nem őr, akkor szimplán töröljük a sorát az adatbázisból.
    
    Hogyha a személy beosztása őr, akkor eltávolítjuk a fegyverét (ergó megnöveljünk annak a fegyvernek a darabszámát, amit ő viselt) és utána eltávolítjuk az adatbázisból.
    
    ```sql
    BEGIN
        fireStaff('Závada Péter');
    end;
    /
    
    -- Példa helytelen értékre:
    
    BEGIN
        fireStaff('Becze Balázs');
    end;
    /
    ```
    
    ```markdown
    C##INFO3> BEGIN
    		    fireStaff('Becze Balázs');
       		  end;
    		  /
    [2022-06-21 19:47:29] completed in 134 ms
    You cant fire an active guard
    ```
    
- **Börtönrab felvétele**
    
    Ez a projekt legkomplexebb eljárása *(közel kétszáz soros),* aminek segítségével a rabok automatikusan bekerülnek a megfelelő adatokkal az adatbázisba.
    
    Az eljárás paraméterei:
    
    - a rab neve
    - az általa elkövetett bűncselekmény
    - bezárásának időpontja (ÉÉÉÉ-HH-NN formátumban)
    
    Az eljárás először a bűncselekmény alapján kikeresi a “súlyossági fokát”.
    
    Példa súlyossági fokokra:
    
    | SEVERITY | DESCRIPTION |
    | --- | --- |
    | 1 | Robbery |
    | 2 | Kidnapping |
    | 3 | Murder |
    
    Ezt követően a súlyossági foktól függően az eljárás keres egy a rabnak megfelelő őrt. 
    
    Ez a *pickGuard* függvény segítségével történik, ami visszatéríti az első megfelelő rabnak megfelelő őr azonosítóját. 
    
    A kiválasztás úgy történik, hogy először is az őr szabad kell hogy legyen (nincs beosztva sehova még), és a rab által elkövetett bűncselekmény “súlyossági fokához” megfelelő “halálossági szintű” fegyverrel kell rendelkezzen.
    
    Pl. ha valaki rablást követett el (severity 1), akkor olyan őr kerülhet hozzá, akinek gumibotja van (lethality level 1), viszont ha valaki gyilkosságot követett el (severity 3), akkor olyan őr kerülhet csak hozzá, akinek gépkarabélya van (lethality level 3). 
    
    Miután az eljárás talált a rabnak egy megfelelő őrt, keres neki egy megfelelő cellát is a *pickCell* függvény segítségével.
    
    Ez hasonlóan működik az őr kiválasztáshoz:
    
    Minden börtönben található A, B és C és minél súlyosabb az elkövetett bűncselekmény, annál “szigorúbb” cellába lesz a rab besorolva
    
    > A - legkevésbé szigorúbb; C - legszigorúbb
    > 
    
    Miután cella és őr is került a rabhoz, az eljárás kiszámolja a szabadulásának idejét:
    
    Bűn súlyosságától függően hozzá ad egy megadott évet a bezárás időpontjához.
    
    1. Két évet
    2. Öt évet
    3. Tizenkét évet
    
    Ezek alapján az adatok alapján a rab be lesz vezetve az adatbázisba.
    
    Miután ez megtörtént, az adatbázis visszajelez nekünk, hogy sikeresen lefutott az eljárás és a beszúrás is helyes.
    
    ```sql
    BEGIN
        incarcerate('Kiss Antal', 'Kidnapping', '2022-06-21');
    end;
    /
    ```
    
    ```
    C##INFO3> BEGIN
                  incarcerate('Kiss Antal', 'Kidnapping', '2022-06-21');
              end;
    [2022-06-21 20:09:19] completed in 140 ms
    -----------------------------------------------------
    Kiss Antal incarcerated for Kidnapping
    In cell: 4
    Guarded by: #19
    Time of lockdown: 2022-06-21
    Time of release: 2027-06-20
    -----------------------------------------------------
    ```
    
- **Szabadlábra helyezés**
    
    Az eljárás segítségével szabadlábra helyezhetjük a megadott rabot.
    
    Az eljárás paraméterei:
    
    - a rab neve
    - a “mai dátum”
    
    Az eljárás a név alapján kikeresi a rab azonosítóját, szabadulási idejét és cellájának azonosítóját.
    
    Összehasonlítja a “mai dátumot” a pontos szabadulási idejével és kiértékeli, hogy letöltötte a börtönbüntetését a rab, vagy sem.
    
    Ha letöltötte a börtönbüntetését, akkor a cella azonosító alapján megnöveli egyel a cella kapacitását az eljárás, majd eltávolítja a táblából a rabot.
    
    ```sql
    BEGIN
        releasePrisoner('Gyorgy Andras', '2050-06-19');
    end;
    /
    ```
    

## Triggerek

- **Szabadlábra helyezett rab**
    
    Ez a trigger törlés (szabadlábra helyezés) után elhelyezi egy *PRISONER_LOG* nevű táblában a rab nevét és hogy hány évet töltött el.
    
    ```sql
    BEGIN
        releasePrisoner('Kiss Antal', '2050-06-19');
    end;
    /
    ```
    
    > *PRISONER_LOG*
    > 
    
    | ID | NAME | TIME_SERVED |
    | --- | --- | --- |
    | 4 | Kiss Antal | 5 |
- **Elbocsájtott személyzeti tag**
    
    Ez a trigger, hasonlóan adatokat tárol el egy elbocsájtott személyzeti tagról. Törlés után egy *STAFF_LOG* nevű táblába helyezi a személyzeti tag nevét, beosztását és elbocsájtásának időpontját.
    
    ```sql
    BEGIN
        releasePrisoner('Kiss Antal', '2050-06-19');
    end;
    /
    ```
    
    > *STAFF_LOG*
    > 
    
    | ID | NAME | ROLE | TIME_OF_FIRING |
    | --- | --- | --- | --- |
    | 3 | Katók Ferenc | Guard | 2022-06-21 |

---

*Készítette: Seres Tamás, Bálint Zsolt*
