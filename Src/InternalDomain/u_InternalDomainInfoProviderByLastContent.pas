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

unit u_InternalDomainInfoProviderByLastContent;

interface

uses
  i_BinaryData,
  i_InternalBrowserLastContent,
  i_InternalDomainInfoProvider,
  u_BaseInterfacedObject;

type
  TInternalDomainInfoProviderByLastContent = class(TBaseInterfacedObject, IInternalDomainInfoProvider)
  private
    FContent: IInternalBrowserLastContent;
    function BuildBinaryDataByText(const AText: string): IBinaryData;
  private
    function LoadBinaryByFilePath(
      const AFilePath: string;
      out AContentType: AnsiString
    ): IBinaryData;
  public
    constructor Create(
      const AContent: IInternalBrowserLastContent
    );
  end;

implementation

uses
  u_BinaryData;

{ TInternalDomainInfoProviderByLastSearchResults }

constructor TInternalDomainInfoProviderByLastContent.Create(
  const AContent: IInternalBrowserLastContent);
begin
  inherited Create;
  FContent := AContent;
end;

function TInternalDomainInfoProviderByLastContent.BuildBinaryDataByText(
  const AText: string
): IBinaryData;
begin
  Result := nil;
  if AText <> '' then begin
    Result := TBinaryData.CreateByString(AText);
  end;
end;

function TInternalDomainInfoProviderByLastContent.LoadBinaryByFilePath(
  const AFilePath: string;
  out AContentType: AnsiString
): IBinaryData;
begin
  Result := nil;
  AContentType := 'text/html';
  Result := BuildBinaryDataByText(FContent.Content);
end;

end.
