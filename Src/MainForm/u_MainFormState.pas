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

unit u_MainFormState;

interface

uses
  i_MainFormState,
  u_ChangeableBase;

type
  TMainFormState = class(TChangeableBase, IMainFormState)
  private
    FState: TStateEnum;
  private
    function GetState: TStateEnum;
    procedure SetState(AValue: TStateEnum);
  public
    constructor Create;
  end;

implementation

uses
  u_Synchronizer;

{ TMainFormState }

constructor TMainFormState.Create;
begin
  inherited Create(GSync.SyncVariable.Make(Self.ClassName + 'Notifiers'));
  FState := ao_movemap;
end;

function TMainFormState.GetState: TStateEnum;
begin
  Result := FState;
end;

procedure TMainFormState.SetState(AValue: TStateEnum);
begin
  if FState <> AValue then begin
    FState := AValue;
    DoChangeNotify;
  end;
end;

end.
