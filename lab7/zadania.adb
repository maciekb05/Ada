with Ada.Text_IO;
use Ada.Text_IO;

procedure zadania is

    task A is
        entry Start;
    end A;

    task B is
        entry Start;
    end B;

    task body A is
    begin
        accept Start;
        for I in 1..100 loop 
            Put ("Z_A ");
        end loop;
    end A;

    task body B is
    begin
        accept Start;
        for I in 1..100 loop 
            Put ("Z_B ");
        end loop;
    end B;

begin

    A.Start;
    B.Start;

end zadania;