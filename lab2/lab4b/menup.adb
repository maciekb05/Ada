-- menup.adb

with Ada.Text_IO, Opcje, Ada.Calendar; -- nasz pakiet
use Ada.Text_IO, Opcje, Ada.Calendar; 

procedure MenuP is
  Zn: Character := ' '; 
  
  procedure Pisz_Menu is
  begin
	New_Line;  
	Put_Line("Menu:");  
  Put_Line(" s - opcja s");
	Put_Line(" c - opcja c");
	Put_Line(" p - opcja p");
	Put_Line("ESC -Wyjscie");
	Put_Line("Wybierz (s,c,p, ESC-koniec):");
  end Pisz_Menu;

	procedure PiszDziennik(Pl : File_Type; Nazwa : String; Zdarzenie : String) is 
			
	begin
		Put_Line("Tworze plik: " & Nazwa);
		Put_Line(Pl, Zdarzenie);
		Put(Pl, Year(Clock)'Img);
		Put(Pl,".");
		Put(Pl, Month(Clock)'Img);
		Put(Pl,".");
		Put(Pl, Day(Clock)'Img);
		Put(Pl," -");
		Put(Pl, Duration'Image(Seconds(Clock)));
		Put_Line(Pl,"");
	end PiszDziennik;
  
Pl : File_Type;
Nazwa: String := "dziennik.txt";

begin
Create(Pl, Out_File, Nazwa);
PiszDziennik(Pl, Nazwa, "Start");
  loop
    Pisz_Menu;
	Get_Immediate(Zn);
	exit when Zn = ASCII.ESC;
	case Zn is
	  when 's' => Opcja_S;
	  when 'c' => Opcja_C;
	  when 'p' => Opcja_P;
      when others => Put_Line("Blad!!");
	end case;
  end loop;
  Put_Line("Koniec");
PiszDziennik(Pl, Nazwa, "Zakończenie");
Close(Pl);
end MenuP;
  	 
  