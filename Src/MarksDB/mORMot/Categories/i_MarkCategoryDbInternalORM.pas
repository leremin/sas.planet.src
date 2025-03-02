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

unit i_MarkCategoryDbInternalORM;

interface

uses
  t_MarkSystemORM,
  i_Category,
  i_MarkCategory;

type
  IMarkCategoryDbInternalORM = interface
    ['{B68D1FBF-370E-4B58-84ED-F7BEAE2E2BE7}']
    function IsCategoryFromThisDb(const ACategory: ICategory): Boolean;
    function GetCategoryByID(const ID: TID): IMarkCategory;
    function GetFirstCategoryByName(const AName: string): IMarkCategory;
    function GetCategoryByNameCount(const AName: string): Integer;
  end;

implementation

end.
