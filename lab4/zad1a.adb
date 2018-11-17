with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Numerics.Generic_Elementary_Functions;
use Ada.Text_IO;

procedure Zad1a is
    
        task Klient is

            entry Start;

        end Klient;

        task Serwer is 

            entry Start;
            entry Koniec;
            entry Odleglosc(X:Integer; Y:Integer);
            entry OdlegloscPkt(X1:Integer; Y1:Integer; X2:Integer; Y2:Integer);

        end Serwer;

        task body Klient is
        
            package Los_Liczby is new Ada.Numerics.Discrete_Random(Integer);
            use Los_Liczby;

            Gen: Generator;

            PrevX: Integer;
            PrevY: Integer;
            CurrX: Integer;
            CurrY: Integer;

        begin
        
            accept Start;

            Reset(Gen);

            PrevX := Random(Gen) rem 100;
            PrevY := Random(Gen) rem 100;

            for K in 1..3 loop

                CurrX := Random(Gen) rem 100;
                CurrY := Random(Gen) rem 100;
                Serwer.Odleglosc(CurrX, CurrY);
                Serwer.OdlegloscPkt(CurrX, CurrY, PrevX, PrevY);
                PrevX := CurrX;
                PrevY := CurrY;

            end loop;	

            Serwer.Koniec;

        end Klient;

        task body Serwer is

            OdlegloscPunktow: Float; 

            package Math_Float is new Ada.Numerics.Generic_Elementary_Functions(Float);
            use Math_Float;

        begin

            accept Start;
            
            loop

                    select 
                        accept Odleglosc(X: in Integer; Y: in Integer) do
                            OdlegloscPunktow := Sqrt(Float(X**2 + Y**2));
                        end Odleglosc;
                        Put_Line("Odleglosc =" & OdlegloscPunktow'Img);
                    or
                        accept OdlegloscPkt(X1: in Integer; Y1: in Integer; X2: in Integer; Y2: in Integer) do
                            OdlegloscPunktow := Sqrt(Float((X1-X2)**2 + (Y1-Y2)**2));
                        end OdlegloscPkt;
                        Put_Line("OdlegloscPkt =" & OdlegloscPunktow'Img);
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

end Zad1a;