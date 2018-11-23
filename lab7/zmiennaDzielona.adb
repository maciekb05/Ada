with Ada.Text_IO;
use Ada.Text_IO;

procedure zmiennadzielona is
    Koniec : Boolean := False with Atomic;
    Char : Character := 'Z' with Atomic;
    task Zadanie1;
    task Zadanie2;

    task body Zadanie1 is
    begin
        loop
            exit when Koniec;
            Char := 'A';
            Put(Char'Img & " - A ");
        end loop;
    end Zadanie1;

    task body Zadanie2 is
    begin
        loop
            exit when Koniec;
            Char := 'B';
            Put(Char'Img & " - B ");
        end loop;
    end Zadanie2;

begin

    Put("Poczatek");
    Put("Koniec");
    Koniec := True;

end zmiennadzielona;