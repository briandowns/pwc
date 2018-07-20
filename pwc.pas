(* FileStats is a program that is used to collect counts
 * of the number of characters, words, and lines in a 
 * given file, received from the CLI. *)

program FileStats;

{$I+} // io errors result in thrown exception
{$mode objfpc}{$H+}

uses
    Classes,
    strutils,
    Sysutils; 

var
    cc, wc, lc: Integer;
    F: TextFile;
    s: string;
    Arr: array of Char;
    i: Integer;
    LineLen: Integer;
    FileName: string;
    WordDelims: TSysCharSet;

(* VerifyArguments verifies that the program has been 
 * given a file to process. If no file is given, the 
 * program ends. *)
procedure VerifyArguments();
begin
    if paramCount < 1 then
    begin
        WriteLn('file required. exiting...');
        Halt;
    end;
end;

begin
    VerifyArguments;

    FileName := ParamStr(1);

    cc := 1;
    wc := 0;
    lc := 0;
    WordDelims := [#0..' ', ',', '.', ';', '/', '\', ':', '"', '`'];

    AssignFile(F, FileName);
    Reset(f);

    try
        begin 
            while not eof(F) do
            begin
                readln(F, s);
                lc += 1;
                wc += WordCount(s, WordDelims);
                LineLen := Length(s);
                cc += LineLen;
                SetLength(Arr, LineLen);
                for i := 1 to LineLen do
                    Arr[i - 1] := s[i];
            end;
            cc += 1;

            CloseFile(F);
        end;
    except
        on E: EInOutError do
            writeln('File handling error occurred. Details: ', E.Message);
    end;
    
    writeLn('    ', lc, '    ', wc , '    ', cc, ' ', FileName);
end. -- le fin
 