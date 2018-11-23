with Ada.Text_IO;
use Ada.Text_IO;

procedure semafor is

    protected SB is
        entry Czekaj;
        procedure Sygnalizuj;
    private
        Sem : Boolean := False;
    end SB;

    protected body SB is
        entry Czekaj when Sem is
        begin
            Sem := False;
            Put_Line("sekcja krytyczna");
        end Czekaj;

        procedure Sygnalizuj is
        begin
            Sem := True;
        end Sygnalizuj;
    end SB;

    task Zad1;

    task body Zad1 is
    begin
        Put_Line("Zad1 czeka");
        SB.Czekaj;
        Put_Line("Zad1 nie czeka");
    end Zad1;



    task Zad2;

    task body Zad2 is
    begin
        for I in 1..100 loop
            Put('a');
        end loop;
        Put_Line("Zad2 sygnalizuje");
        SB.Sygnalizuj;
        Put_Line("Zad2 zasygnalizowalo");
    end Zad2;

begin

    Put_Line("zadanie glowne");

end semafor;