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

unit u_BenchmarkItemBitmap32FillRect;

interface

uses
  GR32,
  u_BenchmarkItemBase;

type
  TBenchmarkItemBitmap32FillRect = class(TBenchmarkItemBase)
  private
    FDest: TCustomBitmap32;
    FBitmapSize: Integer;
    FUseSafe: Boolean;
    FUseTransparent: Boolean;
    FCombineMode: TCombineMode;
    FColor: TColor32;
  protected
    procedure SetUp; override;
    function RunOneStep: Integer; override;
    procedure TearDown; override;
  public
    constructor Create(
      const ABitmapSize: Integer;
      const AUseSafe: Boolean;
      const AUseTransparent: Boolean;
      const ACombineMode: TCombineMode
    );
  end;

implementation

uses
  SysUtils;
  
{ TBenchmarkItemBitmap32FillRec }

constructor TBenchmarkItemBitmap32FillRect.Create(
  const ABitmapSize: Integer;
  const AUseSafe: Boolean;
  const AUseTransparent: Boolean;
  const ACombineMode: TCombineMode
);
var
  VName: string;
  VCombineMode: string;
  VSafe: string;
  VTransparent: string;
begin
  Assert(ABitmapSize > 0);
  if AUseSafe then begin
    VSafe := 'Safe';
  end else begin
    VSafe := 'Unsafe';
  end;
  if AUseTransparent then begin
    case ACombineMode of
      cmBlend: VCombineMode := 'Blend';
      cmMerge: VCombineMode := 'Merge';
    end;
    VTransparent := 'Transparent '+ VCombineMode;
  end else begin
    VTransparent := 'Solid';
  end;
  VName := Format('FillRect %s %s', [VSafe, VTransparent]);
  inherited Create(True, VName, ABitmapSize * ABitmapSize);
  FBitmapSize := ABitmapSize;
  FUseSafe := AUseSafe;
  FUseTransparent := AUseTransparent;
  FCombineMode := ACombineMode;
  if AUseTransparent then begin
    FColor := SetAlpha(clGray32, 128);
  end else begin
    FColor := clLightGray32;
  end;
end;

function TBenchmarkItemBitmap32FillRect.RunOneStep: Integer;
begin
  if FUseSafe then begin
    if FUseTransparent then begin
      FDest.FillRectTS(0, 0, FBitmapSize, FBitmapSize, FColor);
    end else begin
      FDest.FillRectS(0, 0, FBitmapSize, FBitmapSize, FColor);
    end;
  end else begin
    if FUseTransparent then begin
      FDest.FillRectT(0, 0, FBitmapSize, FBitmapSize, FColor);
    end else begin
      FDest.FillRect(0, 0, FBitmapSize, FBitmapSize, FColor);
    end;
  end;
  Result := FDest.Bits[0];
end;

procedure TBenchmarkItemBitmap32FillRect.SetUp;
var
  VColor: TColor32;
  i: Integer;
begin
  inherited;
  VColor := SetAlpha(clGray32, 128);

  FDest := TCustomBitmap32.Create;
  FDest.SetSize(FBitmapSize, FBitmapSize);
  FDest.CombineMode := FCombineMode;
  for i := 0 to FBitmapSize*FBitmapSize - 1 do begin
    FDest.Bits[i] := VColor;
    Inc(VColor);
  end;
end;

procedure TBenchmarkItemBitmap32FillRect.TearDown;
begin
  inherited;
  FreeAndNil(FDest);
end;

end.
