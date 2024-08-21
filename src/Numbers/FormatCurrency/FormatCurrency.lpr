program FormatCurrency;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

var
  amount: currency;
  formattedAmount: string;

  { Main Block }
begin
  amount := 12345678.90;
  formattedAmount := CurrToStrF(amount, ffCurrency, 2);
  WriteLn(formattedAmount);  // Output: $12,345,678.90

  // Pause console
  WriteLn('Press enter to quit');
  ReadLn;
end.

