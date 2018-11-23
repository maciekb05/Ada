with Ada.Text_IO;
use Ada.Text_IO;

procedure semzad is

    task SB is
        entry Czekaj;
        entry Sygnalizuj;
        entry Koniec;
    end SB;

    task body SB is
        Sem : Boolean := False;
    begin
        loop
            select
                when Sem =>
                accept Czekaj
                do
                    Sem := False;
                    Put_Line("sekcja kryt");
                end Czekaj;
            --or
            --    when not Sem =>
           --     accept Czekaj
            --    do
            --        SB.Czekaj;
            --    end Czekaj;
            or 
                accept Sygnalizuj
                do
                    Sem := True;
                end Sygnalizuj;
            or  
                accept Koniec;
                exit;
            end select;
        end loop;
    end SB;

    task Zad1;

    task body Zad1 is
    begin
        Put_Line("Zad1 czeka");
        SB.Czekaj;
        Put_Line("Zad1 nie czeka");
        SB.Koniec;
    end Zad1;

    task Zad2;

    task body Zad2 is
    begin
        Put_Line("Zad2 sygnalizuje");
        SB.Sygnalizuj;
        Put_Line("Zad2 zasygnalizowalo");
    end Zad2;

begin

    Put_Line("zadanie glowne");

end semzad;