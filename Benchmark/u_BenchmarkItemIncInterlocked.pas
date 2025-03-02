{******************************************************************************}
{* This file is part of SAS.Planet project.                                   *}
{*                                                                            *}
{* Copyright (C) 2007-2021, SAS.Planet development team.                      *}
{*                                                                            *}
{* SAS.Planet is free software: you can redistribute it and/or modify         *}
{* it under the terms of the GNU General Public License as published by       *}
{* the Free Software Foundation, either version 3 of the License, or          *}
{* (at your option) any later version.                                        *}
{*                                                                            *}
{* SAS.Planet is distributed in the hope that it will be useful,              *}
{* but WITHOUT ANY WARRANTY; without even the implied warranty of             *}
{* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the               *}
{* GNU General Public License for more details.                               *}
{*                                                                            *}
{* You should have received a copy of the GNU General Public License          *}
{* along with SAS.Planet. If not, see <http://www.gnu.org/licenses/>.         *}
{*                                                                            *}
{* https://github.com/sasgis/sas.planet.src                                   *}
{******************************************************************************}

unit u_BenchmarkItemIncInterlocked;

interface

uses
  u_BenchmarkItemBase;

type
  TBenchmarkItemIncInterlocked = class(TBenchmarkItemBase)
  private
    FData: Integer;
  protected
    function RunOneStep: Integer; override;
  public
    constructor Create;
  end;

implementation

uses
  Windows;

const CRepeatCount = 1000;

{ TBenchmarkItemIncInterlocked }

constructor TBenchmarkItemIncInterlocked.Create;
begin
  inherited Create(True, 'Interlocked Increment', CRepeatCount);
end;

function TBenchmarkItemIncInterlocked.RunOneStep: Integer;
var
  i: Integer;
begin
  for i := 0 to CRepeatCount - 1 do begin
    InterlockedIncrement(FData);
  end;
  Result := FData;
end;

end.
