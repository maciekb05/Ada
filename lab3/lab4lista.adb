with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is

type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null;
  end record; 

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:"); 
  end if; 
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) ); 

-- do napisania !! 
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
  
  Previous : Elem_Ptr := List;
  Current : Elem_Ptr := List;
  E : Elem_Ptr := new Element;

begin

  E.Data := D;

  if Current = Null then

    E.Next := Null;
    List := E;

  elsif Current.Data <= D then

    E.Next := List;
    List := E;

  else

    while Current.Data > D loop

      Previous := Current;
      Current := Previous.Next;

      if Current = Null then
        exit;
      end if;

    end loop;

    Previous.Next := E;
    E.Next := Current;

  end if;

end Insert_Sort;


procedure generujIWstaw( N : in Integer; M : in Integer; List : in out Elem_Ptr) is
  
  package Los_Integer is new Ada.Numerics.Discrete_Random(Integer);
  use Los_Integer;

  Gen : Generator;
  Rand : Integer;

begin

  Reset(Gen);

  for I in 1..N loop
    Rand := Random(Gen) rem M;
    if Rand < 0 then 
      Rand := -Rand;
    end if;
    Insert_Sort(List, Rand);
  end loop;

end generujIWstaw;

function Search(D : in Integer; List : in Elem_Ptr) return Boolean is
  Current : Elem_Ptr := List;
begin

  while Current.Next /= Null loop

    if Current.Data = D then
      return true;
    end if;

    Current := Current.Next;

  end loop;

  return false;

end Search;

procedure Delete(D : in Integer; List : in out Elem_Ptr) is
  
  Previous : Elem_Ptr := List;
  Current : Elem_Ptr := List;

begin

  if Current = Null then

    Null;

  elsif Current.Data = D then

    List := List.Next;

  else

    while Current.Next /= Null loop

      Previous := Current;
      Current := Previous.Next;

      if Current.Data = D then
        Previous.Next := Current.Next;
      end if;

    end loop;

  end if;

end Delete;

Lista : Elem_Ptr := Null;
Boo : Boolean;
begin
  
  generujIWstaw(50, 100, Lista);
  Print(Lista);

  Boo := Search(25, Lista);
  Put_Line(Boo'Img);

  Delete(25, Lista);
  
  Boo := Search(25, Lista);
  Put_Line(Boo'Img);

end Lab4Lista;