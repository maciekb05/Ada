with Ada.Text_IO;
use Ada.Text_IO;

procedure sem is

    protected SL is
        entry Czekaj;
        procedure Sygmalizuj;
    private
        Sem: Integer:=2;
    end SL;

    protected body SL is
        entry Czekaj when Sem > 0 is
        begin
            Sem:=Sem-1;
            Put_Line("sekcja krytyczna!");
        end Czekaj;
        procedure Sygmalizuj is
        begin
            Sem:=Sem+1;
            Put_Line("zasob zwolniony");
        end Sygmalizuj;
    end SL;
    
    task zad1;
    task zad2;
    task zad3;
    task zad4;

    task body zad1 is
    begin
        SL.Czekaj;
        Put_Line("zad1");
    end zad1;

    task body zad2 is
    begin
        SL.Czekaj;
        Put_Line("zad2");
    end zad2;

    task body zad3 is
    begin
        SL.Czekaj;
        Put_Line("zad3");
    end zad3;

    task body zad4 is
    begin
        for I in 1..100 loop
            Put('a');
        end loop;
        SL.Sygmalizuj;
    end zad4;


begin

Put_Line("main");

end sem;