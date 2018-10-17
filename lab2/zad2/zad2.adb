with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

procedure Zad2 is

    type Wektor is array (Integer range<>) of Float;
    W : Wektor(1 .. 100) := (1 .. 5 => 5.0, others => 10.0);

    procedure WypiszWektor(W : in Wektor) is
    begin

        for E of W loop
            Put_Line(E'Img);
        end loop;

    end WypiszWektor;

    procedure WypelnijWektorLosowo(W : out Wektor) is

        Gen : Generator;

    begin

        -- Put_Line("Zaczynam losowanie: ");
        Reset(Gen);

        for E of W loop
            E := Random(Gen);
            -- Put_Line(E'Img);
        end loop;

        -- Put_Line("Losowanie zakończone");

    end WypelnijWektorLosowo;

    function WektorPosortowany(W : in Wektor) return Boolean is
    begin

        return (for all I in W'First..(W'Last-1) => W(I) <= W(I+1));

    end WektorPosortowany;

    procedure SortujBabelkowo(W : in out Wektor) is

        Temp : Float;

    begin

        -- Put_Line("Zaczynam sortowanie");
        for I in W'Range loop
            for J in W'First..I loop
                if W(I) < W(J) then
                    Temp := W(I);
                    W(I) := W(J);
                    W(J) := Temp;
                end if; 
            end loop;
        end loop;
        -- Put_Line("Sortowanie zakończone");

    end SortujBabelkowo;

    procedure ZapiszDoPliku(W : in Wektor; NazwaPliku: String) is
        Pl : File_Type;	
    begin
        Create(Pl, Out_File, NazwaPliku);
        Put_Line("Tworze plik: " & NazwaPliku & " i zapisuje w nim wektor"); 
        for E of W loop
            Put_Line(Pl, E'Img);
        end loop;	   
        Close(Pl);
    end ZapiszDoPliku;

    T1, T2: Time;
    D: Duration; 

begin

    WypelnijWektorLosowo(W);

    -- Pomiar czasu sortowania
    T1 := Clock;
    SortujBabelkowo(W);
    T2 := Clock;
    D := T2 - T1;
    Put_Line("Czas sortowania = " & D'Img & "[s]");

    -- WypiszWektor(W);
    Put_Line("Czy wektor jest posortowany? " & WektorPosortowany(W)'Img);
    
    ZapiszDoPliku(W, "wektor.txt");

end Zad2;
