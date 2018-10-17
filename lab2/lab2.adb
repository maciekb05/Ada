-- lab2.adb

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Lab2 is
    type Wektor is array (Integer range <>) of Integer;
    W1 : Wektor(1 .. 20) := (1..20 => 2);
    
    procedure Wypisz(W : Wektor) is 
    begin
        for E of W loop
            Put(E'Img);
            New_Line;
        end loop;
    end Wypisz;

    procedure Los(W : out Wektor) is
        package Los_Int is new Ada.Numerics.Discrete_Random(Integer); 
        use Los_Int;
        
        Gen: Generator;
    begin
        Reset(Gen);
        for E of W loop
            E := Random(Gen);
        end loop;
    end Los;   

    procedure CzyPosortowany(W : Wektor) is
    begin
        if (for all I in W'First..(W'Last-1) => W(I) < W(I+1) )
        then 
    end CzyPosortowany; 

begin
    Los(W1);
    Wypisz(W1);    

end Lab2;