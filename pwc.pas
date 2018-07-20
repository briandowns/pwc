(* Copyright 2018 Brian J Downs. All rights reserved.
 * Use of this source code is governed the BSD 2 clause
 * license that can be found in the LICENSE file.
 *
 * pwc is a program that is used to collect counts
 * of the number of characters, words, and lines in a 
 * given file, received from the CLI. *)

program pwc;

{$mode objfpc}{$H+}{$I+}

uses
    strutils,
    Sysutils; 

var
    CharsCount, WordsCount, LinesCount: Integer;
    F: TextFile;
    s: string;
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

    (* initialize counts *)
    CharsCount := 1;
    WordsCount := 0;
    LinesCount := 0;

    (* we're defining out our delimiters here since the built in 
     * delimeter array contains matches for single quotes which 
     * results in false positives. *)
    WordDelims := [#0..' ', ',', '.', ';', '/', '\', ':', '"', '`'];

    AssignFile(F, FileName);
    Reset(f);

    try
        begin 
            while not eof(F) do
            begin
                readln(F, s);
                LinesCount += 1;
                WordsCount += WordCount(s, WordDelims);
                LineLen := Length(s);
                CharsCount += LineLen;
            end;
            CharsCount += 1;
            CloseFile(F);
        end;
    except
        on E: EInOutError do
            writeln('file handling error occurred. ', E.Message);
    end;
    writeLn('    ', LinesCount, '    ', WordsCount , '    ', CharsCount, ' ', FileName);
end. -- le fin
 