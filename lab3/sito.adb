with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Sito is

type Element is record 
    Liczba : Integer;
    CzyPierwsza : Boolean;
    Next : access Element := Null;
end record; 

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then

    Put_Line("List EMPTY!");

  else

    Put_Line("Pierwsze:"); 

  end if;

  while L /= Null loop

    if L.CzyPierwsza then

        Put(L.Liczba, 1);
        Put(", "); 

    end if;

    L := L.Next;

  end loop;

  New_Line;

end Print;

procedure Insert(List : in out Elem_Ptr; Liczba : in Integer) is
  E : Elem_Ptr := new Element; 
begin

  E.Liczba := Liczba;
  E.CzyPierwsza := true;
  E.Next := List;
  List := E;

end Insert;

procedure UzupelnijListe(Lista : out Elem_Ptr; Ile : Integer) is

begin

    for I in 2..Ile loop
        Insert(Lista, Ile + 2 - I);
    end loop;

end UzupelnijListe;

procedure Wykreslanie(Lista : in out Elem_Ptr) is
    Current : Elem_Ptr := Lista;
    Pierwsza : Integer;
    DoWykreslenia : Integer;
    Inner : Elem_Ptr := Lista;
begin

    while Current /= Null loop
        Pierwsza := Current.Liczba;
        DoWykreslenia := Pierwsza * 2;
        Inner := Current;

        while Inner /= Null loop
            if Inner.Liczba = DoWykreslenia then
                DoWykreslenia := DoWykreslenia + Pierwsza;
                Inner.CzyPierwsza := false;
            end if;
            Inner := Inner.Next;
        end loop;

        Current := Current.Next;

    end loop;

end Wykreslanie;

Lista : Elem_Ptr;

begin

  UzupelnijListe(Lista, 100);
  Wykreslanie(Lista);
  Print(Lista);

end Sito;