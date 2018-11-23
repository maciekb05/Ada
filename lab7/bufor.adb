with Ada.Text_IO;
use Ada.Text_IO;

procedure bufor is

    protected Buf is
        entry Wstaw(Ch : in Character);
        entry Pobierz(Ch : out Character);
    private
        B : Character;
        Pusty : Boolean := True;
    end Buf;

    protected body Buf is
        entry Wstaw(Ch : in Character)
            when Pusty is
        begin
            B := Ch;
            Pusty := False;
        end Wstaw;

        entry Pobierz(Ch : out Character)
            when not Pusty is
        begin
            Ch := B;
            Pusty := True;
        end Pobierz;
    end Buf;

    task Zad1;
    task Zad2;

    task body Zad1 is
    begin
        Buf.Wstaw('a');

        Buf.Wstaw('b');

        Buf.Wstaw('c');

        Buf.Wstaw('d');

        Buf.Wstaw('e');

    end Zad1;

    task body Zad2 is
        Char : Character;
    begin
        Put_Line("Zaczynam pobierac");
        for I in 1..5 loop
            Buf.Pobierz(Char);
            Put_Line("Pobrałem " & Char'Img);
        end loop;
    end Zad2;

begin

    Put_Line("Procedura główna");

end bufor;