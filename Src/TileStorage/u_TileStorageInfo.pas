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

unit u_TileStorageInfo;

interface

uses
  i_ProjectionSet,
  i_ContentTypeInfo,
  i_TileStorageAbilities,
  i_TileStorageInfo,
  u_BaseInterfacedObject;

type
  TTileStorageInfo = class(TBaseInterfacedObject, ITileStorageInfo)
  private
    FTypeAbilities: ITileStorageAbilities;
    FForceAbilities: ITileStorageAbilities;
    FMainContentType: IContentTypeInfoBasic;
    FAllowDifferentContentTypes: Boolean;
    FProjectionSet: IProjectionSet;
  private
    function GetTypeAbilities: ITileStorageAbilities;
    function GetForceAbilities: ITileStorageAbilities;
    function GetMainContentType: IContentTypeInfoBasic;
    function GetAllowDifferentContentTypes: Boolean;
    function GetProjectionSet: IProjectionSet;
  public
    constructor Create(
      const ATypeAbilities: ITileStorageAbilities;
      const AForceAbilities: ITileStorageAbilities;
      const AMainContentType: IContentTypeInfoBasic;
      AAllowDifferentContentTypes: Boolean;
      const AProjectionSet: IProjectionSet
    );
  end;

implementation

{ TTileStorageInfo }

constructor TTileStorageInfo.Create(
  const ATypeAbilities: ITileStorageAbilities;
  const AForceAbilities: ITileStorageAbilities;
  const AMainContentType: IContentTypeInfoBasic;
  AAllowDifferentContentTypes: Boolean;
  const AProjectionSet: IProjectionSet
);
begin
  inherited Create;
  FTypeAbilities := ATypeAbilities;
  FForceAbilities := AForceAbilities;
  FProjectionSet := AProjectionSet;
  FMainContentType := AMainContentType;
  FAllowDifferentContentTypes := AAllowDifferentContentTypes;
end;

function TTileStorageInfo.GetAllowDifferentContentTypes: Boolean;
begin
  Result := FAllowDifferentContentTypes;
end;

function TTileStorageInfo.GetProjectionSet: IProjectionSet;
begin
  Result := FProjectionSet;
end;

function TTileStorageInfo.GetForceAbilities: ITileStorageAbilities;
begin
  Result := FForceAbilities;
end;

function TTileStorageInfo.GetMainContentType: IContentTypeInfoBasic;
begin
  Result := FMainContentType;
end;

function TTileStorageInfo.GetTypeAbilities: ITileStorageAbilities;
begin
  Result := FTypeAbilities;
end;

end.
