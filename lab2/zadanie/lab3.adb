with Ada.Text_IO, Pak3, Ada.Calendar;
use Ada.Text_IO, Pak3, Ada.Calendar;

procedure Lab3 is

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

end Lab3;