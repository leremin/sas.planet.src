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

unit i_TerrainProviderList;

interface

uses
  ActiveX,
  i_Notifier,
  i_InterfaceListStatic,
  i_TerrainProviderListElement;

type
  ITerrainProviderList = interface
    ['{34A0BB9F-8C6B-4664-B299-4F78710E0996}']
    function GetGUIDEnum: IEnumGUID;
    function Get(const AGUID: TGUID): ITerrainProviderListElement;
    function GetAddNotifier: INotifier;
    function GetSorted: IInterfaceListStatic;
  end;

implementation

end.
