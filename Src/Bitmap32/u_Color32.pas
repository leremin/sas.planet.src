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

unit u_Color32;

interface

uses
  Graphics,
  t_Bitmap32;

// Color construction and conversion functions
//function Color32(WinColor: TColor): TColor32; overload; inline;
//function Color32(R, G, B: Byte; A: Byte = $FF): TColor32; overload; inline;
//function Gray32(Intensity: Byte; Alpha: Byte = $FF): TColor32; inline;
//function WinColor(Color32: TColor32): TColor; inline;

// Color component access
//procedure Color32ToRGB(Color32: TColor32; var R, G, B: Byte); inline;
//procedure Color32ToRGBA(Color32: TColor32; var R, G, B, A: Byte); inline;
//function RedComponent(Color32: TColor32): Integer; inline;
//function GreenComponent(Color32: TColor32): Integer; inline;
//function BlueComponent(Color32: TColor32): Integer; inline;
//function AlphaComponent(Color32: TColor32): Integer; inline;
//function Intensity(Color32: TColor32): Integer; inline;
function SetAlpha(
    Color32: TColor32;
    NewAlpha: Integer
  ): TColor32; inline;

implementation

//uses
//  GR32;

//function Color32(WinColor: TColor): TColor32; overload; inline;
//begin
//  Result := GR32.Color32(WinColor);
//end;

//function Color32(R, G, B: Byte; A: Byte = $FF): TColor32; overload; inline;
//begin
//  Result := GR32.Color32(R, G, B, A);
//end;

//function Gray32(Intensity: Byte; Alpha: Byte = $FF): TColor32; inline;
//begin
//  Result := GR32.Gray32(Intensity, Alpha);
//end;

//function WinColor(Color32: TColor32): TColor; inline;
//begin
//  Result := GR32.WinColor(Color32);
//end;

//procedure Color32ToRGB(Color32: TColor32; var R, G, B: Byte); inline;
//begin
//  GR32.Color32ToRGB(Color32, R, G, B);
//end;

//procedure Color32ToRGBA(Color32: TColor32; var R, G, B, A: Byte); inline;
//begin
//  GR32.Color32ToRGBA(Color32, R, G, B, A);
//end;

//function RedComponent(Color32: TColor32): Integer; inline;
//begin
//  Result := GR32.RedComponent(Color32);
//end;

//function GreenComponent(Color32: TColor32): Integer; inline;
//begin
//  Result := GR32.GreenComponent(Color32);
//end;

//function BlueComponent(Color32: TColor32): Integer; inline;
//begin
//  Result := GR32.BlueComponent(Color32);
//end;

//function AlphaComponent(Color32: TColor32): Integer; inline;
//begin
//  Result := GR32.AlphaComponent(Color32);
//end;

//function Intensity(Color32: TColor32): Integer; inline;
//begin
//  Result := GR32.Intensity(Color32);
//end;

function SetAlpha(
  Color32: TColor32;
  NewAlpha: Integer
): TColor32; inline;
begin
  if NewAlpha < 0 then begin
    NewAlpha := 0;
  end else if NewAlpha > 255 then begin
    NewAlpha := 255;
  end;
  Result := (Color32 and $00FFFFFF) or (TColor32(NewAlpha) shl 24);
end;

end.
