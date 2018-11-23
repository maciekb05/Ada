with Ada.Text_IO;
use Ada.Text_IO;

procedure buforcykliczny is

    type TBuf is array(Integer range <>) of Character;

    protected type Buf(Rozmiar : Integer) is
        entry Wstaw(Ch : in Character);
        entry Pobierz(Ch : out Character);
    private
        B : TBuf(1..Rozmiar);
        LiczElem : Integer := 0;
        PozPob : Integer := 1;
        PozWstaw : Integer := 1;
    end Buf;

    protected body Buf is 
        entry Wstaw(Ch : in Character)
            when LiczElem < Rozmiar is
        begin
            B(PozWstaw) := Ch;
            PozWstaw := PozWstaw mod Rozmiar + 1;
            LiczElem := LiczElem + 1;
        end Wstaw;

        entry Pobierz(Ch : out Character)
            when LiczElem > 0 is
        begin   
            Ch := B(PozPob);
            PozPob := PozPob mod Rozmiar + 1;
            LiczElem := LiczElem - 1;
        end Pobierz;
    end Buf;

    task Zad1;
    task Zad2;
    Bufor : Buf(5);

    task body Zad1 is
    begin
        Bufor.Wstaw('a');
        Bufor.Wstaw('b');
        Bufor.Wstaw('c');
        Bufor.Wstaw('d');
        Bufor.Wstaw('e');
        Put_Line("Wstawilem 5, sprobuje 6");
        Bufor.Wstaw('f');
        Put_Line("Wstawilem 6");
        Bufor.Wstaw('a');
        Bufor.Wstaw('b');
        Bufor.Wstaw('c');
        Bufor.Wstaw('d');
        Bufor.Wstaw('e');
        Bufor.Wstaw('a');
        Bufor.Wstaw('b');
        Bufor.Wstaw('c');
        Bufor.Wstaw('d');
        Bufor.Wstaw('e');
    end Zad1;

    task body Zad2 is
        Znak : Character;
    begin
        for I in 1..100 loop
            Put("a");
        end loop;
        Put_Line("Zaczynam pobierac");
        for I in 1..15 loop
            Bufor.Pobierz(Znak);
            Put_Line("Pobralem " & Znak'Img);
        end loop;
    end Zad2;

begin

    Put_Line("Glowna");

end buforcykliczny;