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

unit u_TileStorageSQLiteFunc;

interface

uses
  i_BinaryData,
  i_MapVersionInfo,
  t_TileStorageSQLiteHandler;

function CreateTileBinaryData(
  const AOrigSize: Integer;
  const ABlobSize: Integer;
  const ABlobData: Pointer
): IBinaryData;

procedure ParseSQLiteDBVersion(
  const AUseVersionFieldInDB: Boolean;
  const ATBColInfoModeV: TVersionColMode;
  const ARequestedVersionInfo: IMapVersionInfo;
  out AInfo: TSelectTileInfoComplex
);

function VersionFieldIsEqual(
  const ARequestedVersionIsInt: Boolean;
  const ATBColInfoModeV: TVersionColMode;
  const AStrVersionToDB: AnsiString
): AnsiString;

implementation

uses
  ALString,
  SysUtils,
  c_TileStorageSQLite,
  u_BinaryData;

function CreateTileBinaryData(
  const AOrigSize: Integer;
  const ABlobSize: Integer;
  const ABlobData: Pointer
): IBinaryData;
begin
  Assert(ABlobData <> nil);
  Assert(AOrigSize = ABlobSize);
  Result := TBinaryData.Create(ABlobSize, ABlobData);
end;

function LocalTryStrToInt64(const S: AnsiString; out Value: Int64): Boolean;
begin
  // X701 is string
  // $123 is string
  Result := not (S[1] in ['x','X','$']) and ALTryStrToInt64(S, Value);
end;

function GetDefaultDBVersion(const AVersionColMode: TVersionColMode): AnsiString; inline;
begin
  if AVersionColMode = vcm_Int then begin
    Result := ALIntToStr(cDefaultVersionAsIntValue);
  end else begin
    Result := ALQuotedStr(cDefaultVersionAsStrValue);
  end;
end;

function VersionStoreStringToAnsi(const AVersionString: String): AnsiString; inline;
begin
  Result := AnsiString(AVersionString);
end;

function VersionInfoToAnsi(const AVersionInfo: IMapVersionInfo): AnsiString; inline;
begin
  Result := VersionStoreStringToAnsi(AVersionInfo.StoreString);
end;

procedure ParseSQLiteDBVersion(
  const AUseVersionFieldInDB: Boolean;
  const ATBColInfoModeV: TVersionColMode;
  const ARequestedVersionInfo: IMapVersionInfo;
  out AInfo: TSelectTileInfoComplex
);
begin
  FillChar(AInfo, SizeOf(AInfo), 0);

  if AUseVersionFieldInDB and Assigned(ARequestedVersionInfo) then begin
    AInfo.RequestedVersionToDB := VersionInfoToAnsi(ARequestedVersionInfo);
    if Length(AInfo.RequestedVersionToDB) = 0 then begin
      // default version
      AInfo.RequestedVersionToDB := GetDefaultDBVersion(ATBColInfoModeV);
      AInfo.RequestedVersionIsInt := True;
    end else if LocalTryStrToInt64(AInfo.RequestedVersionToDB, AInfo.RequestedVersionAsInt) then begin
      // as int - result ok
      if ATBColInfoModeV = vcm_Text then begin
        // ������ � �� ���������
        AInfo.RequestedVersionToDB := ALQuotedStr(AInfo.RequestedVersionToDB);
      end;
      AInfo.RequestedVersionIsInt := True;
      AInfo.RequestedVersionIsSet := True;
    end else begin
      // as text - quote result
      AInfo.RequestedVersionToDB := ALQuotedStr(AInfo.RequestedVersionToDB);
      AInfo.RequestedVersionIsInt := False;
      AInfo.RequestedVersionIsSet := True;
    end;
  end else begin
    // default version
    AInfo.RequestedVersionToDB := GetDefaultDBVersion(ATBColInfoModeV);
    AInfo.RequestedVersionIsInt := True;
  end;
end;

function VersionFieldIsEqual(
  const ARequestedVersionIsInt: Boolean;
  const ATBColInfoModeV: TVersionColMode;
  const AStrVersionToDB: AnsiString
): AnsiString;
begin
  // ��������� ����� ���� v = VERSION
  case ATBColInfoModeV of
    vcm_Int: begin
      // ������ � �� �������������
      if ARequestedVersionIsInt then begin
        Result := 'v'; // ���� ��� ����� - ������ ��� � �����
      end else begin
        Result := 'cast(v as TEXT)'; // ������ - ������ �� ������������ � ������
      end;
    end;
    vcm_Text: begin
      // ������ � �� ���������
      if not ARequestedVersionIsInt then begin
        Result := 'v'; // ���� ��� ������ - ������ ��� � �����
      end else begin
        Result := 'cast(v as TEXT)'; // ������ - ������ �� ������������ � ������
      end;
    end;
  else
    begin
      Assert(False, IntToStr(Ord(ATBColInfoModeV)));
    end;
  end;
  // ��������� ������� ��������� ������
  Result := Result + '=' + AStrVersionToDB;
end;

end.
