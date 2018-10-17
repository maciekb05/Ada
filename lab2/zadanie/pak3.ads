package Pak3 is

    type Wektor is array (Integer range<>) of Float;
    W : Wektor(1 .. 100);

    procedure WypiszWektor(W : in Wektor);
    procedure WypelnijWektorLosowo(W : out Wektor);
    function WektorPosortowany(W : in Wektor) return Boolean;
    procedure SortujBabelkowo(W : in out Wektor);
    procedure ZapiszDoPliku(W : in Wektor; NazwaPliku: String);

end Pak3;