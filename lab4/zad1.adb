with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Numerics.Generic_Elementary_Functions;
use Ada.Text_IO;

procedure Zad1 is
    
  task Klient is
    entry Start;
  end Klient;

  task Serwer is 
    entry Start;
    entry Koniec;
    entry OdlegloscOdPoczatkuUkladu(X:Integer; Y:Integer);
    --entry OdlegloscPomiedzy(X1:Integer, Y1:Integer, X2:Integer, Y2:Integer);
  end Serwer;

  task body Klient is
    X: Integer;
    Y: Integer;

    package Los_Integer is new Ada.Numerics.Discrete_Random(Integer);
    use Los_Integer;

    Gen: Generator;
  begin
    accept Start;
    reset(Gen);

    for K in 1..3 loop
      X := Random(Gen);
      Y := Random(Gen);
      Serwer.OdlegloscOdPoczatkuUkladu(X, Y);
    end loop;	  

    Serwer.Koniec;
  end Klient;

  task body Serwer is
    Wynik: Float;
    package Liczenie is new Ada.Numerics.Generic_Elementary_Functions(Float);
    use Liczenie;
  begin
    accept Start;
    loop
      select 
      accept OdlegloscOdPoczatkuUkladu(X: in Integer; Y: in Integer) do
        Wynik := Sqrt(Float(X**2+Y**2));
      end OdlegloscOdPoczatkuUkladu;
      Put_Line("Wynik=" & Wynik'Img);
      or 
      accept Koniec;
      exit;
      end select;
    end loop;
    
    Put_Line("Koniec Serwer ");
  end Serwer;

begin
  Klient.Start;
  Serwer.Start; 
  Put_Line("Koniec_PG "); 
end Zad1;
	  	