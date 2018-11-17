with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure Zad2 is

    type Kolor is (Czerwony, Zielony, Niebieski);
    type DzienTygodnia is (Pn, Wt, Sr, Cz, Pt, So, Nd);
    type Liczba50 is new Integer range 1..49;
    type TablicaLiczb is array(1..6) of Liczba50;
        
    task Klient is

        entry Start;

    end Klient;

    task Serwer is 

        entry Start;
        entry Koniec;
        entry WeFloat(I: out Float);
        entry WeKolor(I: out Kolor);
        entry WeDzienTygodnia(I: out DzienTygodnia);
        entry WeTablicaLiczb(I: out TablicaLiczb);

    end Serwer;

    task body Klient is

        Liczba : Float := 0.0;
        Kolorek : Kolor := Czerwony;
        Dzien : DzienTygodnia := Nd;
        Tab : TablicaLiczb :=  (others => 1);

    begin

        accept Start;

        for K in 1..10 loop
            Serwer.WeFloat(Liczba);
            Serwer.WeKolor(Kolorek);
            Serwer.WeDzienTygodnia(Dzien);
            Serwer.WeTablicaLiczb(Tab);
            Put_Line(K'Img & " klient otrzymał: " & Liczba'Img & " " & Kolorek'Img & " " & Dzien'Img);
            for I of Tab loop
                Put(" " & I'Img);
            end loop;
            Put_Line("");
        end loop;

        Serwer.Koniec;

    end Klient;

    task body Serwer is

        package Los_Kolor is new Ada.Numerics.Discrete_Random(Kolor);
        GenKolor: Los_Kolor.Generator;

        package Los_DzienTygodnia is new Ada.Numerics.Discrete_Random(DzienTygodnia);
        GenDzienTygodnia: Los_DzienTygodnia.Generator;

        package Los_Liczba50 is new Ada.Numerics.Discrete_Random(Liczba50);
        GenLiczba50: Los_Liczba50.Generator;

        Gen: Generator;

    begin

        accept Start;

        Reset(Gen);
        Los_Kolor.Reset(GenKolor);
        Los_DzienTygodnia.Reset(GenDzienTygodnia);
        Los_Liczba50.Reset(GenLiczba50);

        loop

            select 
                accept WeFloat(I: out Float) do
                    I := Random(Gen) * 5.0;
                end WeFloat;
            or
                accept WeKolor(I: out Kolor) do
                    I := Los_Kolor.Random(GenKolor);
                end WeKolor;
            or
                accept WeDzienTygodnia(I: out DzienTygodnia) do
                    I := Los_DzienTygodnia.Random(GenDzienTygodnia);
                end WeDzienTygodnia;
            or
                accept WeTablicaLiczb(I: out TablicaLiczb) do
                    for El of I loop
                        El := Los_Liczba50.Random(GenLiczba50);
                    end loop;
                end WeTablicaLiczb;
            or
                accept Koniec;
                exit;
            end select;

        end loop;
        
        Put_Line("Koniec Serwer ");

    end Serwer;

begin

    Klient.Start;
    Serwer.Start; 
    Put_Line("Koniec_PG "); 

end Zad2;