with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Containers.Vectors;
use Ada.Text_IO, Ada.Containers;

procedure Lab4bst is

type TElement is
record
    Data: Integer := 0;
    Left: access TElement := Null;
    Right: access TElement := Null;
end record;

type Elem_Ptr is access all TElement;

procedure Print(Bst : access TElement) is
  T : access TElement := Bst;
begin
  if T /= Null then
    Put_Line(T.Data'Img);
    Print(T.Left);
    
    Print(T.Right);
  end if;
end Print;

procedure Insert(Bst : in out Elem_Ptr; Val : in Integer) is
    T : Elem_Ptr := Bst;
    Elem : Elem_Ptr := new TElement;
begin

    Elem.Data := Val;

    if T = Null then
        Bst := Elem;
    else
        if T.Data <= Elem.Data then
            Insert(T.Right, Val);
        else
            Insert(T.Left, Val);
        end if;
    end if;

end Insert;

procedure GenerujIWstaw(N : in Integer; M : in Integer; Tree : in out Elem_Ptr) is

    type IntWZakresie is new Integer range 0 .. M;
    package Los_Integer is new Ada.Numerics.Discrete_Random(IntWZakresie);
    use Los_Integer;

    Gen : Generator;
    Rand : IntWZakresie;

begin

    Reset(Gen);

    for I in 0 .. N loop
        Rand := Random(Gen);
        Insert(Tree, Integer(Rand));
    end loop;

end GenerujIWstaw;

function Znajdz(X : in Integer; Tree : in Elem_Ptr) return Boolean is
    Bst : Elem_Ptr := Tree;
begin
    if Bst /= Null then

        if Bst.Data = X then
            return true;
        elsif Bst.Data > X then
            return Znajdz(X, Bst.Left);
        else
            return Znajdz(X, Bst.Right);
        end if;

    else

        return false;

    end if;

end Znajdz;



function MinValNode(Node : in Elem_Ptr) return Elem_Ptr is
    Current : Elem_Ptr := Node;
begin

    while Current.Left /= Null loop
        Current := Current.Left;
    end loop;

    return Current;

end MinValNode;

function Delete(Root : in out Elem_Ptr; Key : Integer) return Elem_Ptr is 

    Temp : Elem_Ptr := Null;

begin
    if Root = Null then
        return Root;
    end if;

    if Key < Root.Data then

        Root.Left := Delete(Root.Left, Key);

    elsif Key > Root.Data then

        Root.Right := Delete(Root.Right, Key);

    else

        if Root.Left = Null then
            return Root.Right;
        elsif Root.Right = Null then
            return Root.Left;
        end if;

        Temp := MinValNode(Root.Right);
        Root.Data := Temp.Data;
        Root.Right := Delete(Root.Right, Temp.Data);

    end if; 

    return Root;

end Delete;

package Nodes_Vectors is new Vectors(Natural, Elem_Ptr);
use Nodes_Vectors;


procedure StoreBSTNodes(Root : in Elem_Ptr; Nodes : in out Vector) is
   
begin

    if Root /= Null then
        StoreBSTNodes(Root.Left, Nodes);
        Nodes.Append(Root);
        StoreBSTNodes(Root.Right, Nodes);
    end if;

end StoreBSTNodes;

function BuildTreeUtil(Nodes : in out Vector; Start : Integer; Endd : Integer) return Elem_Ptr is
    Mid : Integer := (Start + Endd) / 2;
    Node : Elem_Ptr := Element(Nodes, Mid);
begin

    if Start > Endd then
        return Null;
    end if;

    Node.Left := BuildTreeUtil(nodes, Start, Mid - 1);
    Node.Right := BuildTreeUtil(nodes, Mid + 1, Endd);

    return Node;

end BuildTreeUtil;

function BuildTree(Root : in out Elem_Ptr) return Elem_Ptr is
    Nodes : Vector;
    N : Integer;
begin

    StoreBSTNodes(Root, Nodes);

    N := Integer(Length(Nodes));

    return BuildTreeUtil(Nodes, 0, N-1);

end BuildTree;


procedure PrintJSON(Bst : access TElement) is
  T : access TElement := Bst;
begin
  Put_Line("{");
    Put_Line("""Data"": """ &T.Data'Img& """");
    if T.Left /= Null then
        Put_Line(",");
        Put_Line("""Left"": ");
        PrintJSON(T.Left);
    end if;
    if T.Right /= Null then
        Put_Line(",");
        Put_Line("""Right"": ");
        PrintJSON(T.Right);
    end if;
  Put_Line("}");
end PrintJSON;

procedure PrintTreeToFile(Bst : access TElement; Pl : File_Type) is
    T : access TElement := Bst;
begin
    Put_Line(Pl, "{");
    Put_Line(Pl, """Data"": """ &T.Data'Img& """");
    if T.Left /= Null then
        Put_Line(Pl, ",");
        Put_Line(Pl, """Left"": ");
        PrintTreeToFile(T.Left, Pl);
    end if;
    if T.Right /= Null then
        Put_Line(Pl, ",");
        Put_Line(Pl, """Right"": ");
        PrintTreeToFile(T.Right, Pl);
    end if;
    Put_Line(Pl, "}");

end PrintTreeToFile;

Tree : Elem_Ptr := Null;
Nazwa: String := "plik.txt";
Pl : File_Type;

begin


GenerujIWstaw(10,100,Tree);

--Insert(Tree, 5);
--Insert(Tree, 6);
--Insert(Tree, 10);
--Insert(Tree, 7);
--Insert(Tree, 8);
--Insert(Tree, 12);

Print(Tree);

if Znajdz(50,Tree) then
    Put_Line("Jest 50");
else
    Put_Line("Nie ma 50");
end if;

Tree := Delete(Tree, 50);

Tree := BuildTree(Tree);

Print(Tree);
PrintJSON(Tree);
Create(Pl, Out_File, Nazwa); -- Open
PrintTreeToFile(Tree, Pl);
Close(Pl);

end Lab4bst;