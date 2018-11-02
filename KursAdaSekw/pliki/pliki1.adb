-- pliki1.adb

with Ada.Text_IO;
use Ada.Text_IO;

procedure Pliki1 is
  Pl : File_Type;
  Nazwa: String := "plik.txt";	
begin
  Create(Pl, Out_File, Nazwa); -- Open
  Put_Line("Tworze plik: " & Nazwa); -- do konsoli
  Put_Line(Pl, "Poczatek pliku"); -- do pliku
  for I in 1..10 loop
	Put_Line(Pl,"Plik testowy, linia " & I'Img);
  end loop;
  Put_Line(Pl, "Koniec pliku testowego");
  Close(Pl); -- zamykamy plik
end Pliki1;