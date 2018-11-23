with Ada.Text_IO;
use Ada.Text_IO;

procedure zadanie2 is
    task A;

    task B is
        entry Wstaw(L: in Integer);
        entry Koniec;
    end B;

    task body A is
    begin
        for I in 1..100 loop
            B.Wstaw(I);
        end loop;
        B.Koniec;
    end A;

    task body B is
        liczbaB : Integer;
    begin
        loop
            select
                accept Wstaw(L : in Integer) do
                    LiczbaB := L;
                end Wstaw;
                Put(LiczbaB'Img);
            or
                accept Koniec;
                exit;
            end select;
        end loop;
    end B;

begin
    null;
end zadanie2;