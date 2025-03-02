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

unit i_StaticTreeItem;

interface

type
  IStaticTreeItem = interface
    ['{2304E423-3893-4869-A140-904D93F2B3EF}']
    function GetData: IInterface;
    property Data: IInterface read GetData;

    function GetName: string;
    property Name: string read GetName;

    function GetGroupName: string;
    property GroupName: string read GetGroupName;

    function GetSubItemCount: Integer;
    property SubItemCount: Integer read GetSubItemCount;

    function GetSubItem(AIndex: Integer): IStaticTreeItem;
    property SubItem[AIndex: Integer]: IStaticTreeItem read GetSubItem;
  end;

implementation

end.
