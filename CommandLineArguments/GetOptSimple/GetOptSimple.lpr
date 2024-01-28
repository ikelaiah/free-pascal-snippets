program GetOptSimple;

// Example usage (git bash):

// $ ./GetOptSimple -a "Hello" -b -c -d
// $ ./GetOptSimple -a "Hello" -bc -d
// $ ./GetOptSimple -a "Hello" -bcd
// $ ./GetOptSimple -dcb -a "Hello"

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  getopts;

var
  c: char = DEFAULT(char);
  shortOpts: string;

begin

  // If the external variable opterr is True (which is the default),
  // getopt prints an error message.
  // Ref: https://www.gnu.org/software/libc/manual/html_node/Using-Getopt.html
  //      https://www.freepascal.org/daily/doc/rtl/getopts/getopt.html
  OptErr := False;

  // Defining valid short options
  // For example; -a requires an argument,
  //              -b, -c and -d don't.
  shortOpts := 'a:bcd';

  repeat
    c := getopt(shortOpts);
    case c of
      'a': WriteLn('Option a was set with value ', optarg);
      'b': WriteLn('Option b was set');
      'c': WriteLn('Option c was set');
      'd': WriteLn('Option d was set');
      '?', ':': begin
        // If getopt finds an option character in argv that was not included
        // in options, or a missing option argument,
        //    - it returns `?` and
        //    - sets the external variable `optopt` to the actual option character.
        // If the first character of options is a colon (‘:’),
        //    - then getopt returns ‘:’ instead of ‘?’ to indicate a missing option argument.
        // Refs
        // - https://www.freepascal.org/docs-html/rtl/getopts/index.html
        // - https://www.gnu.org/software/libc/manual/html_node/Using-Getopt.html
        if (optopt = 'a') then
          writeln('Error: Option ', optopt, ' needs an argument.')
        else
          WriteLn('Error: Unknown option: ', optopt);
      end;
    end; // case
  until c = EndOfOptions;

  // The reminder, checks for non-option arguments (if any) using optind
  if optind <= paramcount then
  begin
    Write('Non options : ');
    while optind <= paramcount do
    begin
      Write(ParamStr(optind), ' ');
      Inc(optind);
    end;
    writeln;
  end;

end.
