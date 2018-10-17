with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;

procedure Main is

    T1 : array(1..10) of Float := (1|3|5|7 => 1.2, 8..10 => 2.4, others => 7.6);
    Sum : Float := 0.0;

begin

    for I in T1'First..T1'Last loop
        Put("Tab(" & I'Img & ")=");
        Put(T1(I), 3, 4, 0);
        New_Line;
    end loop;

    for E of T1 loop
        Sum := Sum + E;
    end loop;

    Put_Line("Suma = " & Sum'Img);

end Main;