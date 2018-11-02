-- wyjatki1.adb

with Ada.Text_IO;
use Ada.Text_IO;

procedure Lab4a is
  Pl : File_Type;
  Nazwa: String(1..100) := (others => ' ');	
  Dlugosc : Integer := 0;
begin
  loop
	Put_Line("Podaj nazwe pliku do otwarcia: ");
	Get_Line(Nazwa, Dlugosc);
    begin  	
	  Open(Pl, In_File, Nazwa(1..Dlugosc));
	  exit;
	exception
	  when Name_Error => Put_Line("Bledna nazwa pliku <" & Nazwa(1..Dlugosc) & "> !");
	end;  
  end loop;
  
  Put_Line("Otwieram plik: " & Nazwa(1..Dlugosc));

    for I in 1..6 loop
        declare
            A : String := Get_Line (Pl);
        begin
            Put_Line(A);
        end;
    end loop;

  Put_Line("Zamykam plik");
  Close(Pl);
end Lab4a;